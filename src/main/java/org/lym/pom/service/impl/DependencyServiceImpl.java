package org.lym.pom.service.impl;

import org.lym.pom.constant.ContextKey;
import org.lym.pom.constant.NewVersionNotifyStrategyEnum;
import org.lym.pom.dto.xml.DependencyBaseDTO;
import org.lym.pom.entity.DependencyEntity;
import org.lym.pom.entity.DependencyIndex;
import org.lym.pom.notify.event.DependencyInsertEvent;
import org.lym.pom.notify.publisher.EventPublisher;
import org.lym.pom.repository.IDependencyRepository;
import org.lym.pom.service.IDependencyService;
import org.shoulder.core.context.AppContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSourceUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 订阅推送服务
 *
 * @author lym
 */
@Service
public class DependencyServiceImpl implements IDependencyService {

    @Autowired
    private IDependencyRepository dependencyRepository;

    @Autowired
    private EventPublisher eventPublisher;


    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * 从项目依赖表获取所有(groupId, artifactId) 且lastVersion与 newVersion 不相同的 DependencyEntity
     */
    @Override
    public List<DependencyEntity> findByIndex(String groupId, String artifactId) {
        return dependencyRepository.findByGroupIdAndArtifactId(groupId, artifactId);
    }

    private List<DependencyEntity> createDependencies(List<? extends DependencyBaseDTO> dependencyDTOList, Long projectId) {
        List<DependencyEntity> dependencies = new ArrayList<>(dependencyDTOList.size());
        for (DependencyBaseDTO dependencyDTO : dependencyDTOList) {
            DependencyEntity dependencyEntity = new DependencyEntity();
            dependencyEntity.setGroupId(dependencyDTO.getGroupId());
            dependencyEntity.setArtifactId(dependencyDTO.getArtifactId());
            dependencyEntity.setProjectId(projectId);
            dependencyEntity.setVersion(dependencyDTO.getVersion());
            dependencies.add(dependencyEntity);
        }
        return dependencies;
    }


    @Override
    public void saveDependencies(List<? extends DependencyBaseDTO> dependencyDTOList, Long projectId) {
        List<DependencyEntity> dependencyEntities = createDependencies(dependencyDTOList, projectId);

        // 删除已有的
        deleteByProjectId(projectId);
        // 保存
        save(dependencyEntities);

        // 发布插入事件
        Set<DependencyIndex> dependencyIndices = dependencyEntities.stream().map(
                dependencyEntity -> new DependencyIndex(dependencyEntity.getGroupId(), dependencyEntity.getArtifactId())
        ).collect(Collectors.toSet());
        DependencyInsertEvent event = new DependencyInsertEvent(projectId, dependencyIndices,
                AppContext.getOrDefault(ContextKey.NOTIFY_INSTANTLY_AFTER_CHECK, false),
                AppContext.getOrDefault(ContextKey.NOTIFY_REASON, null)
        );
        eventPublisher.publish(event);

    }

    @Override
    public void deleteByProjectId(Long projectId) {
        String sql = "delete from tb_dependency where project_id = ?";
        jdbcTemplate.update(sql, projectId);
    }

    @Override
    public void updateAllNotifyStrategyByProjectId(Long projectId, NewVersionNotifyStrategyEnum newVersionNotifyStrategy) {
        String sql = "update tb_dependency set new_version_notify_strategy = ? where project_id = ?";
        jdbcTemplate.update(sql, newVersionNotifyStrategy.getValue(), projectId);
    }

    @Override
    public List<DependencyEntity> findAllByProjectId(Long projectId) {
        return dependencyRepository.findByProjectId(projectId);
    }

    @Override
    public void update(DependencyEntity dependency) {
        dependencyRepository.save(dependency);
    }

    @Override
    public void update(List<DependencyEntity> dependencies) {
        dependencyRepository.saveAll(dependencies);
    }


    private void save(List<DependencyEntity> dependencyEntities) {

        NamedParameterJdbcTemplate namedParameterJdbcTemplate =
                new NamedParameterJdbcTemplate(jdbcTemplate.getDataSource());
        //批量转数组
        SqlParameterSource[] beanSources = SqlParameterSourceUtils.createBatch(dependencyEntities.toArray());
        String sql = "INSERT INTO tb_dependency(project_id, group_id, artifact_id, version, new_version_notify_strategy)" +
                " VALUES (:projectId, :groupId, :artifactId, :version, :newVersionNotifyStrategy)";

        namedParameterJdbcTemplate.batchUpdate(sql, beanSources);

        //dependencyRepository.saveAll(dependencyEntities);
    }

}
