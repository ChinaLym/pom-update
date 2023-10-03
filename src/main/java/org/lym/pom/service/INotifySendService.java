package org.lym.pom.service;

import org.lym.pom.dto.business.NotifyEmailBO;

import java.util.Collection;

/**
 * @author lym
 */
public interface INotifySendService {

    /**
     * 逐一发送邮件
     * @param notifyEmailBOList 待发送邮件
     */
    void sendEmailNotify(Collection<NotifyEmailBO> notifyEmailBOList);

}
