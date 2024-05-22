package org.lym.pom.notify.event;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.lym.pom.entity.DependencyIndex;

import java.util.Set;

/**
 * 依赖插入事件
 * 如新增 project，解析完它的依赖，保存到数据库
 * 查询更新第三方依赖中是否对这些依赖做了追踪，若未追踪则添加追踪，并立即尝试获取版本号
 * @author lym
 */
@Data
@AllArgsConstructor
public class DependencyInsertEvent {

    private Long projectId;

    private Set<DependencyIndex> dependencyIndices;

    private boolean sendNotifyInstantlyAfterVersionCheck;

    private String notifyReason;

}
