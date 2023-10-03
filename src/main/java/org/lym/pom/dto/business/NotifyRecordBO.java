package org.lym.pom.dto.business;

import lombok.Data;
import org.lym.pom.entity.DependencyIndex;
import org.lym.pom.entity.NotifyRecordEntity;
import org.lym.pom.entity.ThirdProjectEntity;

import javax.persistence.*;
import java.util.Date;

/**
 * 通知记录，对应着 project 中的一个依赖
 * @author lym
 */
@Data
public class NotifyRecordBO {

    /** 依赖 id*/
    private String groupId;

    /** 依赖 id */
    private String artifactId;

    /** 当前该依赖对应的版本(project.dependency.version) */
    private String currentVersion;

    private ThirdProjectEntity thirdProject;

    NotifyRecordBO(NotifyRecordEntity notifyRecordEntity, ThirdProjectEntity thirdProjectEntity){
        this.groupId = notifyRecordEntity.getGroupId();
        this.artifactId = notifyRecordEntity.getArtifactId();
        this.currentVersion = notifyRecordEntity.getCurrentVersion();
        this.thirdProject = thirdProjectEntity;
    }

    /**
     * 获取 第三方依赖的 id
     */
    public DependencyIndex getDependencyIndex(){
        return new DependencyIndex(groupId, artifactId);
    }

}
