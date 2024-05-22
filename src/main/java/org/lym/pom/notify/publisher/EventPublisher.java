package org.lym.pom.notify.publisher;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;

/**
 * 事件发布者
 * @author lym
 */
@Service
public class EventPublisher implements ApplicationContextAware {


    private ApplicationContext context;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        context = applicationContext;
    }

    public void publish(Object event){
        context.publishEvent(event);
    }

}
