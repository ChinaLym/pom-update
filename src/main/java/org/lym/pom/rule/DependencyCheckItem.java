
package org.lym.pom.rule;

import org.lym.pom.service.impl.select.VersionComparators;

import java.util.Comparator;

/**
 * @author lym
 */
public class DependencyCheckItem implements CheckItem {

    private String groupId;

    private String artifactId;

    private String version;

    /**
     * >
     * >=
     * <
     * <=
     * =
     * !=
     */
    private String operation;

    private String value;

    @Override public String getCheckItemType() {
        return "Dependency";
    }

    @Override public boolean match(Object version) {
        if(version instanceof String) {
            String inputVersion = (String) version;
            // todo 获取比较器
            Comparator<String> versionComparator = VersionComparators.PART;
            int result = versionComparator.compare(inputVersion, value);
            boolean valid = false;
            switch (operation) {
                case "=": valid = result == 0; break;
                case ">": valid = result > 0; break;
                case ">=": valid = result >= 0; break;
                case "<": valid = result < 0; break;
                case "<=": valid = result <= 0; break;
                case "!=": valid = result != 0; break;
                default:
            }
            return valid;
        }
        // null 说明未引入jar，算是满足了
        return true;
    }

}