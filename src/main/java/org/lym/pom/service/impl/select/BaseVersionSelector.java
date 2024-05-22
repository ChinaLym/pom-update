package org.lym.pom.service.impl.select;

import java.util.Comparator;
import java.util.List;

/**
 * 最基本的排序器
 * @author Admin
 */
public class BaseVersionSelector implements VersionSelector {

    /**
     * 是否为稳定版
     */
    @Override
    public boolean isStable(String version){
        return true;
    }

    @Override
    public List<String> sort(List<String> versions){
        versions.sort(getComparator());
        return versions;
    }

    /**
     * 获取版本比较器
     * 默认支持 x.y.z 这种类型
     */
    @Override
    public Comparator<String> getComparator(){
        return VersionComparators.PART;
    }

}
