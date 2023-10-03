package org.lym.pom.test;

import org.lym.pom.dto.xml.ProjectDTO;
import org.lym.pom.service.IProjectService;
import org.lym.pom.scheduled.SendNotifyTask;
import org.lym.pom.scheduled.VersionWatcherTask;
import org.lym.pom.util.XmlUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.FileInputStream;

/**
 * @author lym
 */
@RestController
@RequestMapping("test")
public class TestController {


    @Autowired
    private IProjectService projectService;

    @Autowired
    private VersionWatcherTask versionWatcherTask;

    @Autowired
    private SendNotifyTask sendNotifyTask;

    @Value("${localPath:F:/codes/java/projects/pom-update/pom.xml}")
    private String localPath;

    /**
     * http://localhost:12345/test/xml
     */
    //@RequestMapping("xml")
    public String mockUploadPomXml() throws Exception {
        File f = new File(localPath);
        ProjectDTO projectDTO = XmlUtil.xmlToObject(new FileInputStream(f));
        projectService.save(projectDTO);
        return "analyze pom.xml success";
    }

    /**
     * http://localhost:12345/test/version
     */
    @RequestMapping("version")
    public String checkVersion() throws Exception {
        versionWatcherTask.checkDependenciesHasUpdate();
        return "check version success";
    }

    /**
     * http://localhost:12345/test/notify
     */
    @RequestMapping("notify")
    public String sendNotify() throws Exception {
        sendNotifyTask.sendNotify();
        return "notify success";
    }

}
