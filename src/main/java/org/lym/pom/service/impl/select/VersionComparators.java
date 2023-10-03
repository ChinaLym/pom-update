package org.lym.pom.service.impl.select;

import cn.hutool.core.util.NumberUtil;
import org.springframework.util.StringUtils;

import java.util.Comparator;

/**
 * @author lym
 */
public interface VersionComparators {

    /**
     * 字母排序
     * 适合 spring cloud 这类
     */
    Comparator<String> STRING = String::compareTo;


    /**
     * GNU 风格的版本号
     * 适合类 Major.Minor.Patch 的格式
     * 兼容 1.0 和 1.0.1 这类比较（版本号可能不全）
     * 兼容 1.0.0 release、1.0.10 release 这种比较（分隔符不唯一）
     * 兼容 -beta, -rc{x} 这种
     * todo 【扩展点功能完善】有的 version 不应参与比较，需要先过滤出来
     */
    Comparator<String> PART = (version1, version2) -> {
        if(StringUtils.isEmpty(version1)){
            return StringUtils.isEmpty(version2) ? 0 : -1;
        } else if(StringUtils.isEmpty(version2)){
            return 1;
        }
        String split = "\\.| |\\-";
        String[] version1Parts = version1.split(split);
        String[] version2Parts = version2.split(split);

        int minPartNum = Integer.min(version1Parts.length, version2Parts.length);
        int difference = 0;

        for (int i = 0; i < minPartNum; i++) {
            boolean v1IsNum = NumberUtil.isNumber(version1Parts[i]);
            boolean v2IsNum = NumberUtil.isNumber(version2Parts[i]);
            if (v1IsNum && v2IsNum) {
                difference = Integer.valueOf(version1Parts[i]).compareTo(Integer.valueOf(version2Parts[i]));
            } else if(!v1IsNum && !v2IsNum){
                // 都不是数字
                difference = version1Parts[i].compareToIgnoreCase(version2Parts[i]);
            } else {
                // 认为有数字的版本号更新
                return v1IsNum ? 1 : -1;
            }
            if (difference != 0) {
                return difference;
            }
        }
        return Integer.compare(version1Parts.length, minPartNum);
    };

}
