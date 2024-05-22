package org.lym.pom.controller;

import org.lym.pom.constant.NewVersionNotifyStrategyEnum;
import org.lym.pom.entity.DependencyEntity;
import org.lym.pom.entity.ProjectEntity;
import org.lym.pom.service.IDependencyService;
import org.lym.pom.service.IProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.util.List;

/**
 * 依赖相关
 *
 * @author lym
 */
@Validated
@RestController
@RequestMapping("dependencies")
public class DependencyController {

    @Autowired
    private IProjectService projectService;

    @Autowired
    private IDependencyService dependencyService;

    /**
     * 查询 特定工程 的依赖列表
     * http://localhost:12345/dependencies/3
     *
     * @return 所有依赖
     */
    @GetMapping("{projectId}")
    public List<DependencyEntity> query(@PathVariable("projectId") Long projectId){
        return dependencyService.findAllByProjectId(projectId);
    }

    /**
     * http://localhost:12345/dependencies/updateNotifyStrategy?projectId=10&notifyStrategy=ALWAYS&email=your@demoemail.com
     * @param projectId
     * @param notifyStrategy
     * @param email
     * @return
     */
    @GetMapping("updateNotifyStrategy")
    public String updateAllNotifyStrategyByProjectId(@NotNull Long projectId, @NotNull String notifyStrategy, @NotEmpty @Email String email){
        NewVersionNotifyStrategyEnum newNotifyStrategy = NewVersionNotifyStrategyEnum.valueOf(notifyStrategy);
        // 校验 email
        ProjectEntity projectEntity = projectService.findById(projectId);
        if(projectEntity == null){
            throw new IllegalStateException("project not exist, projectId=" + projectId);
        }
        if(!projectEntity.getUserId().equals(email)){
            throw new IllegalStateException("permission deny can't change strategy, projectId=" + projectId + ", email=" + email);
        }
        dependencyService.updateAllNotifyStrategyByProjectId(projectId, newNotifyStrategy);
        return "changed project(groupId=" + projectEntity.getArtifactId() + ",artifactId=" + projectEntity.getArtifactId()
                + ") notifyStrategy to '" + notifyStrategy + "'";
    }

    /**
     * 更新依赖
     */
    //@PostMapping
    public String update(DependencyEntity dependency){
        dependencyService.update(dependency);
        return "success";
    }

    /**
     * 更新依赖列表
     */
    //@PostMapping("_search")
    public String updateBatch(List<DependencyEntity> dependencies){
        dependencyService.update(dependencies);
        return "success";
    }

}
