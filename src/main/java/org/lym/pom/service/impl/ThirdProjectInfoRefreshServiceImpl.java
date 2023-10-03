package org.lym.pom.service.impl;

import cn.hutool.core.util.ReUtil;
import org.lym.pom.annotation.ThirdProjectInfoSpider;
import org.lym.pom.config.DependencyExtInfoProperties;
import org.lym.pom.constant.ThirdProjectInfoSource;
import org.lym.pom.constant.ThirdProjectInfoSourceEnum;
import org.lym.pom.constant.ThirdProjectVersionStatusEnum;
import org.lym.pom.entity.ThirdProjectEntity;
import org.lym.pom.service.IThirdProjectInfoRefreshService;
import org.lym.pom.service.impl.select.VersionSelector;
import org.lym.pom.service.impl.select.VersionSelectorManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Pattern;

/**
 * @author lym
 */
@Service
public class ThirdProjectInfoRefreshServiceImpl implements IThirdProjectInfoRefreshService {

    @ThirdProjectInfoSpider
    @Autowired
    private RestTemplate rest;

    private ThirdProjectInfoSource thirdProjectInfoSource = ThirdProjectInfoSourceEnum.MVN_JAR;

    private static Map<String, Pattern> patternMap = new HashMap<>();

    private final String perHour = "0 0 * * * ?";

    @Scheduled(cron = perHour)
    public void resetThirdProjectInfoSource() {
        thirdProjectInfoSource = ThirdProjectInfoSourceEnum.MVN_JAR;
    }

    @Override
    public void refreshInfo(ThirdProjectEntity thirdProject) throws HttpServerErrorException, RestClientException {

        // 获取页面
        String html = "";
        try {
            html = getHtmlResult(thirdProject);
        } catch (RestClientException restEx) {
            // 如果是 RestClientException 则更换其他源重试
            try {
                // 临时换成其他备用源
                thirdProjectInfoSource = ThirdProjectInfoSourceEnum.ALI_CLOUD;
                html = getHtmlResult(thirdProject);
            } catch (Exception ignored) {
                thirdProjectInfoSource = ThirdProjectInfoSourceEnum.MVN_JAR;
            }
        }

        // 刷新版本号信息
        refreshVersion(html, thirdProject);

        // 更新依赖url
        fillProjectUrl(thirdProject);

        // 刷新基本信息
        refreshBaseInfo(html, thirdProject);

    }

    /**
     * 返回 html 字符串
     *
     * @param thirdProject 待更新的第三方工程
     * @return html 字符串
     */
    private String getHtmlResult(ThirdProjectEntity thirdProject) throws RestClientException {
        String groupId = thirdProject.getId().getGroupId();
        String artifactId = thirdProject.getId().getArtifactId();

        // 目标网站
        String aimUrl = thirdProjectInfoSource.getUrl(groupId, artifactId);

        return rest.getForObject(aimUrl, String.class);
    }


    /**
     * 刷新基本信息
     */
    private void refreshBaseInfo(String html, ThirdProjectEntity thirdProject) {

        if (thirdProjectInfoSource != ThirdProjectInfoSourceEnum.MVN_JAR) {
            // 仅 mvnJar 支持获取详细信息
            return;
        }

        boolean firstRefresh = ThirdProjectVersionStatusEnum.BORN.getStatus().equals(thirdProject.getStatus());
        if (firstRefresh) {
            // projectName
            List<String> nameList = ReUtil.findAll(getPattern(thirdProjectInfoSource.getNamePattern()), html, 1);
            thirdProject.setName(nameList.get(0));

        }

        // Description
        List<String> descriptionList = ReUtil.findAll(getPattern(thirdProjectInfoSource.getDescriptionPattern()), html,
                1);
        thirdProject.setDescription(descriptionList.get(0));

        // 以下这些信息不太容易从 mvnrepository 这类 jar 包管理的地方获取，可能需要从特定的官方文档 / 代码仓库获取------------
        // homeUrl
//        List<String> homeUrlList = ReUtil.findAll(getPattern(thirdProjectInfoSource.getHomeUrlPattern()), html, 1);
//        thirdProject.setHomeUrl(homeUrlList.get(0));
//
//        // OpenSourceProtocol
//        List<String> openSourceProtocolList =
//                ReUtil.findAll(getPattern(thirdProjectInfoSource.getOpenSourceProtocolPattern()), html, 1);
//        thirdProject.setOpenSourceProtocol(openSourceProtocolList.get(0));
//
//        // note changeLogUrl 未设置
//        List<String> changeLogUrlList =
//                ReUtil.findAll(getPattern(thirdProjectInfoSource.getChangeLogUrlPattern()), html, 1);
//        thirdProject.setChangeLogUrl(changeLogUrlList.get(0));
    }


