package org.lym.pom.constant;

/**
 * 用于获取第三方依赖信息的途径
 * @author lym
 */
public interface ThirdProjectInfoSource {

    /**
     * 获取默认 url 模板
     * @param groupId       groupId
     * @param artifactId    artifactId
     * @return              默认 url 模板
     */
    String getUrl(String groupId, String artifactId);


    /**
     * 项目版本号列表
     * @return 匹配符
     */
    String getVersionsPattern();

    /** 项目名称 */
    String getNamePattern();

    /** 项目描述 */
    String getDescriptionPattern();

    /** 项目主页 */
    String getHomeUrlPattern();

    /** 更新日志地址 */
    String getChangeLogUrlPattern();

    /** 开源协议 */
    String getOpenSourceProtocolPattern();


    interface Placeholder{
        String GROUP_ID = "{groupId}";
        String ARTIFACT_ID = "{artifactId}";
    }
}
