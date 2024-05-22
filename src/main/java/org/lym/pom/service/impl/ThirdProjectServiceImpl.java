package org.lym.pom.service.impl;

import cn.hutool.core.util.StrUtil;
import org.lym.pom.constant.ThirdProjectVersionStatusEnum;
import org.lym.pom.dto.business.ThirdDependencyUpdateBO;
import org.lym.pom.entity.DependencyEntity;
import org.lym.pom.entity.DependencyIndex;
import org.lym.pom.entity.ThirdProjectEntity;
import org.lym.pom.notify.event.CheckProjectAllDependenciesEvent;
import org.lym.pom.notify.event.DependencyInsertEvent;
import org.lym.pom.notify.publisher.EventPublisher;
import org.lym.pom.repository.IThirdProjectRepository;
import org.lym.pom.service.IThirdProjectInfoRefreshService;
import org.lym.pom.service.IThirdProjectService;
import org.shoulder.core.log.AppLoggers;
import org.shoulder.core.log.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpServerErrorException;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 第三方依赖查询
 *
 * @author lym
 */
@Service
public class ThirdProjectServiceImpl implements IThirdProjectService {

    private final Logger log = AppLoggers.APP_SERVICE;

    @Autowired
    private IThirdProjectRepository thirdProjectRepository;

    @Autowired
    private IThirdProjectInfoRefreshService thirdProjectInfoRefreshService;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private EventPublisher eventPublisher;

    /**
     * 依赖项插入后，检查数据库是否已有，以及最新版本信息
     */
    @EventListener(DependencyInsertEvent.class)
    public void onDependencyInsertEvent(DependencyInsertEvent dependencyInsertEvent) {
        Set<DependencyIndex> dependencyIndices = dependencyInsertEvent.getDependencyIndices();

        /*String sql = "SELECT group_id as groupId, artifact_id as artifactId from tb_third_project where id in (:ids)";
        NamedParameterJdbcTemplate template =
                new NamedParameterJdbcTemplate(jdbcTemplate.getDataSource());
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("ids", ids);
        parameters.addValue("updateTime", new Date());
        template.update(sql, parameters);

        List<DependencyIndex> dependencyIndices = thirdProjectRepository.findAllId();*/

        // SQL 优化 DONE，只查 id，目前复杂度为(n + 0.5n² - n，m * n) 查 n 条，数据库共 m 条

        List<ThirdProjectEntity> thirdProjectEntitiesInDB = this.findByIds(dependencyIndices);
        if (thirdProjectEntitiesInDB.size() < dependencyIndices.size()) {
            // 数据库中缺少，插入缺少的
            thirdProjectEntitiesInDB.forEach(
                    thirdProjectEntity -> dependencyIndices.remove(thirdProjectEntity.getId())
            );

            List<ThirdProjectEntity> toSave = dependencyIndices.stream().map(id -> {
                ThirdProjectEntity entity = new ThirdProjectEntity();
                entity.setId(id);
                entity.setStatus(ThirdProjectVersionStatusEnum.BORN.getStatus());
                return entity;
            }).collect(Collectors.toList());
            // 这些不存在，所以需要立即检测最新版本并保存 todo【性能】这里可以并行优化
            toSave.forEach(this::checkUpdateAndSave);
            thirdProjectEntitiesInDB.addAll(toSave);
        }
        eventPublisher.publish(
                new CheckProjectAllDependenciesEvent(dependencyInsertEvent.getProjectId(),
                        thirdProjectEntitiesInDB,
                        dependencyInsertEvent.isSendNotifyInstantlyAfterVersionCheck(),
                        dependencyInsertEvent.getNotifyReason()
                )
        );
    }

    @Override
    public void save(List<ThirdProjectEntity> entities) {
        thirdProjectRepository.saveAll(entities);
    }

    @Override
    public ThirdProjectEntity save(ThirdProjectEntity entity) {
        return thirdProjectRepository.save(entity);
    }

    @Override
    public ThirdProjectEntity findById(DependencyIndex dependencyIndex) {
        return thirdProjectRepository.findById(dependencyIndex).orElse(null);
    }

    @Override
    public List<ThirdProjectEntity> findByIds(Iterable<DependencyIndex> dependencyIndex) {
        return thirdProjectRepository.findAllById(dependencyIndex);
    }

    @Override
    public Map<DependencyIndex, ThirdProjectEntity> findMapByIds(Iterable<DependencyIndex> dependencyIndex) {
        List<ThirdProjectEntity> thirdProjectEntities = findByIds(dependencyIndex);

        Map<DependencyIndex, ThirdProjectEntity> map = new HashMap<>(thirdProjectEntities.size());
        thirdProjectEntities.forEach(
                thirdProjectEntity -> {
                    map.put(thirdProjectEntity.getId(), thirdProjectEntity);
                }
        );
        return map;
    }

