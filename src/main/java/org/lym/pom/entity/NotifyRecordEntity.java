package org.lym.pom.entity;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;
import java.util.Objects;

/**
 * 通知记录
 * @author lym
 */
@Data
@Entity
@Table(name="tb_notify_record")
@NoArgsConstructor
public class NotifyRecordEntity {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;

    private Long projectId;

    /** 依赖 id*/
    private String groupId;

    /** 依赖 id */
    private String artifactId;

    /** 当前该依赖对应的版本(project.dependency.version) */
    private String currentVersion;

    /** 新的版本号，用于判断是否为同一条记录 */
    private String newVersion;

    /** 通知状态，待通知，已经通知，取消 */
    private Boolean notified;

    /** 发送通知时间 */
    private Date notifyTime;

    public NotifyRecordEntity(Long projectId, String groupId, String artifactId, String currentVersion, String newVersion){
        this.projectId = projectId;
        this.groupId = groupId;
        this.artifactId = artifactId;
        this.currentVersion = currentVersion;
        this.newVersion = newVersion;
        this.notified = false;
    }

    /**
     * 获取 第三方依赖的 id
     */
    public DependencyIndex getDependencyIndex(){
        return new DependencyIndex(groupId, artifactId);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        NotifyRecordEntity that = (NotifyRecordEntity) o;
        return id.equals(that.id) &&
                projectId.equals(that.projectId) &&
                groupId.equals(that.groupId) &&
                artifactId.equals(that.artifactId) &&
                currentVersion.equals(that.currentVersion) &&
                newVersion.equals(that.newVersion);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, projectId, groupId, artifactId, currentVersion, newVersion);
    }
}
