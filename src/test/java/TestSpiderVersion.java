import cn.hutool.core.lang.Console;
import cn.hutool.core.util.ReUtil;
import org.lym.pom.constant.ThirdProjectInfoSourceEnum;
import org.lym.pom.util.HttpsClientRequestFactory;
import org.lym.pom.util.UserAgentInterceptor;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * @author lym
 */
public class TestSpiderVersion {

    private static Map<String, Pattern> patternMap = new HashMap<>();

    public static void main(String[] args) {

        String groupId = "org.springframework";
        String artifactId = "spring-core";


        //https://search.maven.org/search?q=a:spring-tx

        // maven
        RestTemplate rest = new RestTemplate(new HttpsClientRequestFactory());
        rest.getInterceptors().add(new UserAgentInterceptor());
        // 目标网站
        String aimUrl;
        // 正则表达式
        String regex;
        Pattern pattern;
        // 返回内容
        String html;
        // 结果列表
        List<String> versionList;

        ThirdProjectInfoSourceEnum thirdProjectInfo = ThirdProjectInfoSourceEnum.MVN_JAR;
        // 目标网站
        aimUrl = thirdProjectInfo.getUrl(groupId, artifactId);
        // 正则表达式
        regex = thirdProjectInfo.getVersionsPattern();

        html = rest.getForObject(aimUrl, String.class);

        versionList = ReUtil.findAll(getPattern(regex), html, 1);
        for (String version : versionList) {
            //打印标题
            Console.log(version);
        }

        List<String> nameList = ReUtil.findAll(getPattern(thirdProjectInfo.getNamePattern()), html, 1);
        System.out.println("=============== name ==================");
        for (String version : nameList) {
            Console.log(version);
        }

        nameList = ReUtil.findAll(getPattern(thirdProjectInfo.getDescriptionPattern()), html, 1);
        System.out.println("=============== Description ==================");
        for (String version : nameList) {
            Console.log(version.trim());
        }

        nameList = ReUtil.findAll(getPattern(thirdProjectInfo.getHomeUrlPattern()), html, 1);
        System.out.println("=============== HomeUrl ==================");
        for (String version : nameList) {
            Console.log(version);
        }

        nameList = ReUtil.findAll(getPattern(thirdProjectInfo.getOpenSourceProtocolPattern()), html, 1);
        System.out.println("=============== OpenSourceProtocol ==================");
        for (String version : nameList) {
            Console.log(version.trim());
        }
    }

    private static Pattern getPattern(String regex){
        Pattern pattern = patternMap.get(regex);
        if(pattern == null){
            pattern = Pattern.compile(regex, Pattern.DOTALL);
            patternMap.put(regex, pattern);
        }
        return pattern;
    }
}
