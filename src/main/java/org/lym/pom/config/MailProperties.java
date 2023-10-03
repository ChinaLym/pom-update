package org.lym.pom.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.nio.charset.Charset;
import java.util.Map;

@ConfigurationProperties(
    prefix = "shoulder.mail"
)
@Data
public class MailProperties {
    private String host;
    private Integer port;
    private String senderName;
    private String username;
    private String password;
    private String protocol = "smtp";
    private Charset defaultEncoding;
    private Map<String, String> properties;
    private String jndiName;
}