package org.lym.pom.entity;


import lombok.Data;
import org.lym.pom.constant.StatusEnum;


import jakarta.persistence.*;
import java.util.Date;


/**
 * 待扫描的 pom.xml
 *
 * @author lym
 */
@Data
@Entity
@Table(name="tb_project")
public class ProjectEntity {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;


    private String groupId;


    private String artifactId;


    private String version;


    private String name;


    private String description;


    private String userId;

    private String status = StatusEnum.NORMAL.getValue();

    private Date createTime;

    private Date updateTime;

}
