
package org.lym.pom.rule;

/**
 * @author lym
 */
public interface CheckItem {

    String getCheckItemType();

    boolean match(Object other);

}