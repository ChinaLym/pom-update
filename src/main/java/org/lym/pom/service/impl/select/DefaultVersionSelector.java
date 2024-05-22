package org.lym.pom.service.impl.select;

import cn.hutool.core.util.StrUtil;

/**
 * 获取版本比较器
 * 支持 x.y.z 这种类型
 * @author lym
 */
public class DefaultVersionSelector  extends BaseVersionSelector {

    final String[] unstableMark = {"alpha", "-b", "beta", "-ea", "rc", "snapshot", "2003", "2004"};

    //apache commons 部分有 "2003/4"

    final String[] releaseMark = {"RELEASE", "SR", "STABLE", "RTM", "RTW", "RVL", "EVAL", "FINAL", "GA"};

    /**
     * 是否为稳定版
     */
    @Override
    public boolean isStable(String version){

        if(StrUtil.containsAnyIgnoreCase(version, releaseMark)){
            return true;
        }else if(StrUtil.containsAnyIgnoreCase(version, unstableMark)){
            return false;
        }
        return super.isStable(version);
    }

}
