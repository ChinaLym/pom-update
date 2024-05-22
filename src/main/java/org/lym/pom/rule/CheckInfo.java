
package org.lym.pom.rule;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * @author lym
 */
@Getter
@Setter
public class CheckInfo {

    /**
     * 内部条件未 &&
     */
    List<CheckGroup> groupList;

    /**
     * 可以用 ||
     */
    List<String> conditionList;

    List<String> list;

    /**
     * ALL
     * checkList
     * ignoreList
     */
    String checkScope;

}
