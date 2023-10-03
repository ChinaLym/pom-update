package org.lym.pom.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import org.lym.pom.dto.xml.*;
import org.lym.pom.entity.ProjectEntity;
import org.lym.pom.notify.event.ProjectReLoadEvent;
import org.lym.pom.notify.publisher.EventPublisher;
import org.lym.pom.repository.IProjectRepository;
import org.lym.pom.service.IProjectService;
import org.shoulder.core.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * project Business
 * @author lym
 */
@Service
public class ProjectServiceImpl implements IProjectService {

    @Autowired
    private IProjectRepository projectRepository;

    @Autowired
    private DependencyServiceImpl dependencyService;

    @Autowired
    private EventPublisher eventPublisher;

    @Override
    @Transactional
    public void save(ProjectDTO projectDTO, String userId) {
        ProjectEntity projectEntity = createProject(projectDTO, userId);
        projectEntity = save(projectEntity);
        List<? extends DependencyBaseDTO> dependencyDTOList = getAllDependenciesWithVersion(projectDTO);
        dependencyService.saveDependencies(dependencyDTOList, projectEntity.getId());
    }

    /**
     * 获取所有需要管理版本的依赖，包含 dependencyManager.dependencies 和 dependencies 的依赖
     * @param projectDTO pom.xml DTO
     * @return 需要管理版本的依赖
     */
    public List<? extends DependencyBaseDTO> getAllDependenciesWithVersion(ProjectDTO projectDTO) {
        // 【1】收集需要管理的依赖

        List<DependencyDTO> directoryDependencies = projectDTO.getDependencies();
        // todo 【优化校验】确保每个 dependency 是惟一的
        // 1. build.dependencies
        List<DependencyBaseDTO> dependencies = new ArrayList<>(directoryDependencies);
        // 2. parent
        if(projectDTO.getParent() != null) {
            dependencies.add(projectDTO.getParent());
        }
        // 3. build.dependencyManagement.dependencies
        Optional.ofNullable(projectDTO.getDependencyManagement())
                .map(DependencyManagementDTO::getDependencies)
                .filter(CollectionUtil::isNotEmpty)
                .ifPresent(dependencies::addAll);
        // todo 【优化校验】 plugin 的默认 groupId = org.apache.maven.plugins
        // 4. build.plugins
        Optional.ofNullable(projectDTO.getBuild())
                .map(BuildDTO::getPlugins)
                .filter(CollectionUtil::isNotEmpty)
                .ifPresent(dependencies::addAll);
        // 5. build.pluginManagement.plugins
        Optional.ofNullable(projectDTO.getBuild())
                .map(BuildDTO::getPluginManagement)
                .map(PluginManagementDTO::getPlugins)
                .filter(CollectionUtil::isNotEmpty)
                .ifPresent(dependencies::addAll);

        // 【2】 填充版本
        final Map<String, String> properties = trimProperties(projectDTO.getProperties());
        fillVersionFromProperties(dependencies, properties);

        // 【3】去掉没有版本的依赖项，这些由 parent / dependencyManager.pom 已经接管了，只需要关心parent/dependencyManager.pom版本即可
        List<DependencyBaseDTO> dependenciesWithVersion =
                dependencies.stream()
                        .filter(dependency -> dependency.getVersion() != null)
                        .collect(Collectors.toList());

        return dependenciesWithVersion;
    }

    /**
     * properties 去掉多余的空格
     */
    private Map<String, String> trimProperties(Map<String, String> properties) {
        Map<String, String> trimmedProperties = new HashMap<>(properties.size());
        for (Map.Entry<String, String> entry : properties.entrySet()) {
            trimmedProperties.put(entry.getKey().trim(), entry.getValue().trim());
        }
        return trimmedProperties;
    }

