package org.lym.pom.constant;

/**
 * @author lym
 */
public enum ThirdProjectVersionStatusEnum {

    /**
     * 第一次引入，还未进行爬取
     */
    BORN,

    /**
     * 正常
     */
    NORMAL,

    /**
     * 需要检查爬取记录，人工干涉
     */
    EXCEPTION,

    /**
     * 项目停止更新、维护，不再推荐依赖
     * 暂不使用
     */
    STOP,

    ;
    ThirdProjectVersionStatusEnum(){
        this.status = name();
    }

    private String status;

    public String getStatus() {
        return status;
    }
}
