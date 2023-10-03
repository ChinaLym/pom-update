package org.lym.pom.service;

import org.lym.pom.dto.xml.ProjectDTO;
import org.lym.pom.entity.ProjectEntity;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author lym
 */
public interface IProjectService {

    /**
     * 单纯保存 project 和 dependencies 到数据库
     */
    default void save(ProjectDTO projectDTO){
        save(projectDTO, "1");
    }

    void save(ProjectDTO projectDTO, String userId);

    ProjectEntity findById(Long projectId);

    List<ProjectEntity> findByIds(Iterable<Long> projectIds);

    Map<Long, ProjectEntity> findMapByIds(Iterable<Long> projectIds);

    List<ProjectEntity> findByUserId(String userId);
}
