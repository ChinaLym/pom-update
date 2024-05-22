package org.lym.pom.config;

import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @author lym
 */
@Configuration
@EnableConfigurationProperties({DependencyExtInfoProperties.class})
public class ThirdExtInfoConfig {

}
