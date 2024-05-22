package org.lym.pom.service.impl;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.lym.pom.config.MailProperties;
import org.lym.pom.dto.business.NotifyEmailBO;
import org.lym.pom.service.INotifySendService;
import org.shoulder.core.exception.BaseRuntimeException;
import org.shoulder.core.log.AppLoggers;
import org.shoulder.core.log.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @author lym
 */
@Service
public class NotifySendServiceImpl implements INotifySendService {

    private final Logger log = AppLoggers.APP_SERVICE;

    private final ThreadPoolExecutor executor = new ThreadPoolExecutor(5, 5, 30, TimeUnit.SECONDS, new LinkedBlockingDeque<>(300));

    @Autowired
    private JavaMailSenderImpl sender;

    @Autowired
    private MailProperties mailProperties;

    @Async
    @Override
    public void sendEmailNotify(Collection<NotifyEmailBO> notifyEmailBOList) {
        log.info("emailToSend.size=" + notifyEmailBOList.size());
        notifyEmailBOList.forEach(this::sendEmail);
        log.info("emailToSend finished.");
    }

    private void sendEmail(NotifyEmailBO notifyEmailBO) {
        executor.execute(() -> {
            MimeMessage message = sender.createMimeMessage();
            try {
                MimeMessageHelper helper = new MimeMessageHelper(message, true);
                //发送人
                helper.setFrom(mailProperties.getSenderName());
                //接收人
                helper.setTo(notifyEmailBO.getEmail());
                //抄送人
                //helper.setBcc();
                //邮件标题
                helper.setSubject(notifyEmailBO.getSubject());
                //true代表支持html，邮件内容
                String tail = "</br></br> Power by <a href=\"autoPom.itlym.cn\">autoPom.itlym.cn</a>.";
                helper.setText(notifyEmailBO.getContent() + tail, true);
                sender.send(message);
            } catch (MessagingException e) {
                throw new BaseRuntimeException(e);
            }
        });

    }

    private void sendFakerEmail(NotifyEmailBO notifyEmailBO) {
        executor.execute(() -> {
            System.out.println("SEND EMAIL TO " + notifyEmailBO.getEmail() + "...........");
            System.out.println("SUBJECT");
            System.out.println(notifyEmailBO.getSubject());
            System.out.println("CONTENT:");
            System.out.println(notifyEmailBO.getContent());
        });

    }

}
