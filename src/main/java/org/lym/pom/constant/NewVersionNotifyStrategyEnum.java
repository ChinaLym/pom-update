package org.lym.pom.constant;

/**
 * 新版本发布时，如何反应
 * @author lym
 */
public enum NewVersionNotifyStrategyEnum {

    /** 一有新版本就通知 */
    ALWAYS,

    /** 只有发布稳定版本时候才通知*/
    STABLE_ONLY,

    /** 忽略更新（不通知） */
    IGNORE,
    ;

    private String value;

    NewVersionNotifyStrategyEnum(){
        value = name();
    }

    public String getValue() {
        return this.value;
    }


}
