package org.lym.pom.constant;

/**
 * 稳定版本号规则
 *
 * @author lym
 */
public interface StableVersionPatterns {

    /**
     * spring-boot
     */
    String X_Y_Z = "[\\d]+\\.[\\d]+\\.[\\d]+";

    String X_Y_Z__RELEASE = "[\\d]+\\.[\\d]+\\.[\\d]+-RELEASE";

    String X_Y_Z_RELEASE = "[\\d]+\\.[\\d]+\\.[\\d]+\\.RELEASE";

    String X_Y_Z_release = "[\\d]+\\.[\\d]+\\.[\\d]+\\.release";

    /**
     * spring-cloud
     */
    String ABC_SR = "[A-Z][a-z]+ SR[\\d]*";


    // -------------- 不包含 ----------

    String NOT_SNAPSHOT = ".*\\.SNAPSHOT";


}
