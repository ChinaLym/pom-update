package org.lym.pom.service.impl.select;

import org.springframework.lang.NonNull;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public interface VersionSelector {

    /**
     * 是否为稳定版
     *
     * @see org.lym.pom.entity.ThirdProjectEntity#stableVersionPattern
     */
    boolean isStable(String version);

    /**
     * 排序：最新....最旧t     */
    List<String> sort(List<String> versions);

    /**
     * 获取 最新版
     */
    default String selectLatest(@NonNull List<String> versions){
        return versions.stream().max(getComparator()).orElseThrow();
    }

    /**
     * 获取 最新稳定版
     */
    default String selectLatestStable(@NonNull List<String> versions){
        return versions.stream().filter(this::isStable).max(getComparator()).orElse(null);
    }

    /**
     * 获取所有稳定版
     */
    default List<String> selectStable(List<String> versions){
        return versions.stream().filter(this::isStable).collect(Collectors.toList());
    }

    Comparator<String> getComparator();
}