    /**
     * 刷新版本号信息
     */
    private void refreshVersion(String html, ThirdProjectEntity thirdProject) {
        Pattern versionPattern = getPattern(thirdProjectInfoSource.getVersionsPattern());

        // 结果列表
        List<String> versionList;

        versionList = ReUtil.findAll(versionPattern, html, 1);

        if (CollectionUtils.isEmpty(versionList)) {
            throw new IllegalStateException("can't find versions.[groupId=" +
                    thirdProject.getId().getGroupId() +
                    ", artifactId=" +
                    thirdProject.getId().getArtifactId() + "]");
        }
        // 这两个必须都遍历，否则若在检查更新周期内，发布一次稳定版，又发布一次非稳定版，无法感知到最新稳定版
        // todo 【扩展性】筛选出最新版本；目前只有一个选择器暂时不需要决策
        VersionSelector versionSelector = VersionSelectorManager.getVersionSelector("");
        thirdProject.setVersion(versionSelector.selectLatest(versionList));
        // 获取最新 stable 版本
        String stableVersion = versionSelector.selectLatestStable(versionList);
        if(stableVersion != null) {
            thirdProject.setStableVersion(stableVersion);
        }
    }


    /**
     * 带缓存的动态编译正则表达式
     *
     * @param regex 正则表达式
     * @return 匹配符
     */
    private static Pattern getPattern(String regex) {
        Pattern pattern = patternMap.get(regex);
        if (pattern == null) {
            // 设置为允许多行匹配
            pattern = Pattern.compile(regex, Pattern.DOTALL);
            patternMap.put(regex, pattern);
        }
        return pattern;
    }

    public void fillProjectUrl(ThirdProjectEntity thirdProject) {
        DependencyExtInfoProperties.DependencyExtInfo extInfo = Optional.ofNullable(thirdProject)
                .map(ThirdProjectEntity::getId)
                .map(id -> id.getGroupId() + ":" + id.getArtifactId())
                .map(DependencyExtInfoProperties::fetchExtInfoFromCache)
                .orElse(null);

        if (extInfo != null) {
            String changeLogUrl = extInfo.getChangeLogUrl();
            if (changeLogUrl.contains("{")) {
                changeLogUrl = changeLogUrl.replace("{VERSION}", thirdProject.getVersion());
            }
            thirdProject.setChangeLogUrl(changeLogUrl);
            thirdProject.setHomeUrl(extInfo.getOpensourceUrl());
        }


//        // 固定地址：github - releases
//        String githubReleasePage = "https://github.com/projen/projen/releases";
//
//        // 固定地址：github - file
//        String githubFilePage = "https://github.com/redisson/redisson/blob/master/CHANGELOG.md";
//
//        // 拼接version：github - releases tag（区分版本）
//        String githubReleaseTagPage = "https://github.com/openjdk/jdk/releases/tag/{jdk-22%2B13}";
//
//        // 拼接version：doc html
//        String projectDocPage = "https://docs.spring.io/spring-boot/docs/{3.0.10}/reference/html/";

    }

}
