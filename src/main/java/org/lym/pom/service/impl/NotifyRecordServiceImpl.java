package org.lym.pom.service.impl;

import cn.hutool.core.util.StrUtil;
import org.lym.pom.constant.NewVersionNotifyStrategyEnum;
import org.lym.pom.dto.business.ThirdDependencyUpdateBO;
import org.lym.pom.entity.DependencyEntity;
import org.lym.pom.entity.DependencyIndex;
import org.lym.pom.entity.NotifyRecordEntity;
import org.lym.pom.notify.event.CheckProjectAllDependenciesEvent;
import org.lym.pom.notify.event.ProjectReLoadEvent;
import org.lym.pom.notify.event.SendNotifyEvent;
import org.lym.pom.notify.publisher.EventPublisher;
import org.lym.pom.repository.INotifyRecordRepository;
import org.lym.pom.service.IDependencyService;
import org.lym.pom.service.INotifyRecordService;
import org.lym.pom.service.impl.select.VersionSelectorManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.lang.Nullable;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author lym
 */
@Service
public class NotifyRecordServiceImpl implements INotifyRecordService {

    @Autowired
    private INotifyRecordRepository notifyRecordRepository;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private IDependencyService dependencyService;

    @Autowired
    private EventPublisher eventPublisher;

    @Override
    @Transactional
    public void save(Collection<NotifyRecordEntity> entities, boolean sendNotifyInstantly, String notifyReason) {
        /// 先查出待发送通知的，如果新 version 相同，则不保存
        // 优化 db lock
        Set<NotifyRecordEntity> dbRecords = new HashSet<>(findAllByNotified(false));
        List<NotifyRecordEntity> toSaveRecords = entities.stream()
                .filter(r -> !dbRecords.contains(r)).collect(Collectors.toList());
        notifyRecordRepository.saveAll(toSaveRecords);
        // unlock
        if (sendNotifyInstantly) {
            eventPublisher.publish(new SendNotifyEvent(toSaveRecords, notifyReason));
        }
    }

    /**
     * todo 【性能】 可以考虑走索引
     */
    @Override
    public List<NotifyRecordEntity> findAllByNotified(boolean notified) {
        return notifyRecordRepository.findAllByNotified(notified);
    }

    @Override
    public void setNotified(Collection<Long> ids) {
        if (CollectionUtils.isEmpty(ids)) {
            return;
        }

        String sql = "UPDATE tb_notify_record set notified=true, notify_time=(:updateTime) where id in (:ids)";
        NamedParameterJdbcTemplate template =
                new NamedParameterJdbcTemplate(Objects.requireNonNull(jdbcTemplate.getDataSource()));
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("ids", ids);
        parameters.addValue("updateTime", new Date());
        template.update(sql, parameters);
    }


    /**
     * 添加了工程，检查它的依赖
     *
     * @param event 工程添加，检查它的所有更新，生成待通知记录
     */
    @Async
    @Transactional
    @EventListener(CheckProjectAllDependenciesEvent.class)
    @Override
    public void onCheckProjectAllDependenciesEvent(CheckProjectAllDependenciesEvent event) {
        Long projectId = event.getProjectId();
        // 避免重复通知，保险起见，先删除；一般还没有新建，相当于什么都没删
        notifyRecordRepository.deleteByProjectIdAndNotified(projectId, false);

        // 找出所有依赖项
        List<DependencyEntity> dependencyEntities = dependencyService.findAllByProjectId(projectId);
        Map<DependencyIndex, ThirdDependencyUpdateBO> map = event.getThirdProjectEntities().stream()
                .map(d -> new ThirdDependencyUpdateBO(d.getId(), d.getVersion(), d.getStableVersion()))
                .collect(Collectors.toMap(ThirdDependencyUpdateBO::getDependencyIndex, d -> d, (d1, d2) -> d2));

        // 筛选出需要通知的
        List<NotifyRecordEntity> toNotifyRecords = dependencyEntities.stream()
                .map(d ->
                        tryCreateNotifyRecordEntity(d, map.get(new DependencyIndex(d.getGroupId(), d.getArtifactId())))
                )
                .filter(Objects::nonNull)
                .collect(Collectors.toList());

        // 保存通知记录
        save(toNotifyRecords, event.isSendNotifyInstantly(), event.getNotifyReason());
    }

    /**
     * 删除未发送的通知
     *
     * @param event 工程更新事件
     */
    @Async
    @EventListener(ProjectReLoadEvent.class)
    @Override
    public void onProjectReLoadEvent(ProjectReLoadEvent event) {
        Long projectId = event.getProjectId();
        notifyRecordRepository.deleteByProjectIdAndNotified(projectId, false);
        // 这里未重新检测该工程，因此若该工程的依赖有更新版必须等待下次检测后才能收到通知
    }


    @Override
    @Nullable
    public NotifyRecordEntity tryCreateNotifyRecordEntity(DependencyEntity dependency, ThirdDependencyUpdateBO updateBO) {
        // todo 【功能增强】从 user 表中查询推送策略
        boolean ignore = NewVersionNotifyStrategyEnum.IGNORE.getValue().equals(dependency.getNewVersionNotifyStrategy());
        if (ignore) {
            return null;
        }
        boolean alwaysNotify = NewVersionNotifyStrategyEnum.ALWAYS.getValue().equals(dependency.getNewVersionNotifyStrategy());
        boolean notifyWhenStableAndStableUpdate = NewVersionNotifyStrategyEnum.STABLE_ONLY.getValue().equals(dependency.getNewVersionNotifyStrategy())
                && !StrUtil.equals(dependency.getVersion(), updateBO.getLatestStableVersion());
        if (alwaysNotify || notifyWhenStableAndStableUpdate) {
            if (VersionSelectorManager.getVersionSelector("")
                    .getComparator()
                    .compare(updateBO.getLatestVersion(), dependency.getVersion()) <= 0) {
                // 特殊的 dependency 的 version 太高了，比检测到最新的还高，认为没更新
                return null;
            }

            Long projectId = dependency.getProjectId();
            return new NotifyRecordEntity(
                    projectId,
                    dependency.getGroupId(),
                    dependency.getArtifactId(),
                    dependency.getVersion(),
                    // 目标版本 = 最新版
                    alwaysNotify ? updateBO.getLatestVersion() :
                            // 目标版本 = 最新稳定版
                            updateBO.getLatestStableVersion()
            );
        }
        return null;
    }

}
