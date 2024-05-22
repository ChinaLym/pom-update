package org.lym.pom.controller;

import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.http.HttpUtil;
import org.hibernate.validator.constraints.URL;
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
import org.shoulder.core.util.StringUtils;
import org.shoulder.validate.annotation.FileType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

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

    private static final AtomicLong nextTestTime = new AtomicLong();

    private static final AtomicLong leftTestTimes = new AtomicLong(200);

    private static final long testDuration = Duration.ofSeconds(10).toMillis();

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
        // 可以用临时邮箱
        AssertUtils.isFalse(StringUtils.containsAny(email, "test", "demo"), CommonErrorCodeEnum.ILLEGAL_PARAM, "invalid email!");
        if (notifyInstantlyAfterCheck) {
            // todo【安全】防止 xss
            AssertUtils.notBlank(notifyReason, CommonErrorCodeEnum.ILLEGAL_PARAM, "notifyReason");
        }
        flowLimit();

        ProjectDTO projectDTO = pomAnalyzerService.analysisPom(pomXml);
        AppContext.set(ContextKey.NOTIFY_INSTANTLY_AFTER_CHECK, notifyInstantlyAfterCheck);
        AppContext.set(ContextKey.NOTIFY_REASON, "API_INVOKED::" + notifyReason);
        projectService.save(projectDTO, email);
        AppContext.remove(ContextKey.NOTIFY_INSTANTLY_AFTER_CHECK);
        AppContext.remove(ContextKey.NOTIFY_REASON);

        new Thread(() -> {
            UserEntity userEntity = userService.findById(email);
            // 这里为了 demo 方便，直接保存
            if (userEntity == null) {
                userEntity = new UserEntity();
                userEntity.setId(email);
                userEntity.setName(email);
                userEntity.setEmail(email);
                userEntity.setCreateTime(LocalDateTime.now());
                userService.save(userEntity);
            }
        }).start();

        return "success";
    }


    @RequestMapping(value = "createWithUrl", method = {RequestMethod.GET})
    public String createWithUrl(@URL @NotEmpty @Pattern(regexp = ".+pom.xml") String pomXmlUrl, @NotEmpty @Email String email,
                                @DefaultValue("false") Boolean notifyInstantlyAfterCheck, String notifyReason) {
        // 可以用临时邮箱
        AssertUtils.isFalse(StringUtils.containsAny(email, "test", "demo"), CommonErrorCodeEnum.ILLEGAL_PARAM, "invalid email!");
        if (notifyInstantlyAfterCheck) {
            // todo【安全】防止 xss
            AssertUtils.notBlank(notifyReason, CommonErrorCodeEnum.ILLEGAL_PARAM, "notifyReason");
        }

        flowLimit();

        // 开始
        HttpRequest getPomReq = HttpUtil.createGet(pomXmlUrl);
        getPomReq.timeout((int) testDuration).disableCache();
        try (HttpResponse resp = getPomReq.execute()) {
            long contentLength = resp.contentLength();
            if (contentLength > 0) {
                AssertUtils.isTrue(contentLength < 1024 * 100, CommonErrorCodeEnum.SERVER_BUSY, "pom.xml 文件太大！" + pomXmlUrl);
            }

            ProjectDTO projectDTO = pomAnalyzerService.analysisPom(resp.bodyStream());
            AppContext.set(ContextKey.NOTIFY_INSTANTLY_AFTER_CHECK, notifyInstantlyAfterCheck);
            AppContext.set(ContextKey.NOTIFY_REASON, "API_INVOKED::" + notifyReason);
            projectService.save(projectDTO, email);
            new Thread(() -> {
                UserEntity userEntity = userService.findById(email);
                // 这里为了 demo 方便，直接保存
                if (userEntity == null) {
                    userEntity = new UserEntity();
                    userEntity.setId(email);
                    userEntity.setName(email);
                    userEntity.setEmail(email);
                    userEntity.setCreateTime(LocalDateTime.now());
                    userService.save(userEntity);
                }
            }).start();
        } finally {
            AppContext.remove(ContextKey.NOTIFY_INSTANTLY_AFTER_CHECK);
            AppContext.remove(ContextKey.NOTIFY_REASON);
        }

        return "success";
    }

    private static void flowLimit() {
        // 限流
        long now = System.currentTimeMillis();
        long enableTime = nextTestTime.get();
        boolean canAccess = now > enableTime;
        AssertUtils.isTrue(canAccess, CommonErrorCodeEnum.SERVER_BUSY);
        canAccess = nextTestTime.compareAndSet(enableTime, now + testDuration);
        AssertUtils.isTrue(canAccess, CommonErrorCodeEnum.SERVER_BUSY);
        AssertUtils.isTrue(leftTestTimes.decrementAndGet() > 0, CommonErrorCodeEnum.DEPRECATED_NOT_SUPPORT, "试用次数过多！联系作者！");
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
