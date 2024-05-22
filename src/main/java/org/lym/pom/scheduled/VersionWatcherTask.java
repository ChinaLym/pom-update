package org.lym.pom.scheduled;

import org.lym.pom.dto.business.ThirdDependencyUpdateBO;
import org.lym.pom.entity.DependencyEntity;
import org.lym.pom.entity.NotifyRecordEntity;
import org.lym.pom.service.IDependencyService;
import org.lym.pom.service.INotifyRecordService;
import org.lym.pom.service.IThirdProjectService;
import org.shoulder.core.log.AppLoggers;
import org.shoulder.core.log.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.LinkedList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 版本号监视器任务
 * 每 4 小时执行一次
 *
 * @author lym
 */
@Service
public class VersionWatcherTask {

    private final Logger log = AppLoggers.APP_DAEMON;

    @Autowired
    private IThirdProjectService thirdProjectService;

    @Autowired
    private IDependencyService dependencyService;

    @Autowired
    private INotifyRecordService notifyRecordService;

    /**
     * 检查所有第三方依赖是否有新版本
     */
    @Scheduled(cron = "0 0 0/4 * * ?")
    @Transactional(rollbackFor = Exception.class)
    public void checkDependenciesHasUpdate() {

        log.info("ready to check Dependencies has update...");

        // 获取有新版本的第三方依赖
        List<ThirdDependencyUpdateBO> updateInfoList = thirdProjectService.checkAndUpdateAll();

        if (CollectionUtils.isEmpty(updateInfoList)) {
            log.info("not thirdDependency has updated.");
        } else {
            log.info("updatedThirdDependencyInfoList.size=" + updateInfoList.size());
        }

        // 待通知记录 todo 【性能】分成另一个任务，查找最近通知时间大于3天的
        List<NotifyRecordEntity> toNotifyRecords = genNotifyRecordEntities(updateInfoList);
        // 保存待通知记录
        notifyRecordService.save(toNotifyRecords, false, null);

        log.info("Finished checking dependenciesHasUpdate TASK!");
    }

    /**
     * 根据变更信息待通知记录
     */
    private List<NotifyRecordEntity> genNotifyRecordEntities(List<ThirdDependencyUpdateBO> updateInfoList) {
        List<NotifyRecordEntity> toNotifyRecords = new LinkedList<>();

        for (ThirdDependencyUpdateBO updateBO : updateInfoList) {
            List<DependencyEntity> dependencyEntities = dependencyService.findByIndex(updateBO.getDependencyIndex().getGroupId(),
                    updateBO.getDependencyIndex().getArtifactId());

            if (CollectionUtils.isEmpty(dependencyEntities)) {
                continue;
            }
            // 获取需要发送提醒的工程的id
            toNotifyRecords.addAll(dependencyEntities.stream().map(d -> notifyRecordService.tryCreateNotifyRecordEntity(d, updateBO))
                    .filter(Objects::nonNull).collect(Collectors.toList()));
        }
        return toNotifyRecords;
    }

}
