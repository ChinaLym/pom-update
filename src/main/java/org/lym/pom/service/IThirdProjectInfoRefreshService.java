package org.lym.pom.service;

import org.lym.pom.entity.ThirdProjectEntity;

/**
 * @author lym
 */
public interface IThirdProjectInfoRefreshService {

    /**
     * 根据远程仓库同步最新信息
     */
    void refreshInfo(ThirdProjectEntity thirdProject) throws Exception;

}
