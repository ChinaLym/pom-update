
package org.lym.pom.rule;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

/**
 * @author lym
 */
@Getter
@Setter
public class CheckDefinition {

    private String name;

    private List<String> label;
    /**
     * Enum
     */
    private String       priority;
    /**
     * 目的 Enum
     */
    private String       purpose;
    /**
     * 遇到该问题如何处理，通常包含指南文档的链接 1024
     */
    private String       suggestion;
    /**
     * 检测频率 Enum 周期，非周期（单次）
     */
    private String       measurementFrequency;
    /**
     * 检查起始时间（提醒，方便反馈修复时间）
     */
    private LocalDate    checkpointDate;
    /**
     * 检查结束时间（强卡点）
     */
    private LocalDate    deadline;
    /**
     * 描述，通常是设置该检查项的背景
     */
    private String       description;

    private CheckInfo    checkInfo;

    /**
     * 负责人
     */
    private String       creator;
    /**
     * 调整人
     */
    private String       lastModifiedBy;

}
