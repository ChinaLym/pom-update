package org.lym.pom.controller;

import org.shoulder.core.converter.ShoulderConversionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

/**
 * base
 *
 * @author lym
 */
@RestController
public class BaseController {

    @Autowired
    protected ShoulderConversionService converionService;

    protected static String getCurrentUserInfo() {
        return null;
    }

}
