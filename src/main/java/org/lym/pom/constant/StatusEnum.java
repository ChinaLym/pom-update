package org.lym.pom.constant;

/**
 * @author lym
 */

public enum StatusEnum {

    /** */
    NORMAL,

    /** */
    DELETED,
    ;

    private String value;

    StatusEnum(){
        this.value = name();
    }

    public String getValue() {
        return value;
    }


}
