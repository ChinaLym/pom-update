package org.lym.pom.repository;

import org.lym.pom.entity.DependencyEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
* Description: DAO. 
*   Deal directly with the database, 
*   if you customize the query, take the index first
* 
* 		Please follow the prefix convention below
*
*   getOne ------------ getXXX
*   getMultiple ------- listXXX
*   count ------------- countXXX
*   getOne ------------ getXXX
*   insert ------------ saveXXX
*   delete ------------ deleteXXX
*   modify ------------ updateXXX
*
 * @author lym
 */
public interface IDependencyRepository extends JpaRepository<DependencyEntity, Long> {

    /**
     * 根据 groupId artifactId
     * @return DependencyEntity
     */
    List<DependencyEntity> findByGroupIdAndArtifactId(String groupId, String artifactId);

    @Transactional
    void deleteByProjectId(Long projectId);

    List<DependencyEntity> findByProjectId(Long projectId);
}
