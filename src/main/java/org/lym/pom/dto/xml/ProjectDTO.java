package org.lym.pom.dto.xml;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import lombok.Data;
import org.lym.pom.PojoMapConverter;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * @author lym
 */
@Data
@XStreamAlias("project")
public class ProjectDTO {

    private DependencyDTO parent;

    private String name;

    private String description;

    private String groupId;

    private String artifactId;

    private String version;

    @XStreamConverter(PojoMapConverter.class)
    private Map<String, String> properties = new HashMap<>();

    private DependencyManagementDTO dependencyManagement;

    private List<DependencyDTO> dependencies = new LinkedList<>();

    private BuildDTO build;

}