    /**
     * 将 ${xxx} 格式的 version 从 properties 中填充
     */
    private void fillVersionFromProperties(List<? extends DependencyBaseDTO> dependencies, Map<String, String> versionMap) {
        for (DependencyBaseDTO dependencyDTO : dependencies) {
            String version = dependencyDTO.getVersion();
            if (version == null) {
                // 这种情况发生在 pom 形式引入了其他工程或者 parent 不为空，总之已经被其他依赖完成版本管理，无需关心
                continue;
            }
            version = version.trim();
            if (version.startsWith("${")) {
                // 去掉 ${}
                String versionKey = version.substring(2, version.length() - 1).trim();
                String newVersion = versionMap.get(versionKey);
                if (newVersion == null) {
                    // 版本号缺失，认为是不合格的 pom 文件（dependency version中引用了 ${xx.version} 却未在 properties 中定义）
                    throw new IllegalStateException(String.format("Missing version. [groupId=%s, artifactId=%s, " +
                                                                  "version=%s]",
                            dependencyDTO.getGroupId(), dependencyDTO.getArtifactId(), version));
                }
                dependencyDTO.setVersion(newVersion);
            }
            //获取时不处理 [2.40.0,) 这种，在判断时认为是最新的
        }
    }

    // -------------------------------------------------------------------------

    @Override
    public ProjectEntity findById(Long projectId) {
        return projectRepository.findById(projectId).get();
    }

    @Override
    public List<ProjectEntity> findByIds(Iterable<Long> projectIds) {
        return projectRepository.findAllById(projectIds);
    }

    @Override
    public Map<Long, ProjectEntity> findMapByIds(Iterable<Long> projectIds) {
        List<ProjectEntity> projectEntities = projectRepository.findAllById(projectIds);
        Map<Long, ProjectEntity> projectMap = new HashMap<>();
        for (ProjectEntity projectEntity : projectEntities) {
            projectMap.put(projectEntity.getId(), projectEntity);
        }
        return projectMap;
    }

    @Override
    public List<ProjectEntity> findByUserId(String userId) {
        return projectRepository.findByUserId(userId);
    }

    private ProjectEntity save(ProjectEntity projectEntity) {
        // 是否已经存在
        ProjectEntity example = new ProjectEntity();
        example.setGroupId(projectEntity.getGroupId());
        example.setArtifactId(projectEntity.getArtifactId());
        // 暂时不考虑多版本控制
        //example.setVersion(projectEntity.getVersion());
        example.setUserId(projectEntity.getUserId());
        ProjectEntity projectInDb = projectRepository.findOne(Example.of(example))
                .orElse(null);
        ProjectEntity result;
        // 在旧数据的基础上改动并保存
        if (projectInDb != null) {
            /*
            // 考虑演示版不允许更新
            throw new IllegalStateException(
                    String.format("the project[groupId=%s, artifactId=%s] already exists in your account.",
                    projectInDb.getGroupId(), projectInDb.getArtifactId()));
                    */

            projectInDb.setVersion(projectEntity.getVersion());
            projectInDb.setName(projectEntity.getName());
            if (StrUtil.isNotBlank(projectEntity.getDescription())) {
                projectInDb.setDescription(projectEntity.getDescription());
            }
            // 发出 项目变更事件；删除待通知记录中 projectId = this，且待通知的记录
            result = projectRepository.save(projectInDb);
            projectInDb.setUpdateTime(new Date());
            eventPublisher.publish(new ProjectReLoadEvent(projectInDb.getId()));
        } else {
            result = projectRepository.save(projectEntity);
        }
        return result;
    }

    private ProjectEntity createProject(ProjectDTO projectDTO, String userId) {
        ProjectEntity project = new ProjectEntity();
        project.setGroupId(projectDTO.getGroupId());
        if(StringUtils.isEmpty(projectDTO.getGroupId())) {
            Optional.ofNullable(projectDTO.getParent())
                    .map(DependencyBaseDTO::getGroupId)
                    .ifPresentOrElse(project::setGroupId, () -> {throw new RuntimeException("invalid groupId");});
        }
        project.setArtifactId(projectDTO.getArtifactId());
        project.setName(StrUtil.isEmpty(projectDTO.getName()) ? projectDTO.getArtifactId() : projectDTO.getName());
        project.setDescription(projectDTO.getDescription());
        project.setVersion(projectDTO.getVersion());
        project.setUserId(userId);
        project.setCreateTime(new Date());
        return project;
    }

}
