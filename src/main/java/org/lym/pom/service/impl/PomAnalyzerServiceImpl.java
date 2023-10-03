package org.lym.pom.service.impl;

import org.lym.pom.dto.xml.ProjectDTO;
import org.lym.pom.service.IPomAnalyzerService;
import org.lym.pom.util.XmlUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;

/**
 * @author lym
 */
@Service
public class PomAnalyzerServiceImpl implements IPomAnalyzerService {

    @Override
    public ProjectDTO analysisPom(MultipartFile file){
        try {
            return analysisPom(file.getInputStream());
        } catch (Exception e) {
            throw new RuntimeException("invalid pom.xml file!", e);
        }

    }

    @Override
    public ProjectDTO analysisPom(InputStream pomXmlStream) {
        try {
            return XmlUtil.xmlToObject(pomXmlStream);
        } catch (Exception e) {
            throw new RuntimeException("invalid pom.xml file!", e);
        }
    }

}
