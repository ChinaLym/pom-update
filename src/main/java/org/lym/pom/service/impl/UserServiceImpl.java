package org.lym.pom.service.impl;

import org.lym.pom.entity.UserEntity;
import org.lym.pom.repository.IUserRepository;
import org.lym.pom.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author lym
 */
@Service
public class UserServiceImpl implements IUserService {


    @Autowired
    private IUserRepository userRepository;

    @Override
    public void save(UserEntity userEntity){
        userRepository.save(userEntity);
    }

    @Override
    public UserEntity findById(String userId){
        return userRepository.findById(userId).orElse(null);
    }

    @Override
    public List<UserEntity> findByIds(Iterable<String> ids){
        return userRepository.findAllById(ids);
    }

}
