package org.lym.pom.service;

import org.lym.pom.constant.NewVersionNotifyStrategyEnum;
import org.lym.pom.dto.xml.DependencyBaseDTO;
import org.lym.pom.entity.DependencyEntity;

import java.util.List;

/**
 * 订阅推送服务
 * @author lym
 */
public interface IDependencyService {
    /**
     * 获取所有某第三方依赖记录
     * @return DependencyEntities
     */
    List<DependencyEntity> findByIndex(String groupId, String artifactId);

    List<DependencyEntity> findAllByProjectId(Long projectId);

    void saveDependencies(List<? extends DependencyBaseDTO> dependencyDTOList, Long projectId);

    void update(DependencyEntity dependency);

    void update(List<DependencyEntity> dependencies);

    void deleteByProjectId(Long projectId);

    void updateAllNotifyStrategyByProjectId(Long projectId, NewVersionNotifyStrategyEnum newVersionNotifyStrategy);
}
