package org.lym.pom.entity;

import lombok.Data;
import org.lym.pom.constant.NewVersionNotifyStrategyEnum;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * @author lym
 */
@Data
@Entity
@Table(name="tb_user")
public class UserEntity {

    @Id
    private String id;

    private String name;

    private String email;

    private String phone;

    private LocalDateTime createTime;

    private String defaultNewVersionNotifyStrategy = NewVersionNotifyStrategyEnum.STABLE_ONLY.getValue();

}
