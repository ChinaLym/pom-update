package org.lym.pom.service;

import org.lym.pom.entity.UserEntity;

import java.util.List;

/**
 * @author lym
 */
public interface IUserService {

    void save(UserEntity userEntity);

    UserEntity findById(String userId);

    List<UserEntity> findByIds(Iterable<String> ids);
}
