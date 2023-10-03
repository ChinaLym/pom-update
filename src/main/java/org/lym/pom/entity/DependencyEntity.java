package org.lym.pom.entity;

import lombok.Data;
import org.lym.pom.constant.NewVersionNotifyStrategyEnum;

import javax.persistence.*;

/**
 * 特定 project 的依赖项
 *
 * @author lym
 */
@Data
@Entity
@Table(name="tb_dependency")
public class DependencyEntity {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;

    /** 项目 id */
    private Long projectId;

    /** 依赖 id*/
    private String groupId;

    /** 依赖 id */
    private String artifactId;

    /** 当前该依赖对应的版本 */
    private String version;

    /**
     * 该依赖发布新版时，响应方式 ON，STABLE_ONLY，OFF
     * todo 【功能】允许使用者修改，保存时根据用户获取
     */
    private String newVersionNotifyStrategy = NewVersionNotifyStrategyEnum.STABLE_ONLY.getValue();

}
