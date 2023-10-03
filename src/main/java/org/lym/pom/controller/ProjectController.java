package org.lym.pom.controller;

import org.lym.pom.constant.ContextKey;
import org.lym.pom.dto.xml.ProjectDTO;
import org.lym.pom.entity.ProjectEntity;
import org.lym.pom.entity.UserEntity;
import org.lym.pom.service.IPomAnalyzerService;
import org.lym.pom.service.IProjectService;
import org.lym.pom.service.IUserService;
import org.shoulder.core.context.AppContext;
import org.shoulder.core.exception.CommonErrorCodeEnum;
import org.shoulder.core.util.AssertUtils;
import org.shoulder.validate.annotation.FileType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;
import java.util.List;

/**
 * project
 *
 * @author lym
 */
@Validated
@RestController
@RequestMapping("projects")
public class ProjectController {

    @Autowired
    private IPomAnalyzerService pomAnalyzerService;

    @Autowired
    private IProjectService projectService;

    @Autowired
    private IUserService userService;

    //@RequestMapping(value = "uploadPomXml", method = {RequestMethod.POST, RequestMethod.PUT})
    public void uploadPomXml(@FileType(allowSuffix = "xml", maxSize = "200kb", nameAllowPattern = "pom\\.xml")
                                     MultipartFile pomXml) {
        ProjectDTO projectDTO = pomAnalyzerService.analysisPom(pomXml);
        projectService.save(projectDTO);
    }

    @RequestMapping(value = "create", method = {RequestMethod.POST, RequestMethod.PUT})
    public String create(@FileType(allowSuffix = "xml", maxSize = "200kb", nameAllowPattern = "pom\\.xml")
                                     MultipartFile pomXml, @NotEmpty @Email String email,
                         @DefaultValue("false") Boolean notifyInstantlyAfterCheck, String notifyReason) {
        if(notifyInstantlyAfterCheck) {
            // 防止 xss
            AssertUtils.notBlank(notifyReason, CommonErrorCodeEnum.ILLEGAL_PARAM, "notifyReason");
        }
        UserEntity userEntity = userService.findById(email);
        if (userEntity == null) {
            userEntity = new UserEntity();
            userEntity.setId(email);
            userEntity.setName(email);
            userEntity.setEmail(email);
            userEntity.setCreateTime(LocalDateTime.now());
            userService.save(userEntity);
        }
        ProjectDTO projectDTO = pomAnalyzerService.analysisPom(pomXml);
        AppContext.set(ContextKey.NOTIFY_INSTANTLY_AFTER_CHECK, notifyInstantlyAfterCheck);
        AppContext.set(ContextKey.NOTIFY_REASON, "API_INVOKED::" + notifyReason);
        projectService.save(projectDTO, email);
        AppContext.remove(ContextKey.NOTIFY_INSTANTLY_AFTER_CHECK);
        AppContext.remove(ContextKey.NOTIFY_REASON);
        return "添加成功！";
    }


    /**
     * 查询 工程 列表
     * http://localhost:12345/projects/list?email=xxx
     *
     * @return 查询我的所有工程
     */
    @GetMapping("list")
    public List<ProjectEntity> showMyProjectList(@NotEmpty @Email String email) {
        return projectService.findByUserId(email);
    }

}
