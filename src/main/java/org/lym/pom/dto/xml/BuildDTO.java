package org.lym.pom.dto.xml;

import lombok.Data;

import java.util.LinkedList;
import java.util.List;

/**
 * @author lym
 */
@Data
public class BuildDTO {

    private PluginManagementDTO pluginManagement;

    private List<PluginDTO> plugins = new LinkedList<>();

}
