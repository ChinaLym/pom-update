package org.lym.pom.constant;

import java.time.LocalTime;

/**
 * 发送通知的时间
 */
public enum NotifyTimeEnum {

    /**
     * 上午 6 点
     */
    AM_6,
    AM_7,
    AM_8,
    AM_9,
    AM_10,
    AM_11,
    AM_12,

    /**
     * 下午 1 - 11
     */
    PM_1,
    PM_2,
    PM_3,
    PM_4,
    PM_5,
    PM_6,
    PM_7,
    PM_8,
    PM_9,
    PM_10,
    PM_11,
    ;

    private final LocalTime time;

    NotifyTimeEnum(){
        int hourOffSet = this.name().startsWith("AM") ? 0 : 12;
        int hour = Integer.parseInt(this.name().split("_")[1]);
        time = LocalTime.of(hourOffSet + hour, 0);
    }

    public LocalTime getTime() {
        return time;
    }}
