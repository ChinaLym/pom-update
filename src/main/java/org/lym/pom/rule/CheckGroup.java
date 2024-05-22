
package org.lym.pom.rule;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * @author lym
 */
@Getter
@Setter
public class CheckGroup {

    // 必须同时满足
    List<CheckItem> itemList;

}
