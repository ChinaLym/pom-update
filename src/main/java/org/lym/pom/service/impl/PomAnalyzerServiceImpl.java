package org.lym.pom.service.impl;

import org.lym.pom.dto.xml.ProjectDTO;
import org.lym.pom.service.IPomAnalyzerService;
import org.lym.pom.util.XmlUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author lym
 */
@Service
public class PomAnalyzerServiceImpl implements IPomAnalyzerService {

    @Override
    public ProjectDTO analysisPom(MultipartFile file){
        try {
            return XmlUtil.xmlToObject(file.getInputStream());
        } catch (Exception e) {
            throw new RuntimeException("invalid pom.xml file!", e);
        }
    }

}
