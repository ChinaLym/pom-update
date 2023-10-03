package org.lym.pom.dto.business;

import lombok.Data;

/**
 * @author lym
 */
@Data
public class NotifyEmailBO {

    /** 接收者邮件 */
    private String email;

    /** 邮件主题 */
    private String subject;

    /** 邮件内容 */
    private String content;

}
