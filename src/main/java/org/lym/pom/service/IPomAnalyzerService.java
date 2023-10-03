package org.lym.pom.service;

import org.lym.pom.dto.xml.ProjectDTO;
import org.springframework.web.multipart.MultipartFile;

/**
 * pom.xml 分析、转换
 * @author lym
 */
public interface IPomAnalyzerService {

    /**
     * 将 pom.xml 转化为 dto
     * @param file pom.xml
     * @return 分析完毕的 dto
     */
    ProjectDTO analysisPom(MultipartFile file);

}
