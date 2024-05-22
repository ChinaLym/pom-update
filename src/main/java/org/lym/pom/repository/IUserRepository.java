package org.lym.pom.repository;

import org.lym.pom.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

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
public interface IUserRepository extends JpaRepository<UserEntity, String> {

}
