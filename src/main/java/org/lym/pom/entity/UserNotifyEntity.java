package org.lym.pom.entity;

import lombok.Data;
import org.shoulder.data.mybatis.template.entity.BaseEntity;

/**
 * @author lym
 */
@Data
//@Entity
//@Table(name="tb_user_notify")
public class UserNotifyEntity extends BaseEntity {


    /**
     * 消息发送渠道
     *
     * @see org.lym.pom.repository.mongo.enums.NotifyChannelEnum
     */
    private String channel;

    /**
     * 通知类型
     *
     * @see org.lym.pom.repository.mongo.enums.NotifyTypeEnum
     */
    private String type;

    /**
     * 已读 Y N
     */
    private String read;

    /**
     * 触发人
     */
    private String sourceUserId;

    /**
     * 收件人
     */
    private String receiverUserId;

    /**
     * 标题
     */
    private String title;

    /**
     * 内容格式
     *
     * @see org.lym.pom.repository.mongo.enums.NotifyContentTypeEnum
     */
    private String contentType;

    /**
     * 内容
     */
    private String content;

}
