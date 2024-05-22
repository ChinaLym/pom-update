package org.lym.pom.service;

import org.lym.pom.dto.business.ThirdDependencyUpdateBO;
import org.lym.pom.entity.DependencyEntity;
import org.lym.pom.entity.DependencyIndex;
import org.lym.pom.entity.ThirdProjectEntity;

import java.util.List;
import java.util.Map;

/**
 * @author lym
 */
public interface IThirdProjectService {

    void save(List<ThirdProjectEntity> entities);

    ThirdProjectEntity save(ThirdProjectEntity entity);

    ThirdProjectEntity findById(DependencyIndex dependencyIndex);

    List<ThirdProjectEntity> findByIds(Iterable<DependencyIndex> dependencyIndex);

    Map<DependencyIndex, ThirdProjectEntity> findMapByIds(Iterable<DependencyIndex> dependencyIndex);

    void compareAndSave(List<DependencyEntity> dependencies);


    /**
     * 获取有新版本的第三方依赖
     *
     * @return 有更新的依赖
     */
    List<ThirdDependencyUpdateBO> checkAndUpdateAll();


}
