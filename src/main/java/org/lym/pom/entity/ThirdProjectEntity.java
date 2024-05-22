package org.lym.pom.entity;


import lombok.Data;
import org.lym.pom.constant.ThirdProjectVersionStatusEnum;

import jakarta.persistence.*;
import java.util.Date;


/**
 * 第三方 jar
 * 被 project 依赖，每日爬取版本更新
 *
 * @author lym
 */
@Data
@Entity
@Table(name="tb_third_project")
public class ThirdProjectEntity {

    @EmbeddedId
    private DependencyIndex id;

    /** 已知最新版本 */
    private String version;

    /** 已知最新稳定版本 */
    private String stableVersion;

    /** 名称（可选） */
    private String name;

    /** 描述（可选） */
    private String description;

    /** 项目主页（可选） */
    private String homeUrl;

    /** 更新日志地址（可选） */
    private String changeLogUrl;

    /** 开源协议（可选） */
    private String openSourceProtocol;


    //********************* 统一获取版本号 **********************

    /** 项目版本获取地址 */
    //private String versionUrl;

    /**
     * regex, xpath
     */
    //private String analysisType;

    /** 匹配表达式 */
    //private String pattern;

    //***********************************

    /**
     * 如何判断为稳定版，正则
     */
    private String stableVersionPattern = ".*";

    /** 版本规则 */
    private String versionRule = "x.y.z";

    /**
     * 状态
     * @see ThirdProjectVersionStatusEnum
     */
    private String status;
    // = ThirdProjectVersionStatusEnum.NORMAL.getStatus();

    /** 最后一次更新时间 */
    private Date updateTime;

    // 判断相等时，若 id 相同则认为相同

    @Override
    public boolean equals(Object object){
        if(object instanceof ThirdProjectEntity){
            return getId().equals(((ThirdProjectEntity) object).getId());
        }
        return false;
    }

    @Override
    public int hashCode(){
        return this.getId().hashCode();
    }

}
