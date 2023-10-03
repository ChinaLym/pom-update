package org.lym.pom.service.impl.select;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author lym
 */
public class VersionSelectorManager {

    private static final Map<String, VersionSelector> SELECTOR_MAP;

    public static final VersionSelector DEFAULT = new DefaultVersionSelector();

    static {
        SELECTOR_MAP = new ConcurrentHashMap<>();
    }

    public static VersionSelector getVersionSelector(String k) {
        return SELECTOR_MAP.getOrDefault(k, DEFAULT);
    }
}
