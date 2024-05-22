package org.lym.pom.constant;

import static org.lym.pom.constant.ThirdProjectInfoSource.Placeholder.*;

/**
 * @author lym
 */

public enum ThirdProjectInfoSourceEnum implements ThirdProjectInfoSource {

    /** mvn jar
     * https://www.mvnjar.com/mysql/mysql-connector-java/jar.html
     */
    MVN_JAR("https://www.mvnjar.com/{groupId}/{artifactId}/jar.html",
            "<th class=\"thread\"><a href=\".*?/detail.html\">(.*?)</a></th>",
            "<td><span>(.*?)</span>",
            "<i class=\"fa fa-info-circle\" aria-hidden=\"true\"></i>(.*?)</p>",
            "<td><span>(http.*?)</span></td>",
            "",
            "<td colspan=\"2\">\\s*?<span>\\s*?<a rel=\"nofollow\" href=\".*?\" target=\"_blank\">(.*?)</a>\\s*?</span>\\s*?</td>"
    ),

    /** 阿里云 */
    ALI_CLOUD("https://maven.aliyun.com/artifact/aliyunMaven/searchArtifactByGav?_input_charset=utf-8&groupId={groupId}&repoId=central&artifactId={artifactId}&version=",
            "\"repositoryId\":\"central\",\"version\":\"(.*?)\"}"),

    /**
     * 中央仓库
     */
    CENTRAL("https://mvnrepository.com/artifact/{groupId}/{artifactId}",
            " class=\"vbtn release\">(.*?)</a>"),

    /**
     * github
     */
    GITHUB("https://github.com/{groupId}/{artifactId}/releases",
            "<span class=\"css-truncate-target\" style=\"max-width: [\\d]+px\">(.*?)</span>");
    ;

    private String urlTemplate;

    private String versionPattern;

    private String namePattern;

    private String descriptionPattern;

    private String homeUrlPattern;

    private String changeLogUrlPattern;

    private String openSourceProtocolPattern;

    ThirdProjectInfoSourceEnum(String urlTemplate, String versionPattern, String namePattern,
                               String descriptionPattern, String homeUrlPattern, String changeLogUrlPattern,
                               String openSourceProtocolPattern){
        this.urlTemplate = urlTemplate;
        this.versionPattern = versionPattern;
        this.namePattern = namePattern;
        this.descriptionPattern = descriptionPattern;
        this.homeUrlPattern = homeUrlPattern;
        this.changeLogUrlPattern = changeLogUrlPattern;
        this.openSourceProtocolPattern = openSourceProtocolPattern;

    }

    ThirdProjectInfoSourceEnum(String urlTemplate, String versionPattern){
        this.urlTemplate = urlTemplate;
        this.versionPattern = versionPattern;
    }

    @Override
    public String getUrl(String groupId, String artifactId){
        return urlTemplate.replace(GROUP_ID, groupId).replace(ARTIFACT_ID, artifactId);
    }

    @Override
    public String getVersionsPattern() {
        return versionPattern;
    }

    @Override
    public String getNamePattern() {
        return namePattern;
    }

    @Override
    public String getDescriptionPattern() {
        return descriptionPattern;
    }

    @Override
    public String getHomeUrlPattern() {
        return homeUrlPattern;
    }

    @Override
    public String getChangeLogUrlPattern() {
        return changeLogUrlPattern;
    }

    @Override
    public String getOpenSourceProtocolPattern() {
        return openSourceProtocolPattern;
    }

}
