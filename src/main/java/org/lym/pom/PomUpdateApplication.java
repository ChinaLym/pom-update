package org.lym.pom;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Indexed;

/**
 * pom update app
 *
 * @author lym
 */
@Indexed
@EnableAsync
@EnableScheduling
@SpringBootApplication
@EntityScan("org.lym.pom.entity")
//@EnableTransactionManagement(proxyTargetClass = true)
//@ImportAutoConfiguration(DruidDataSourceAutoConfigure.class)// spring boot3 兼容 druid
public class PomUpdateApplication {

    public static void main(String[] args) {
        SpringApplication.run(PomUpdateApplication.class, args);
    }

}
