package org.lym.pom.config;

import org.lym.pom.annotation.ThirdProjectInfoSpider;
import org.lym.pom.util.HttpsClientRequestFactory;
import org.lym.pom.util.UserAgentInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.client.RestTemplate;

import java.util.Properties;

/**
 * @author lym
 */
@Configuration
public class VersionClientConfig {

    /**
     * 专门用来获取版本号的客户端
     * @return RestTemplate
     */
    @Bean
    @ThirdProjectInfoSpider
    public RestTemplate versionClient() {
        RestTemplate rest = new RestTemplate(new HttpsClientRequestFactory());
        rest.getInterceptors().add(new UserAgentInterceptor());
        return rest;
    }

}
