package org.lym.pom.repository;

import org.lym.pom.entity.ProjectEntity;
import org.springframework.data.jpa.repository.JpaRepository;

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
public interface IProjectRepository extends JpaRepository<ProjectEntity, Long> {

    List<ProjectEntity> findByUserId(String userId);
}