    /**
     * 【低优先】主要解决插入完了可以立马创建待通知记录，不必等定时任务拉
     *
     * @param dependencies
     */
    @Override
    public void compareAndSave(List<DependencyEntity> dependencies) {
        // 组装 id
        List<DependencyIndex> indexes = getIndexes(dependencies);

        // 1. 先查旧的

        Map<DependencyIndex, ThirdProjectEntity> indexedThirdProjectMap = this.findMapByIds(indexes);

        // 2. 对比 id 把数据库里没有的直接保存, 对比已有的依赖的版本号，将版本号过期的筛选出来返回

        List<ThirdProjectEntity> toSaveThirdDependencies = new ArrayList<>();
        List<DependencyEntity> hasLatestVersion = new LinkedList<>();

        for (DependencyIndex index : indexes) {
            ThirdProjectEntity dbThirdProjectEntity = indexedThirdProjectMap.get(index);
            if (dbThirdProjectEntity == null) {
                // todo 【低优先】创建新第三方依赖
                ThirdProjectEntity thirdProjectEntity = new ThirdProjectEntity();
                thirdProjectEntity.setId(index);
                thirdProjectEntity.setStatus(ThirdProjectVersionStatusEnum.BORN.getStatus());
                toSaveThirdDependencies.add(thirdProjectEntity);

            } else {
                // todo 【低优先】已存在，对比版本，直接创建通知记录，等待第二天
                if (ThirdProjectVersionStatusEnum.NORMAL.getStatus().equals(dbThirdProjectEntity.getStatus())) {
                    // 且有更新，add hasLatestVersion，添加待更新通知
                    String stableVersion = dbThirdProjectEntity.getStableVersion();
                    String latestVersion = dbThirdProjectEntity.getVersion();
                    // #genNotifyRecordEntities 创建通知记录
                }

            }
        }
        // 只将第三方依赖存入数据库，依赖定时更新
        save(toSaveThirdDependencies);


    }

    /*private List<ThirdDependencyUpdateBO> genThirdDependencyUpdateBO(DependencyEntity dependencyEntity){
        // todo 【低优先】从 db 查第三方依赖完整信息
        ThirdProjectEntity thirdProjectEntity = new ThirdProjectEntity();
        DependencyIndex id = new DependencyIndex(dependencyEntity.getGroupId(), dependencyEntity.getArtifactId());
        thirdProjectEntity.setId(id);
        // 然后生成
        return new ThirdDependencyUpdateBO(thirdProjectEntity, dependencyEntity.getVersion());

    }*/

    private List<DependencyIndex> getIndexes(List<DependencyEntity> dependencies) {
        List<DependencyIndex> indexes = new ArrayList<>(dependencies.size());
        for (DependencyEntity dependencyEntity : dependencies) {
            DependencyIndex index = new DependencyIndex(dependencyEntity.getGroupId(),
                    dependencyEntity.getArtifactId());
            indexes.add(index);
        }
        return indexes;
    }


    @Override
    public List<ThirdDependencyUpdateBO> checkAndUpdateAll() {
        // 当前只解析了 tb_third 中的，极小概率可能刚添加， project 中有，但third中没有，等待下次触发就好了
        // todo 【性能｜因定时任务触发、低优先改造】分批查 查找时只列出最近3天没有更新的、并行去检查
        List<ThirdProjectEntity> allThirdProjects = findAll();
        return allThirdProjects.stream()
                .map(this::checkUpdateAndSave)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    /**
     * 获取所有
     */
    private List<ThirdProjectEntity> findAll() {
        return thirdProjectRepository.findAll();
    }

    /**
     * 获取更新状态 ThirdDependencyUpdateBO【注意该方法为同步调用，若要异步需要调用方使用线程】
     *
     * @param thirdProjectEntity thirdProjectEntity
     * @return 第三方依赖，发送了版本更新 ThirdDependencyUpdateBO 否则返回 null
     */
    @Nullable
    private ThirdDependencyUpdateBO checkUpdateAndSave(ThirdProjectEntity thirdProjectEntity) {
        String currentVersion = thirdProjectEntity.getVersion();
        String currentStableVersion = thirdProjectEntity.getStableVersion();
        Date updateTime = new Date();
        try {
            thirdProjectInfoRefreshService.refreshInfo(thirdProjectEntity);
            thirdProjectEntity.setStatus(ThirdProjectVersionStatusEnum.NORMAL.getStatus());
        } catch (HttpServerErrorException serverEx) {
            log.error("第三方依赖信息源不可访问", serverEx);
        } catch (Exception e) {
            log.error("刷新第三方依赖信息失败！", e);
            thirdProjectEntity.setStatus(ThirdProjectVersionStatusEnum.EXCEPTION.getStatus());
        }
        thirdProjectEntity.setUpdateTime(updateTime);
        save(thirdProjectEntity);
        // 是否进行了版本更新
        String latestVersion = thirdProjectEntity.getVersion();
        // 认为中央仓库的版本是最新的，忽略中央仓库版本比当前更低，只要不相等，就是出新版本了
        if (StrUtil.equals(currentVersion, latestVersion)) {
            // noNewVersion
            return null;
        }
        return new ThirdDependencyUpdateBO(thirdProjectEntity.getId(), latestVersion, thirdProjectEntity.getStableVersion());
    }

}
