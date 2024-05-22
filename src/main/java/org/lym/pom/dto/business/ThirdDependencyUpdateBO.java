package org.lym.pom.dto.business;

import lombok.Data;
import org.lym.pom.entity.DependencyEntity;
import org.lym.pom.entity.DependencyIndex;
import org.lym.pom.entity.ThirdProjectEntity;

/**
 * 第三方依赖，发送了版本更新 Event
 *
 * @author lym
 */
@Data
public class ThirdDependencyUpdateBO {

    /**
     * 第三方依赖标识
     */
    private DependencyIndex dependencyIndex;

    /**
     * 更新后的版本
     */
    private String latestVersion;

    /**
     * 更新后的版本
     */
    private String latestStableVersion;


    /**
     * 暂时不支持更多的构造方法，主要是为了可以拿到更多的信息，如
     */
    public ThirdDependencyUpdateBO(DependencyIndex dependencyIndex, String latestVersion, String latestStableVersion) {
        this.dependencyIndex = dependencyIndex;
        this.latestVersion = latestVersion;
        this.latestStableVersion = latestStableVersion;
    }

}
