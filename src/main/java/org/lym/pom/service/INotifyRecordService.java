package org.lym.pom.service;

import org.lym.pom.dto.business.ThirdDependencyUpdateBO;
import org.lym.pom.entity.DependencyEntity;
import org.lym.pom.entity.NotifyRecordEntity;
import org.lym.pom.notify.event.CheckProjectAllDependenciesEvent;
import org.lym.pom.notify.event.ProjectReLoadEvent;
import org.springframework.lang.Nullable;

import java.util.Collection;
import java.util.List;

/**
 * 发送提醒任务
 * 每天早上 9 点执行
 *
 * @author lym
 */
public interface INotifyRecordService {


    /**
     * 保存待通知记录
     *
     * @param entities            要保存的
     * @param sendNotifyInstantly
     * @param notifyReason
     */
    void save(Collection<NotifyRecordEntity> entities, boolean sendNotifyInstantly, String notifyReason);

    /**
     * 查找所有记录
     * @param notified 已经通知过
     * @return List<NotifyRecordEntity>
     */
    List<NotifyRecordEntity> findAllByNotified(boolean notified);

    /**
     * 设置发送通知状态为已经发送，记录通知发送时间
     * @param notifiedRecordIds 需要更新的id
     */
    void setNotified(Collection<Long> notifiedRecordIds);

    void onCheckProjectAllDependenciesEvent(CheckProjectAllDependenciesEvent event);

    void onProjectReLoadEvent(ProjectReLoadEvent event);

    @Nullable
    NotifyRecordEntity tryCreateNotifyRecordEntity(DependencyEntity dependency, ThirdDependencyUpdateBO updateBO);
}
