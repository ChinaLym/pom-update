package org.lym.pom.notify.event;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.lym.pom.entity.NotifyRecordEntity;

import java.util.List;

/**
 * 检查一个 project 所有依赖是否有新版本【本地检查，不向中央仓库同步】，如果有，则创建待通知记录
 *
 * @author lym
 */
@Data
@AllArgsConstructor
public class SendNotifyEvent {

    private List<NotifyRecordEntity> toNotifiedRecordList;

    private String notifyReason;

}
