package org.lym.pom.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextRefreshedEvent;

import java.util.HashMap;
import java.util.List;

@Configuration
@ConfigurationProperties(
        prefix = "pomupdate"
)
@Data
public class DependencyExtInfoProperties implements ApplicationListener<ContextRefreshedEvent> {

    private static final HashMap<String, DependencyExtInfo> cache = new HashMap<>();

    /**
     * yaml 里 map 带特殊字符不好处理，用list更容易读和维护
     */
    private List<DependencyExtInfo> extInfoList;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        synchronized (cache) {
            extInfoList.forEach(extInfo -> cache.put(extInfo.getId(), extInfo));
        }
    }

    public static DependencyExtInfo fetchExtInfoFromCache(String id) {
        return cache.get(id);
    }

    @Data
    public static class DependencyExtInfo {
        private String id;

        private String changeLogUrl;

        private String opensourceUrl;
    }
}