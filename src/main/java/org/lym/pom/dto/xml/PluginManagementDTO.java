package org.lym.pom.dto.xml;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import lombok.Data;

import java.util.LinkedList;
import java.util.List;

/**
 * @author lym
 */
@Data
@XStreamAlias("pluginManagement")
public class PluginManagementDTO {

    private List<PluginDTO> plugins = new LinkedList<>();
}
