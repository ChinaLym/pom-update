package org.lym.pom.dto.business;


import lombok.Data;
import lombok.experimental.Accessors;
import org.lym.pom.entity.NotifyRecordEntity;
import org.lym.pom.entity.ProjectEntity;
import org.lym.pom.entity.ThirdProjectEntity;
import org.lym.pom.entity.UserEntity;

import java.util.LinkedList;
import java.util.List;


/**
 * project
 * @author lym
 */
@Data
@Accessors(chain = true)
public class NotifyProjectBO {

    private Long projectId;

    private String groupId;

    private String artifactId;

    private String version;

    private String name;

    private String description;

    private String notifyReason;

    private UserEntity user;

    private List<NotifyRecordBO> notifyRecordBOList;

    public NotifyProjectBO(ProjectEntity projectEntity, UserEntity user){
        this.projectId = projectEntity.getId();
        this.groupId = projectEntity.getGroupId();
        this.artifactId = projectEntity.getArtifactId();
        this.version = projectEntity.getVersion();
        this.name = projectEntity.getName();
        this.description = projectEntity.getDescription();
        this.user = user;
    }

    private NotifyProjectBO addNotifyRecordBO(NotifyRecordBO notifyRecordBO){
        if(this.notifyRecordBOList == null){
            this.notifyRecordBOList = new LinkedList<>();
        }
        this.notifyRecordBOList.add(notifyRecordBO);
        return this;
    }

    public NotifyProjectBO addNotifyRecordBO(NotifyRecordEntity notifyRecordEntity, ThirdProjectEntity thirdProjectEntity){
        return addNotifyRecordBO(new NotifyRecordBO(notifyRecordEntity, thirdProjectEntity));
    }

}
