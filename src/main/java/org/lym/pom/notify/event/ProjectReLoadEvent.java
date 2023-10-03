package org.lym.pom.notify.event;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 用户的项目重新加载事件，一般发生于用户上传已经上传过的 pom.xml
 * 删除通知记录中 projectId 且待通知的记录
 * 该事件不建议异步，若该事件处理过慢，会导致新生成的通知也会被删掉
 *
 * @author lym
 */
@Data
@AllArgsConstructor
public class ProjectReLoadEvent {

    private Long projectId;

}
