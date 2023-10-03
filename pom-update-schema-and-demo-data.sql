-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: db_pom_update
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user`
(
    `id`                                  varchar(64) COLLATE utf8_unicode_ci NOT NULL,
    `account`                             varchar(32) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `password`                            varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
    `name`                                varchar(32) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `email`                               varchar(64) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `phone`                               varchar(16) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `default_new_version_notify_strategy` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
    `create_time`                         datetime                             DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_project`
--

DROP TABLE IF EXISTS `tb_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_project`
(
    `id`          bigint                              NOT NULL AUTO_INCREMENT,
    `group_id`    varchar(64) COLLATE utf8_unicode_ci NOT NULL,
    `artifact_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
    `version`     varchar(64) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `name`        varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
    `description` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
    `user_id`     varchar(64) COLLATE utf8_unicode_ci NOT NULL,
    `status`      varchar(16) COLLATE utf8_unicode_ci  DEFAULT 'NOMARL',
    `create_time` datetime                             DEFAULT NULL,
    `update_time` datetime                             DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_dependency`
--

DROP TABLE IF EXISTS `tb_dependency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_dependency`
(
    `id`                          bigint                              NOT NULL AUTO_INCREMENT,
    `project_id`                  bigint                              NOT NULL,
    `group_id`                    varchar(64) COLLATE utf8_unicode_ci NOT NULL,
    `artifact_id`                 varchar(64) COLLATE utf8_unicode_ci NOT NULL,
    `version`                     varchar(64) COLLATE utf8_unicode_ci NOT NULL,
    `new_version_notify_strategy` varchar(32) COLLATE utf8_unicode_ci DEFAULT 'STABLE_ONLY',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5522 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_third_project`
--

DROP TABLE IF EXISTS `tb_third_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_third_project`
(
    `group_id`               varchar(64) COLLATE utf8_unicode_ci NOT NULL,
    `artifact_id`            varchar(64) COLLATE utf8_unicode_ci NOT NULL,
    `version`                varchar(64) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `stable_version`         varchar(64) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `name`                   varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
    `description`            varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
    `home_url`               varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
    `change_log_url`         varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
    `open_source_protocol`   varchar(64) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `stable_version_pattern` varchar(64) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `version_rule`           varchar(32) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `status`                 varchar(32) COLLATE utf8_unicode_ci  DEFAULT NULL,
    `update_time`            datetime                             DEFAULT NULL,
    PRIMARY KEY (`group_id`, `artifact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_notify_record`
--

DROP TABLE IF EXISTS `tb_notify_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_notify_record`
(
    `id`              bigint NOT NULL AUTO_INCREMENT,
    `project_id`      bigint                              DEFAULT NULL,
    `group_id`        varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
    `artifact_id`     varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
    `current_version` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
    `new_version`     varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
    `notified`        tinyint(1) DEFAULT NULL,
    `notify_time`     datetime                            DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=843 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-03 17:37:55



-------------------------------


--
-- Dumping data for table `tb_user`
--

LOCK
TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user`
VALUES ('1', 'demoUsername', 'demoPwd', 'demoName', 'demo@mail.com', '12345678901', 'ALWAYS', '2020-03-30 00:07:13');
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;
UNLOCK
TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Dumping data for table `tb_dependency`
--

LOCK
TABLES `tb_dependency` WRITE;
/*!40000 ALTER TABLE `tb_dependency` DISABLE KEYS */;
INSERT INTO `tb_dependency`
VALUES (499, 3, 'org.springframework.boot', 'spring-boot-starter-parent', '2.4.5', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (500, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (501, 3, 'cn.itlym.shoulder', 'lombok', '0.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (502, 3, 'cn.itlym', 'shoulder-core', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (503, 3, 'cn.itlym', 'shoulder-cluster', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (504, 3, 'cn.itlym', 'shoulder-crypto', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (505, 3, 'cn.itlym', 'shoulder-crypto-negotiation', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (506, 3, 'cn.itlym', 'shoulder-operation-log', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (507, 3, 'cn.itlym', 'shoulder-batch', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (508, 3, 'cn.itlym', 'shoulder-security', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (509, 3, 'cn.itlym', 'shoulder-security-code', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (510, 3, 'cn.itlym', 'shoulder-data-db', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (511, 3, 'cn.itlym', 'shoulder-http', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (512, 3, 'cn.itlym', 'shoulder-validation', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (513, 3, 'cn.itlym', 'shoulder-web', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (514, 3, 'cn.itlym', 'shoulder-api-doc', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (515, 3, 'cn.itlym', 'shoulder-monitor', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (516, 3, 'cn.itlym', 'shoulder-autoconfiguration', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (517, 3, 'cn.itlym', 'shoulder-starter', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (518, 3, 'cn.itlym', 'shoulder-starter-mysql', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (519, 3, 'cn.itlym', 'shoulder-starter-web', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (520, 3, 'cn.itlym', 'shoulder-starter-operation-log', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (521, 3, 'cn.itlym', 'shoulder-starter-beanmap', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (522, 3, 'cn.itlym', 'shoulder-starter-auth-session', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (523, 3, 'cn.itlym', 'shoulder-starter-auth-token', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (524, 3, 'cn.itlym', 'shoulder-starter-auth-server', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (525, 3, 'cn.itlym', 'shoulder-starter-security-code', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (526, 3, 'cn.itlym', 'shoulder-starter-crypto', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (527, 3, 'cn.itlym', 'shoulder-starter-monitor', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (528, 3, 'cn.itlym', 'shoulder-ext-common', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (529, 3, 'cn.itlym', 'shoulder-ext-config', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (530, 3, 'cn.itlym', 'shoulder-ext-dictionary', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (531, 3, 'cn.itlym', 'shoulder-ext-autoconfiguration', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (532, 3, 'io.swagger', 'swagger-annotations', '1.6.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (533, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.9', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (534, 3, 'io.springfox', 'springfox-core', '3.0.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (535, 3, 'io.springfox', 'springfox-boot-starter', '3.0.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (536, 3, 'com.github.xiaoymin', 'knife4j-spring-ui', '3.0.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (537, 3, 'com.github.xiaoymin', 'knife4j-spring-boot-starter', '3.0.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (538, 3, 'org.springframework.security.oauth.boot', 'spring-security-oauth2-autoconfigure', '2.4.5',
        'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (539, 3, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.0.RELEASE', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (540, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (541, 3, 'org.springframework.security.experimental', 'spring-security-oauth2-authorization-server', '0.1.0',
        'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (542, 3, 'com.univocity', 'univocity-parsers', '2.9.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (543, 3, 'com.thoughtworks.xstream', 'xstream', '1.4.17', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (544, 3, 'commons-codec', 'commons-codec', '1.15', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (545, 3, 'org.apache.commons', 'commons-collections4', '4.4', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (546, 3, 'commons-io', 'commons-io', '2.8.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (547, 3, 'commons-configuration', 'commons-configuration', '1.10', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (548, 3, 'org.apache.commons', 'commons-lang3', '3.11', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (549, 3, 'commons-daemon', 'commons-daemon', '1.2.4', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (550, 3, 'org.javassist', 'javassist', '3.27.0-GA', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (551, 3, 'javax.ws.rs', 'javax.ws.rs-api', '2.1.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (552, 3, 'com.belerweb', 'pinyin4j', '2.5.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (553, 3, 'cn.hutool', 'hutool-core', '5.6.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (554, 3, 'cn.hutool', 'hutool-all', '5.6.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (555, 3, 'cn.hutool', 'hutool-http', '5.6.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (556, 3, 'com.google.guava', 'guava', '30.1.1-jre', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (557, 3, 'com.google.code.findbugs', 'annotations', '3.0.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (558, 3, 'net.java.dev.jna', 'jna', '5.8.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (559, 3, 'org.mapstruct', 'mapstruct', '1.4.2.Final', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (560, 3, 'org.mapstruct', 'mapstruct-processor', '1.4.2.Final', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (561, 3, 'com.alibaba', 'transmittable-thread-local', '2.12.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (562, 3, 'org.bouncycastle', 'bcprov-jdk15on', '1.68', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (563, 3, 'org.bouncycastle', 'bcpkix-jdk15on', '1.68', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (564, 3, 'org.apache.tika', 'tika-core', '1.24.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (565, 3, 'com.github.chris2018998', 'beecp', '3.1.7', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (566, 3, 'p6spy', 'p6spy', '3.9.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (567, 3, 'com.h2database', 'h2', '1.4.200', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (568, 3, 'com.baomidou', 'mybatis-plus-boot-starter', '3.4.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (569, 3, 'com.baomidou', 'mybatis-plus-generator', '3.4.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (570, 3, 'com.github.pagehelper', 'pagehelper', '5.2.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (571, 3, 'com.github.pagehelper', 'pagehelper-spring-boot-starter', '1.3.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (572, 3, 'org.mockito', 'mockito-all', '1.10.19', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (573, 3, 'org.powermock', 'powermock-module-junit4', '2.0.9', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (574, 3, 'org.powermock', 'powermock-api-mockito', '2.0.9', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (575, 3, 'org.powermock', 'powermock-api-mockito2', '2.0.9', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (576, 3, 'org.springframework.boot', 'spring-boot-starter-parent', '2.4.5', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (577, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (578, 3, 'cn.itlym.shoulder', 'lombok', '0.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (579, 3, 'cn.itlym', 'shoulder-core', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (580, 3, 'cn.itlym', 'shoulder-cluster', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (581, 3, 'cn.itlym', 'shoulder-crypto', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (582, 3, 'cn.itlym', 'shoulder-crypto-negotiation', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (583, 3, 'cn.itlym', 'shoulder-operation-log', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (584, 3, 'cn.itlym', 'shoulder-batch', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (585, 3, 'cn.itlym', 'shoulder-security', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (586, 3, 'cn.itlym', 'shoulder-security-code', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (587, 3, 'cn.itlym', 'shoulder-data-db', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (588, 3, 'cn.itlym', 'shoulder-http', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (589, 3, 'cn.itlym', 'shoulder-validation', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (590, 3, 'cn.itlym', 'shoulder-web', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (591, 3, 'cn.itlym', 'shoulder-api-doc', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (592, 3, 'cn.itlym', 'shoulder-monitor', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (593, 3, 'cn.itlym', 'shoulder-autoconfiguration', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (594, 3, 'cn.itlym', 'shoulder-starter', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (595, 3, 'cn.itlym', 'shoulder-starter-mysql', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (596, 3, 'cn.itlym', 'shoulder-starter-web', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (597, 3, 'cn.itlym', 'shoulder-starter-operation-log', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (598, 3, 'cn.itlym', 'shoulder-starter-beanmap', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (599, 3, 'cn.itlym', 'shoulder-starter-auth-session', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (600, 3, 'cn.itlym', 'shoulder-starter-auth-token', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (601, 3, 'cn.itlym', 'shoulder-starter-auth-server', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (602, 3, 'cn.itlym', 'shoulder-starter-security-code', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (603, 3, 'cn.itlym', 'shoulder-starter-crypto', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (604, 3, 'cn.itlym', 'shoulder-starter-monitor', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (605, 3, 'cn.itlym', 'shoulder-ext-common', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (606, 3, 'cn.itlym', 'shoulder-ext-config', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (607, 3, 'cn.itlym', 'shoulder-ext-dictionary', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (608, 3, 'cn.itlym', 'shoulder-ext-autoconfiguration', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (609, 3, 'io.swagger', 'swagger-annotations', '1.6.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (610, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.9', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (611, 3, 'io.springfox', 'springfox-core', '3.0.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (612, 3, 'io.springfox', 'springfox-boot-starter', '3.0.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (613, 3, 'com.github.xiaoymin', 'knife4j-spring-ui', '3.0.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (614, 3, 'com.github.xiaoymin', 'knife4j-spring-boot-starter', '3.0.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (615, 3, 'org.springframework.security.oauth.boot', 'spring-security-oauth2-autoconfigure', '2.4.5',
        'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (616, 3, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.0.RELEASE', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (617, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (618, 3, 'org.springframework.security.experimental', 'spring-security-oauth2-authorization-server', '0.1.0',
        'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (619, 3, 'com.univocity', 'univocity-parsers', '2.9.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (620, 3, 'com.thoughtworks.xstream', 'xstream', '1.4.17', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (621, 3, 'commons-codec', 'commons-codec', '1.15', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (622, 3, 'org.apache.commons', 'commons-collections4', '4.4', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (623, 3, 'commons-io', 'commons-io', '2.8.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (624, 3, 'commons-configuration', 'commons-configuration', '1.10', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (625, 3, 'org.apache.commons', 'commons-lang3', '3.11', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (626, 3, 'commons-daemon', 'commons-daemon', '1.2.4', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (627, 3, 'org.javassist', 'javassist', '3.27.0-GA', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (628, 3, 'javax.ws.rs', 'javax.ws.rs-api', '2.1.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (629, 3, 'com.belerweb', 'pinyin4j', '2.5.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (630, 3, 'cn.hutool', 'hutool-core', '5.6.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (631, 3, 'cn.hutool', 'hutool-all', '5.6.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (632, 3, 'cn.hutool', 'hutool-http', '5.6.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (633, 3, 'com.google.guava', 'guava', '30.1.1-jre', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (634, 3, 'com.google.code.findbugs', 'annotations', '3.0.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (635, 3, 'net.java.dev.jna', 'jna', '5.8.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (636, 3, 'org.mapstruct', 'mapstruct', '1.4.2.Final', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (637, 3, 'org.mapstruct', 'mapstruct-processor', '1.4.2.Final', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (638, 3, 'com.alibaba', 'transmittable-thread-local', '2.12.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (639, 3, 'org.bouncycastle', 'bcprov-jdk15on', '1.68', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (640, 3, 'org.bouncycastle', 'bcpkix-jdk15on', '1.68', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (641, 3, 'org.apache.tika', 'tika-core', '1.24.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (642, 3, 'com.github.chris2018998', 'beecp', '3.1.7', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (643, 3, 'p6spy', 'p6spy', '3.9.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (644, 3, 'com.h2database', 'h2', '1.4.200', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (645, 3, 'com.baomidou', 'mybatis-plus-boot-starter', '3.4.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (646, 3, 'com.baomidou', 'mybatis-plus-generator', '3.4.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (647, 3, 'com.github.pagehelper', 'pagehelper', '5.2.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (648, 3, 'com.github.pagehelper', 'pagehelper-spring-boot-starter', '1.3.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (649, 3, 'org.mockito', 'mockito-all', '1.10.19', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (650, 3, 'org.powermock', 'powermock-module-junit4', '2.0.9', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (651, 3, 'org.powermock', 'powermock-api-mockito', '2.0.9', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (652, 3, 'org.powermock', 'powermock-api-mockito2', '2.0.9', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (1786, 11, 'org.jsoup', 'jsoup', '1.15.4', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (1787, 11, 'org.lz4', 'lz4-java', '1.8.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (1788, 11, 'com.aliyun.oss', 'aliyun-sdk-oss', '3.8.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (1789, 11, 'javax.xml.bind', 'jaxb-api', '2.3.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (1790, 11, 'javax.activation', 'activation', '1.1.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (1791, 11, 'org.glassfish.jaxb', 'jaxb-runtime', '2.3.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (1792, 11, 'net.sourceforge.tess4j', 'tess4j', '5.6.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3760, 12, 'cn.itlym', 'shoulder-dependencies', '0.7-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3761, 12, 'cn.itlym.shoulder', 'shoulder-maven-plugin', '1.2.1-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3762, 12, 'org.apache.maven.plugins', 'maven-compiler-plugin', '3.11.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3763, 12, 'org.codehaus.mojo', 'license-maven-plugin', '2.0.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3764, 12, 'org.apache.maven.plugins', 'maven-source-plugin', '3.2.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3765, 12, 'org.apache.maven.plugins', 'maven-javadoc-plugin', '3.2.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3766, 12, 'org.apache.maven.plugins', 'maven-gpg-plugin', '3.1.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3767, 12, 'org.codehaus.mojo', 'findbugs-maven-plugin', '3.0.5', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3768, 12, 'org.apache.maven.plugins', 'maven-surefire-plugin', '3.0.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3769, 12, 'org.codehaus.mojo', 'cobertura-maven-plugin', '2.7', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3770, 12, 'org.codehaus.mojo', 'sonar-maven-plugin', '3.7.0.1746', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3771, 12, 'org.codehaus.mojo', 'versions-maven-plugin', '2.7', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3772, 12, 'org.apache.maven.plugins', 'maven-jar-plugin', '3.3.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3773, 12, 'pl.project13.maven', 'git-commit-id-plugin', '2.1.5', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3774, 13, 'org.codehaus.mojo', 'license-maven-plugin', '2.2.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3775, 13, 'org.sonatype.plugins', 'nexus-staging-maven-plugin', '1.6.13', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3776, 13, 'org.apache.maven.plugins', 'maven-gpg-plugin', '3.0.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3864, 23, 'org.apache.maven.plugins', 'maven-resources-plugin', '3.3.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (3865, 23, 'org.apache.maven.plugins', 'maven-archetype-plugin', '3.2.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5443, 10, 'cn.itlym', 'shoulder-framework', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5444, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5445, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5446, 10, 'org.projectlombok', 'lombok', '1.18.30', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5447, 10, 'cn.itlym.shoulder', 'lombok', '0.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5448, 10, 'org.redisson', 'redisson', '3.23.5', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5449, 10, 'cn.itlym', 'shoulder-core', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5450, 10, 'cn.itlym', 'shoulder-cluster', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5451, 10, 'cn.itlym', 'shoulder-crypto', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5452, 10, 'cn.itlym', 'shoulder-crypto-negotiation', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5453, 10, 'cn.itlym', 'shoulder-operation-log', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5454, 10, 'cn.itlym', 'shoulder-batch', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5455, 10, 'cn.itlym', 'shoulder-security', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5456, 10, 'cn.itlym', 'shoulder-security-code', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5457, 10, 'cn.itlym', 'shoulder-data-db', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5458, 10, 'cn.itlym', 'shoulder-http', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5459, 10, 'cn.itlym', 'shoulder-validation', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5460, 10, 'cn.itlym', 'shoulder-web', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5461, 10, 'cn.itlym', 'shoulder-api-doc', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5462, 10, 'cn.itlym', 'shoulder-monitor', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5463, 10, 'cn.itlym', 'shoulder-autoconfiguration', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5464, 10, 'cn.itlym', 'shoulder-starter', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5465, 10, 'cn.itlym', 'shoulder-starter-mysql', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5466, 10, 'cn.itlym', 'shoulder-starter-web', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5467, 10, 'cn.itlym', 'shoulder-starter-operation-log', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5468, 10, 'cn.itlym', 'shoulder-starter-auth-session', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5469, 10, 'cn.itlym', 'shoulder-starter-auth-token', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5470, 10, 'cn.itlym', 'shoulder-starter-auth-server', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5471, 10, 'cn.itlym', 'shoulder-starter-security-code', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5472, 10, 'cn.itlym', 'shoulder-starter-crypto', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5473, 10, 'cn.itlym', 'shoulder-starter-monitor', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5474, 10, 'cn.itlym', 'shoulder-ext-common', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5475, 10, 'cn.itlym', 'shoulder-ext-config', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5476, 10, 'cn.itlym', 'shoulder-ext-dictionary', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5477, 10, 'cn.itlym', 'shoulder-ext-autoconfiguration', '0.8-SNAPSHOT', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5478, 10, 'io.swagger', 'swagger-annotations', '1.6.11', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5479, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.16', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5480, 10, 'io.springfox', 'springfox-core', '3.0.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5481, 10, 'io.springfox', 'springfox-boot-starter', '3.0.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5482, 10, 'com.github.xiaoymin', 'knife4j-spring-ui', '3.0.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5483, 10, 'com.github.xiaoymin', 'knife4j-spring-boot-starter', '3.0.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5484, 10, 'org.springframework.security.oauth.boot', 'spring-security-oauth2-autoconfigure', '2.6.8',
        'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5485, 10, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.2.RELEASE', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5486, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.35', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5487, 10, 'org.springframework.security.experimental', 'spring-security-oauth2-authorization-server', '0.1.2',
        'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5488, 10, 'com.univocity', 'univocity-parsers', '2.9.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5489, 10, 'com.thoughtworks.xstream', 'xstream', '1.4.20', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5490, 10, 'commons-codec', 'commons-codec', '1.16.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5491, 10, 'org.apache.commons', 'commons-collections4', '4.4', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5492, 10, 'commons-io', 'commons-io', '2.13.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5493, 10, 'commons-configuration', 'commons-configuration', '1.10', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5494, 10, 'org.apache.commons', 'commons-lang3', '3.13.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5495, 10, 'commons-daemon', 'commons-daemon', '1.3.4', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5496, 10, 'org.javassist', 'javassist', '3.29.2-GA', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5497, 10, 'javax.ws.rs', 'javax.ws.rs-api', '2.1.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5498, 10, 'com.belerweb', 'pinyin4j', '2.5.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5499, 10, 'cn.hutool', 'hutool-core', '5.8.22', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5500, 10, 'cn.hutool', 'hutool-all', '5.8.22', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5501, 10, 'cn.hutool', 'hutool-http', '5.8.22', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5502, 10, 'com.google.guava', 'guava', '32.1.2-jre', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5503, 10, 'com.google.code.findbugs', 'annotations', '3.0.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5504, 10, 'net.java.dev.jna', 'jna', '5.13.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5505, 10, 'org.mapstruct', 'mapstruct', '1.5.5.Final', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5506, 10, 'org.mapstruct', 'mapstruct-processor', '1.5.5.Final', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5507, 10, 'com.alibaba', 'transmittable-thread-local', '2.14.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5508, 10, 'org.bouncycastle', 'bcprov-jdk15on', '1.70', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5509, 10, 'org.bouncycastle', 'bcpkix-jdk15on', '1.70', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5510, 10, 'org.apache.tika', 'tika-core', '2.9.0', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5511, 10, 'com.github.chris2018998', 'beecp', '3.4.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5512, 10, 'p6spy', 'p6spy', '3.9.1', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5513, 10, 'com.h2database', 'h2', '2.2.224', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5514, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5515, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.2', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5516, 10, 'com.github.pagehelper', 'pagehelper', '5.3.3', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5517, 10, 'com.github.pagehelper', 'pagehelper-spring-boot-starter', '1.4.7', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5518, 10, 'org.mockito', 'mockito-all', '1.10.19', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5519, 10, 'org.powermock', 'powermock-module-junit4', '2.0.9', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5520, 10, 'org.powermock', 'powermock-api-mockito', '2.0.9', 'STABLE_ONLY');
INSERT INTO `tb_dependency`
VALUES (5521, 10, 'org.powermock', 'powermock-api-mockito2', '2.0.9', 'STABLE_ONLY');
/*!40000 ALTER TABLE `tb_dependency` ENABLE KEYS */;
UNLOCK
TABLES;

--
-- Dumping data for table `tb_notify_record`
--

LOCK
TABLES `tb_notify_record` WRITE;
/*!40000 ALTER TABLE `tb_notify_record` DISABLE KEYS */;
INSERT INTO `tb_notify_record`
VALUES (1, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.6.4', 1, '2021-05-30 03:25:19');
INSERT INTO `tb_notify_record`
VALUES (2, 3, 'com.alibaba', 'transmittable-thread-local', '2.12.0', '2.13.0-Beta1', 1, '2021-05-30 03:14:53');
INSERT INTO `tb_notify_record`
VALUES (3, 3, 'com.baomidou', 'mybatis-plus-boot-starter', '3.4.0', '3.4.2', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (4, 3, 'com.baomidou', 'mybatis-plus-generator', '3.4.0', '3.4.1', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (5, 3, 'com.google.code.findbugs', 'annotations', '3.0.0', '3.0.1u2', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (6, 3, 'com.google.guava', 'guava', '29.0-jre', 'r09', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (7, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.8.1', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (8, 3, 'commons-codec', 'commons-codec', '1.14', '20041127.091804', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (9, 3, 'commons-configuration', 'commons-configuration', '1.9', '20041012.002804', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (10, 3, 'commons-daemon', 'commons-daemon', '1.2.2', '1.2.4', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (11, 3, 'commons-io', 'commons-io', '2.7', '20030203.000550', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (12, 3, 'io.swagger', 'swagger-annotations', '1.6.2', '2.0.0-rc2', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (13, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.2', '2.1.9', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (14, 3, 'javax.ws.rs', 'javax.ws.rs-api', '2.1.1', '2.1-m09', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (15, 3, 'net.java.dev.jna', 'jna', '5.5.0', '5.8.0', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (16, 3, 'org.apache.commons', 'commons-lang3', '3.11', '3.12.0', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (17, 3, 'org.apache.tika', 'tika-core', '1.24.1', '2.0.0-ALPHA', 1, '2021-05-30 02:23:19');
INSERT INTO `tb_notify_record`
VALUES (18, 3, 'org.bouncycastle', 'bcpkix-jdk15on', '1.66', '1.68', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (19, 3, 'org.bouncycastle', 'bcprov-jdk15on', '1.66', '1.68', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (20, 3, 'org.mockito', 'mockito-all', '1.10.19', '2.0.2-beta', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (21, 3, 'org.powermock', 'powermock-api-mockito2', '1.7.4', '2.0.9', 1, '2021-05-29 23:23:11');
INSERT INTO `tb_notify_record`
VALUES (22, 3, 'org.powermock', 'powermock-module-junit4', '1.7.4', '2.0.9', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (23, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', 'Hoxton.SR9', 1,
        '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (24, 3, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.0.RELEASE', '2.5.1.RELEASE', 1,
        '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (25, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.6.4', 1, '2021-05-30 03:28:14');
INSERT INTO `tb_notify_record`
VALUES (26, 3, 'com.alibaba', 'transmittable-thread-local', '2.12.0', '2.13.0-Beta1', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (27, 3, 'com.baomidou', 'mybatis-plus-boot-starter', '3.4.0', '3.4.2', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (28, 3, 'com.baomidou', 'mybatis-plus-generator', '3.4.0', '3.4.1', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (29, 3, 'com.google.code.findbugs', 'annotations', '3.0.0', '3.0.1u2', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (30, 3, 'com.google.guava', 'guava', '29.0-jre', 'r09', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (31, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.8.1', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (32, 3, 'commons-codec', 'commons-codec', '1.14', '20041127.091804', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (33, 3, 'commons-configuration', 'commons-configuration', '1.9', '20041012.002804', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (34, 3, 'commons-daemon', 'commons-daemon', '1.2.2', '1.2.4', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (35, 3, 'commons-io', 'commons-io', '2.7', '20030203.000550', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (36, 3, 'io.swagger', 'swagger-annotations', '1.6.2', '2.0.0-rc2', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (37, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.2', '2.1.9', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (38, 3, 'javax.ws.rs', 'javax.ws.rs-api', '2.1.1', '2.1-m09', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (39, 3, 'net.java.dev.jna', 'jna', '5.5.0', '5.8.0', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (40, 3, 'org.apache.commons', 'commons-lang3', '3.11', '3.12.0', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (41, 3, 'org.apache.tika', 'tika-core', '1.24.1', '2.0.0-ALPHA', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (42, 3, 'org.bouncycastle', 'bcpkix-jdk15on', '1.66', '1.68', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (43, 3, 'org.bouncycastle', 'bcprov-jdk15on', '1.66', '1.68', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (44, 3, 'org.mockito', 'mockito-all', '1.10.19', '2.0.2-beta', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (45, 3, 'org.powermock', 'powermock-api-mockito2', '1.7.4', '2.0.9', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (46, 3, 'org.powermock', 'powermock-module-junit4', '1.7.4', '2.0.9', 1, '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (47, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', 'Hoxton.SR9', 1,
        '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (48, 3, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.0.RELEASE', '2.5.1.RELEASE', 1,
        '2021-04-26 02:29:59');
INSERT INTO `tb_notify_record`
VALUES (49, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.6.4', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (50, 3, 'com.alibaba', 'transmittable-thread-local', '2.12.0', '2.13.0-Beta1', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (51, 3, 'com.baomidou', 'mybatis-plus-boot-starter', '3.4.0', '3.4.2', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (52, 3, 'com.baomidou', 'mybatis-plus-generator', '3.4.0', '3.4.1', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (53, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.8.1', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (54, 3, 'commons-daemon', 'commons-daemon', '1.2.2', '1.2.4', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (55, 3, 'io.swagger', 'swagger-annotations', '1.6.2', '2.0.0-rc2', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (56, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.2', '2.1.9', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (57, 3, 'net.java.dev.jna', 'jna', '5.5.0', '5.8.0', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (58, 3, 'org.apache.commons', 'commons-lang3', '3.11', '3.12.0', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (59, 3, 'org.apache.tika', 'tika-core', '1.24.1', '2.0.0-ALPHA', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (60, 3, 'org.bouncycastle', 'bcpkix-jdk15on', '1.66', '1.68', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (61, 3, 'org.bouncycastle', 'bcprov-jdk15on', '1.66', '1.68', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (62, 3, 'org.mockito', 'mockito-all', '1.10.19', '2.0.2-beta', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (63, 3, 'org.powermock', 'powermock-api-mockito2', '1.7.4', '2.0.9', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (64, 3, 'org.powermock', 'powermock-module-junit4', '1.7.4', '2.0.9', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (65, 3, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.0.RELEASE', '2.5.1.RELEASE', 1,
        '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (66, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.6.4', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (67, 3, 'com.alibaba', 'transmittable-thread-local', '2.12.0', '2.13.0-Beta1', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (68, 3, 'com.baomidou', 'mybatis-plus-boot-starter', '3.4.0', '3.4.2', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (69, 3, 'com.baomidou', 'mybatis-plus-generator', '3.4.0', '3.4.1', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (70, 3, 'com.google.code.findbugs', 'annotations', '3.0.0', '3.0.1', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (71, 3, 'com.google.guava', 'guava', '29.0-jre', '30.1.1-jre', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (72, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.8.1', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (73, 3, 'commons-daemon', 'commons-daemon', '1.2.2', '1.2.4', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (74, 3, 'io.swagger', 'swagger-annotations', '1.6.2', '2.0.0-rc2', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (75, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.2', '2.1.9', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (76, 3, 'net.java.dev.jna', 'jna', '5.5.0', '5.8.0', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (77, 3, 'org.apache.commons', 'commons-lang3', '3.11', '3.12.0', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (78, 3, 'org.apache.tika', 'tika-core', '1.24.1', '2.0.0-ALPHA', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (79, 3, 'org.bouncycastle', 'bcpkix-jdk15on', '1.66', '1.68', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (80, 3, 'org.bouncycastle', 'bcprov-jdk15on', '1.66', '1.68', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (81, 3, 'org.mockito', 'mockito-all', '1.10.19', '2.0.2-beta', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (82, 3, 'org.powermock', 'powermock-api-mockito2', '1.7.4', '2.0.9', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (83, 3, 'org.powermock', 'powermock-module-junit4', '1.7.4', '2.0.9', 1, '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (84, 3, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.0.RELEASE', '2.5.1.RELEASE', 1,
        '2021-04-26 02:44:43');
INSERT INTO `tb_notify_record`
VALUES (100, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.6.6', 1, '2021-05-29 23:03:44');
INSERT INTO `tb_notify_record`
VALUES (101, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.6.6', 1, '2021-05-29 23:03:44');
INSERT INTO `tb_notify_record`
VALUES (102, 3, 'cn.hutool', 'hutool-core', '5.6.3', '5.6.6', 1, '2021-05-29 23:03:44');
INSERT INTO `tb_notify_record`
VALUES (103, 3, 'cn.hutool', 'hutool-core', '5.6.3', '5.6.6', 1, '2021-05-29 23:03:44');
INSERT INTO `tb_notify_record`
VALUES (104, 3, 'cn.hutool', 'hutool-http', '5.6.3', '5.6.6', 1, '2021-05-29 23:03:44');
INSERT INTO `tb_notify_record`
VALUES (105, 3, 'cn.hutool', 'hutool-http', '5.6.3', '5.6.6', 1, '2021-05-29 23:03:44');
INSERT INTO `tb_notify_record`
VALUES (106, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', '2020.0.3', 1,
        '2021-05-29 23:03:44');
INSERT INTO `tb_notify_record`
VALUES (107, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', '2020.0.3', 1,
        '2021-05-29 23:03:44');
INSERT INTO `tb_notify_record`
VALUES (108, 3, 'org.springframework.security.oauth.boot', 'spring-security-oauth2-autoconfigure', '2.4.5', '2.5.0', 1,
        '2021-05-29 23:03:44');
INSERT INTO `tb_notify_record`
VALUES (109, 3, 'org.springframework.security.oauth.boot', 'spring-security-oauth2-autoconfigure', '2.4.5', '2.5.0', 1,
        '2021-05-29 23:03:44');
INSERT INTO `tb_notify_record`
VALUES (110, 10, 'io.swagger', 'swagger-annotations', '1.6.5', '1.6.2', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (111, 10, 'org.springframework.security.oauth.boot', 'spring-security-oauth2-autoconfigure', '2.4.5', '2.5.0', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (112, 10, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.0.RELEASE', '2.5.1.RELEASE', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (113, 10, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.9.3', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (114, 10, 'org.springframework.security.experimental', 'spring-security-oauth2-authorization-server', '0.1.0',
        '0.1.1', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (115, 10, 'commons-io', 'commons-io', '2.8.0', '2.9.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (116, 10, 'org.apache.commons', 'commons-lang3', '3.11', '3.12.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (117, 10, 'com.google.code.findbugs', 'annotations', '3.0.0', '3.0.1', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (118, 10, 'com.alibaba', 'transmittable-thread-local', '2.12.5', '2.12.1', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (119, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.8.15', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (120, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.8.15', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (121, 10, 'cn.hutool', 'hutool-all', '5.7.22', '5.8.15', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (122, 3, 'cn.hutool', 'hutool-core', '5.6.3', '5.8.15', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (123, 3, 'cn.hutool', 'hutool-core', '5.6.3', '5.8.15', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (124, 10, 'cn.hutool', 'hutool-core', '5.7.22', '5.8.15', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (125, 3, 'cn.hutool', 'hutool-http', '5.6.3', '5.8.15', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (126, 3, 'cn.hutool', 'hutool-http', '5.6.3', '5.8.15', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (127, 10, 'cn.hutool', 'hutool-http', '5.7.22', '5.8.15', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (130, 3, 'com.alibaba', 'transmittable-thread-local', '2.12.1', '2.14.2', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (131, 3, 'com.alibaba', 'transmittable-thread-local', '2.12.1', '2.14.2', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (132, 10, 'com.alibaba', 'transmittable-thread-local', '2.12.5', '2.14.2', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (133, 3, 'com.baomidou', 'mybatis-plus-boot-starter', '3.4.2', '3.5.3.1', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (134, 3, 'com.baomidou', 'mybatis-plus-boot-starter', '3.4.2', '3.5.3.1', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (135, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.1', '3.5.3.1', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (136, 3, 'com.baomidou', 'mybatis-plus-generator', '3.4.2', '3.5.3.1', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (137, 3, 'com.baomidou', 'mybatis-plus-generator', '3.4.2', '3.5.3.1', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (138, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.1', '3.5.3.1', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (139, 3, 'com.github.chris2018998', 'beecp', '3.1.7', '3.4.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (140, 3, 'com.github.chris2018998', 'beecp', '3.1.7', '3.4.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (141, 10, 'com.github.chris2018998', 'beecp', '3.3.2', '3.4.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (142, 3, 'com.github.pagehelper', 'pagehelper', '5.2.0', '5.3.2', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (143, 3, 'com.github.pagehelper', 'pagehelper', '5.2.0', '5.3.2', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (144, 10, 'com.github.pagehelper', 'pagehelper', '5.3.0', '5.3.2', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (145, 3, 'com.github.pagehelper', 'pagehelper-spring-boot-starter', '1.3.0', '1.4.6', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (146, 3, 'com.github.pagehelper', 'pagehelper-spring-boot-starter', '1.3.0', '1.4.6', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (147, 10, 'com.github.pagehelper', 'pagehelper-spring-boot-starter', '1.4.1', '1.4.6', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (148, 3, 'com.github.xiaoymin', 'knife4j-spring-boot-starter', '3.0.2', '3.0.3', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (149, 3, 'com.github.xiaoymin', 'knife4j-spring-boot-starter', '3.0.2', '3.0.3', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (150, 10, 'com.github.xiaoymin', 'knife4j-spring-boot-starter', '3.0.2', '3.0.3', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (151, 3, 'com.github.xiaoymin', 'knife4j-spring-ui', '3.0.2', '3.0.3', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (152, 3, 'com.github.xiaoymin', 'knife4j-spring-ui', '3.0.2', '3.0.3', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (153, 10, 'com.github.xiaoymin', 'knife4j-spring-ui', '3.0.2', '3.0.3', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (154, 3, 'com.google.guava', 'guava', '30.1.1-jre', '31.1-jre', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (155, 3, 'com.google.guava', 'guava', '30.1.1-jre', '31.1-jre', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (156, 3, 'com.h2database', 'h2', '1.4.200', '2.1.214', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (157, 3, 'com.h2database', 'h2', '1.4.200', '2.1.214', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (158, 10, 'com.h2database', 'h2', '2.1.210', '2.1.214', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (159, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.31', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (160, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.31', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (161, 10, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.31', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (162, 3, 'com.thoughtworks.xstream', 'xstream', '1.4.17', '1.4.20', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (163, 3, 'com.thoughtworks.xstream', 'xstream', '1.4.17', '1.4.20', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (166, 10, 'com.thoughtworks.xstream', 'xstream', '1.4.19', '1.4.20', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (167, 3, 'commons-daemon', 'commons-daemon', '1.2.4', '1.3.3', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (168, 3, 'commons-daemon', 'commons-daemon', '1.2.4', '1.3.3', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (169, 10, 'commons-daemon', 'commons-daemon', '1.2.4', '1.3.3', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (170, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.9', '2.2.8', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (171, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.9', '2.2.8', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (172, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.1.13', '2.2.8', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (173, 3, 'net.java.dev.jna', 'jna', '5.8.0', '5.13.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (174, 3, 'net.java.dev.jna', 'jna', '5.8.0', '5.13.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (175, 10, 'net.java.dev.jna', 'jna', '5.8.0', '5.13.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (176, 3, 'org.apache.tika', 'tika-core', '1.24.1', '2.7.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (177, 3, 'org.apache.tika', 'tika-core', '1.24.1', '2.7.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (178, 10, 'org.apache.tika', 'tika-core', '2.3.0', '2.7.0', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (179, 3, 'org.bouncycastle', 'bcpkix-jdk15on', '1.68', '1.70', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (180, 3, 'org.bouncycastle', 'bcpkix-jdk15on', '1.68', '1.70', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (181, 3, 'org.bouncycastle', 'bcprov-jdk15on', '1.68', '1.70', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (182, 3, 'org.bouncycastle', 'bcprov-jdk15on', '1.68', '1.70', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (183, 3, 'org.javassist', 'javassist', '3.27.0-GA', '3.29.2-GA', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (184, 3, 'org.javassist', 'javassist', '3.27.0-GA', '3.29.2-GA', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (185, 3, 'org.mapstruct', 'mapstruct', '1.4.2.Final', '1.5.3.Final', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (186, 3, 'org.mapstruct', 'mapstruct', '1.4.2.Final', '1.5.3.Final', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (187, 10, 'org.mapstruct', 'mapstruct', '1.4.2.Final', '1.5.3.Final', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (188, 3, 'org.mapstruct', 'mapstruct-processor', '1.4.2.Final', '1.5.3.Final', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (189, 3, 'org.mapstruct', 'mapstruct-processor', '1.4.2.Final', '1.5.3.Final', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (190, 10, 'org.mapstruct', 'mapstruct-processor', '1.4.2.Final', '1.5.3.Final', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (193, 10, 'org.projectlombok', 'lombok', '1.18.24', '1.18.26', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (194, 3, 'org.springframework.boot', 'spring-boot-starter-parent', '2.4.5', '3.0.4', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (195, 3, 'org.springframework.boot', 'spring-boot-starter-parent', '2.4.5', '3.0.4', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (196, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.6.4', '3.0.4', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (197, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', '2022.0.1', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (198, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', '2022.0.1', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (199, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.1', '2022.0.1', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (200, 3, 'org.springframework.security.experimental', 'spring-security-oauth2-authorization-server', '0.1.0',
        '0.1.2', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (201, 3, 'org.springframework.security.experimental', 'spring-security-oauth2-authorization-server', '0.1.0',
        '0.1.2', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (202, 10, 'org.springframework.security.experimental', 'spring-security-oauth2-authorization-server', '0.1.0',
        '0.1.2', 1, '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (203, 3, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.0.RELEASE', '2.5.2.RELEASE', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (204, 3, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.0.RELEASE', '2.5.2.RELEASE', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (205, 10, 'org.springframework.security.oauth', 'spring-security-oauth2', '2.5.0.RELEASE', '2.5.2.RELEASE', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (206, 3, 'org.springframework.security.oauth.boot', 'spring-security-oauth2-autoconfigure', '2.4.5', '2.6.8', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (207, 3, 'org.springframework.security.oauth.boot', 'spring-security-oauth2-autoconfigure', '2.4.5', '2.6.8', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (208, 10, 'org.springframework.security.oauth.boot', 'spring-security-oauth2-autoconfigure', '2.4.5', '2.6.8', 1,
        '2023-03-19 09:53:03');
INSERT INTO `tb_notify_record`
VALUES (209, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.9', '3.0.4', 1, '2023-03-19 10:21:58');
INSERT INTO `tb_notify_record`
VALUES (210, 10, 'org.apache.commons', 'commons-lang3', '3.12', '3.12.0', 1, '2023-03-19 10:21:58');
INSERT INTO `tb_notify_record`
VALUES (211, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.8.20', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (212, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.8.20', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (213, 10, 'cn.hutool', 'hutool-all', '5.8.15', '5.8.20', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (214, 3, 'cn.hutool', 'hutool-core', '5.6.3', '5.8.20', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (215, 3, 'cn.hutool', 'hutool-core', '5.6.3', '5.8.20', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (216, 10, 'cn.hutool', 'hutool-core', '5.8.15', '5.8.20', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (217, 3, 'cn.hutool', 'hutool-http', '5.6.3', '5.8.20', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (218, 3, 'cn.hutool', 'hutool-http', '5.6.3', '5.8.20', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (219, 10, 'cn.hutool', 'hutool-http', '5.8.15', '5.8.20', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (222, 3, 'com.alibaba', 'transmittable-thread-local', '2.12.1', '2.14.3', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (223, 3, 'com.alibaba', 'transmittable-thread-local', '2.12.1', '2.14.3', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (224, 10, 'com.alibaba', 'transmittable-thread-local', '2.14.2', '2.14.3', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (225, 3, 'com.github.chris2018998', 'beecp', '3.1.7', '3.4.1', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (226, 3, 'com.github.chris2018998', 'beecp', '3.1.7', '3.4.1', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (227, 10, 'com.github.chris2018998', 'beecp', '3.4.0', '3.4.1', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (228, 3, 'com.github.pagehelper', 'pagehelper', '5.2.0', '5.3.3', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (229, 3, 'com.github.pagehelper', 'pagehelper', '5.2.0', '5.3.3', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (230, 10, 'com.github.pagehelper', 'pagehelper', '5.3.2', '5.3.3', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (231, 3, 'com.github.pagehelper', 'pagehelper-spring-boot-starter', '1.3.0', '1.4.7', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (232, 3, 'com.github.pagehelper', 'pagehelper-spring-boot-starter', '1.3.0', '1.4.7', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (233, 10, 'com.github.pagehelper', 'pagehelper-spring-boot-starter', '1.4.6', '1.4.7', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (234, 3, 'com.google.guava', 'guava', '30.1.1-jre', '32.1.1-jre', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (235, 3, 'com.google.guava', 'guava', '30.1.1-jre', '32.1.1-jre', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (236, 10, 'com.google.guava', 'guava', '31.1-jre', '32.1.1-jre', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (237, 3, 'com.h2database', 'h2', '1.4.200', '2.2.220', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (238, 3, 'com.h2database', 'h2', '1.4.200', '2.2.220', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (239, 10, 'com.h2database', 'h2', '2.1.214', '2.2.220', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (240, 3, 'commons-daemon', 'commons-daemon', '1.2.4', '1.3.4', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (241, 3, 'commons-daemon', 'commons-daemon', '1.2.4', '1.3.4', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (242, 10, 'commons-daemon', 'commons-daemon', '1.3.3', '1.3.4', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (243, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.9', '2.2.15', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (244, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.9', '2.2.15', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (245, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.8', '2.2.15', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (246, 3, 'org.apache.tika', 'tika-core', '1.24.1', '2.8.0', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (247, 3, 'org.apache.tika', 'tika-core', '1.24.1', '2.8.0', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (248, 10, 'org.apache.tika', 'tika-core', '2.7.0', '2.8.0', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (249, 3, 'org.mapstruct', 'mapstruct', '1.4.2.Final', '1.5.5.Final', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (250, 3, 'org.mapstruct', 'mapstruct', '1.4.2.Final', '1.5.5.Final', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (251, 10, 'org.mapstruct', 'mapstruct', '1.5.3.Final', '1.5.5.Final', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (252, 3, 'org.mapstruct', 'mapstruct-processor', '1.4.2.Final', '1.5.5.Final', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (253, 3, 'org.mapstruct', 'mapstruct-processor', '1.4.2.Final', '1.5.5.Final', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (254, 10, 'org.mapstruct', 'mapstruct-processor', '1.5.3.Final', '1.5.5.Final', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (257, 10, 'org.projectlombok', 'lombok', '1.18.26', '1.18.28', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (258, 3, 'org.springframework.boot', 'spring-boot-starter-parent', '2.4.5', '3.1.2', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (259, 3, 'org.springframework.boot', 'spring-boot-starter-parent', '2.4.5', '3.1.2', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (260, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.9', '3.1.2', 1, '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (261, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', '2022.0.3', 1,
        '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (262, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', '2022.0.3', 1,
        '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (263, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2022.0.1', '2022.0.3', 1,
        '2023-07-22 09:39:39');
INSERT INTO `tb_notify_record`
VALUES (264, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (265, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.3', 1,
        '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (266, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (267, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (268, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (269, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (270, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (271, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.8.21', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (272, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.8.21', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (273, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (274, 3, 'cn.hutool', 'hutool-core', '5.6.3', '5.8.21', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (275, 3, 'cn.hutool', 'hutool-core', '5.6.3', '5.8.21', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (276, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (277, 3, 'cn.hutool', 'hutool-http', '5.6.3', '5.8.21', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (278, 3, 'cn.hutool', 'hutool-http', '5.6.3', '5.8.21', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (279, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (280, 3, 'com.baomidou', 'mybatis-plus-boot-starter', '3.4.2', '3.5.3.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (281, 3, 'com.baomidou', 'mybatis-plus-boot-starter', '3.4.2', '3.5.3.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (282, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (283, 3, 'com.baomidou', 'mybatis-plus-generator', '3.4.2', '3.5.3.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (284, 3, 'com.baomidou', 'mybatis-plus-generator', '3.4.2', '3.5.3.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (285, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (286, 3, 'com.github.chris2018998', 'beecp', '3.1.7', '3.4.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (287, 3, 'com.github.chris2018998', 'beecp', '3.1.7', '3.4.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (288, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (289, 3, 'com.google.guava', 'guava', '30.1.1-jre', '32.1.2-jre', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (290, 3, 'com.google.guava', 'guava', '30.1.1-jre', '32.1.2-jre', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (291, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (292, 3, 'org.apache.commons', 'commons-lang3', '3.11', '3.13.0', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (293, 3, 'org.apache.commons', 'commons-lang3', '3.11', '3.13.0', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (294, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (295, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', '2022.0.4', 1,
        '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (296, 3, 'org.springframework.cloud', 'spring-cloud-dependencies', '2020.0.2', '2022.0.4', 1,
        '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (297, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (298, 11, 'org.jsoup', 'jsoup', '1.15.4', '1.16.1', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (299, 11, 'com.aliyun.oss', 'aliyun-sdk-oss', '3.8.0', '3.17.1', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (300, 11, 'javax.xml.bind', 'jaxb-api', '2.3.1', '2.4.0-b180830.0359', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (301, 11, 'org.glassfish.jaxb', 'jaxb-runtime', '2.3.3', '4.0.3', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (302, 11, 'net.sourceforge.tess4j', 'tess4j', '5.6.0', '5.8.0', 1, '2023-08-13 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (303, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-20 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (304, 11, 'org.jsoup', 'jsoup', '1.15.4', '1.16.1', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (305, 11, 'com.aliyun.oss', 'aliyun-sdk-oss', '3.8.0', '3.17.1', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (306, 11, 'javax.xml.bind', 'jaxb-api', '2.3.1', '2.4.0-b180830.0359', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (307, 11, 'org.glassfish.jaxb', 'jaxb-runtime', '2.3.3', '4.0.3', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (308, 11, 'net.sourceforge.tess4j', 'tess4j', '5.6.0', '5.8.0', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (309, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.2', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (310, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (311, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (312, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (313, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (314, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (315, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (316, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (317, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (318, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (319, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (320, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (321, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (322, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (323, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (324, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.2', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (325, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (326, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (327, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (328, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (329, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (330, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (331, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (332, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (333, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (334, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (335, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (336, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (337, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (338, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 11:06:00');
INSERT INTO `tb_notify_record`
VALUES (339, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.2', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (340, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (341, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (342, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (343, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (344, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (345, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (346, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (347, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (348, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (349, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (350, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (351, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (352, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (353, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 11:08:55');
INSERT INTO `tb_notify_record`
VALUES (354, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.2', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (355, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (356, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (357, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (358, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (359, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (360, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (361, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (362, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (363, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (364, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (365, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (366, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (367, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (368, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 12:49:16');
INSERT INTO `tb_notify_record`
VALUES (369, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.2', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (370, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (371, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (372, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (373, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (374, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (375, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (376, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (377, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (378, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (379, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (380, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (381, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (382, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (383, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 12:50:00');
INSERT INTO `tb_notify_record`
VALUES (384, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.2', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (385, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (386, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (387, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (388, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (389, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (390, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (391, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (392, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (393, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (394, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (395, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (396, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (397, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (398, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 12:57:49');
INSERT INTO `tb_notify_record`
VALUES (399, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.2', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (400, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (401, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (402, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (403, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (404, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (405, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (406, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (407, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (408, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (409, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (410, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (411, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (412, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (413, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-20 17:11:28');
INSERT INTO `tb_notify_record`
VALUES (414, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.2', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (415, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (416, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (417, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (418, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (419, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (420, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (421, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (422, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (423, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (424, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (425, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (426, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (427, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (428, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-21 21:52:45');
INSERT INTO `tb_notify_record`
VALUES (429, 3, 'org.springframework.boot', 'spring-boot-starter-parent', '2.4.5', '3.1.3', 1, '2023-08-25 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (430, 3, 'org.springframework.boot', 'spring-boot-starter-parent', '2.4.5', '3.1.3', 1, '2023-08-25 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (431, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.3', 1, '2023-08-25 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (432, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.3', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (433, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (434, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (435, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (436, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (437, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (438, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (439, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (440, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (441, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (442, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (443, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (444, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (445, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (446, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-25 18:43:06');
INSERT INTO `tb_notify_record`
VALUES (447, 11, 'org.jsoup', 'jsoup', '1.15.4', '1.16.1', 1, '2023-08-26 09:00:01');
INSERT INTO `tb_notify_record`
VALUES (448, 11, 'com.aliyun.oss', 'aliyun-sdk-oss', '3.8.0', '3.17.1', 1, '2023-08-26 09:00:01');
INSERT INTO `tb_notify_record`
VALUES (449, 11, 'javax.xml.bind', 'jaxb-api', '2.3.1', '2.4.0-b180830.0359', 1, '2023-08-26 09:00:01');
INSERT INTO `tb_notify_record`
VALUES (450, 11, 'org.glassfish.jaxb', 'jaxb-runtime', '2.3.3', '4.0.3', 1, '2023-08-26 09:00:01');
INSERT INTO `tb_notify_record`
VALUES (451, 11, 'net.sourceforge.tess4j', 'tess4j', '5.6.0', '5.8.0', 1, '2023-08-26 09:00:01');
INSERT INTO `tb_notify_record`
VALUES (452, 11, 'org.jsoup', 'jsoup', '1.15.4', '1.16.1', 1, '2023-08-26 00:31:20');
INSERT INTO `tb_notify_record`
VALUES (453, 11, 'com.aliyun.oss', 'aliyun-sdk-oss', '3.8.0', '3.17.1', 1, '2023-08-26 00:31:20');
INSERT INTO `tb_notify_record`
VALUES (454, 11, 'javax.xml.bind', 'jaxb-api', '2.3.1', '2.4.0-b180830.0359', 1, '2023-08-26 00:31:20');
INSERT INTO `tb_notify_record`
VALUES (455, 11, 'org.glassfish.jaxb', 'jaxb-runtime', '2.3.3', '4.0.3', 1, '2023-08-26 00:31:20');
INSERT INTO `tb_notify_record`
VALUES (456, 11, 'net.sourceforge.tess4j', 'tess4j', '5.6.0', '5.8.0', 1, '2023-08-26 00:31:20');
INSERT INTO `tb_notify_record`
VALUES (457, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.3', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (458, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (459, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (460, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (461, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (462, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (463, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (464, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (465, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (466, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (467, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (468, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (469, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (470, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (471, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-26 00:42:06');
INSERT INTO `tb_notify_record`
VALUES (472, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.14', '3.1.3', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (473, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (474, 10, 'org.redisson', 'redisson', '3.20.0', '3.23.3', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (475, 10, 'io.swagger', 'swagger-annotations', '1.6.9', '1.6.11', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (476, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (477, 10, 'commons-io', 'commons-io', '2.11.0', '2.13.0', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (478, 10, 'org.apache.commons', 'commons-lang3', '3.12.0', '3.13.0', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (479, 10, 'cn.hutool', 'hutool-core', '5.8.20', '5.8.21', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (480, 10, 'cn.hutool', 'hutool-all', '5.8.20', '5.8.21', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (481, 10, 'cn.hutool', 'hutool-http', '5.8.20', '5.8.21', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (482, 10, 'com.google.guava', 'guava', '32.1.1-jre', '32.1.2-jre', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (483, 10, 'com.github.chris2018998', 'beecp', '3.4.1', '3.4.2', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (484, 10, 'com.h2database', 'h2', '2.1.220', '2.2.220', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (485, 10, 'com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.1', '3.5.3.2', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (486, 10, 'com.baomidou', 'mybatis-plus-generator', '3.5.3.1', '3.5.3.2', 1, '2023-08-26 09:07:34');
INSERT INTO `tb_notify_record`
VALUES (487, 3, 'org.apache.tika', 'tika-core', '1.24.1', '2.9.0', 1, '2023-08-29 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (488, 3, 'org.apache.tika', 'tika-core', '1.24.1', '2.9.0', 1, '2023-08-29 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (489, 10, 'org.apache.tika', 'tika-core', '2.8.0', '2.9.0', 1, '2023-08-29 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (490, 10, 'org.redisson', 'redisson', '3.23.3', '3.23.4', 1, '2023-08-30 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (491, 3, 'com.h2database', 'h2', '1.4.200', '2.2.222', 1, '2023-09-02 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (492, 3, 'com.h2database', 'h2', '1.4.200', '2.2.222', 1, '2023-09-02 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (493, 10, 'com.h2database', 'h2', '2.2.220', '2.2.222', 1, '2023-09-02 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (494, 11, 'org.jsoup', 'jsoup', '1.15.4', '1.16.1', 1, '2023-09-03 18:38:06');
INSERT INTO `tb_notify_record`
VALUES (495, 11, 'com.aliyun.oss', 'aliyun-sdk-oss', '3.8.0', '3.17.1', 1, '2023-09-03 18:38:06');
INSERT INTO `tb_notify_record`
VALUES (496, 11, 'javax.xml.bind', 'jaxb-api', '2.3.1', '2.4.0-b180830.0359', 1, '2023-09-03 18:38:06');
INSERT INTO `tb_notify_record`
VALUES (497, 11, 'org.glassfish.jaxb', 'jaxb-runtime', '2.3.3', '4.0.3', 1, '2023-09-03 18:38:06');
INSERT INTO `tb_notify_record`
VALUES (498, 11, 'net.sourceforge.tess4j', 'tess4j', '5.6.0', '5.8.0', 1, '2023-09-03 18:38:06');
INSERT INTO `tb_notify_record`
VALUES (499, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.3', 1, '2023-09-03 18:39:10');
INSERT INTO `tb_notify_record`
VALUES (500, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-03 18:39:10');
INSERT INTO `tb_notify_record`
VALUES (501, 10, 'org.redisson', 'redisson', '3.23.3', '3.23.4', 1, '2023-09-03 18:39:10');
INSERT INTO `tb_notify_record`
VALUES (502, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-09-03 18:39:10');
INSERT INTO `tb_notify_record`
VALUES (503, 10, 'org.apache.tika', 'tika-core', '2.8.0', '2.9.0', 1, '2023-09-03 18:39:10');
INSERT INTO `tb_notify_record`
VALUES (504, 10, 'com.h2database', 'h2', '2.2.220', '2.2.222', 1, '2023-09-03 18:39:10');
INSERT INTO `tb_notify_record`
VALUES (505, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.3', 1, '2023-09-03 18:44:35');
INSERT INTO `tb_notify_record`
VALUES (506, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-03 18:44:35');
INSERT INTO `tb_notify_record`
VALUES (507, 10, 'org.redisson', 'redisson', '3.23.3', '3.23.4', 1, '2023-09-03 18:44:35');
INSERT INTO `tb_notify_record`
VALUES (508, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-09-03 18:44:35');
INSERT INTO `tb_notify_record`
VALUES (509, 10, 'org.apache.tika', 'tika-core', '2.8.0', '2.9.0', 1, '2023-09-03 18:44:35');
INSERT INTO `tb_notify_record`
VALUES (510, 10, 'com.h2database', 'h2', '2.2.220', '2.2.222', 1, '2023-09-03 18:44:35');
INSERT INTO `tb_notify_record`
VALUES (511, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.3', 1, '2023-09-03 18:53:49');
INSERT INTO `tb_notify_record`
VALUES (512, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-03 18:53:49');
INSERT INTO `tb_notify_record`
VALUES (513, 10, 'org.redisson', 'redisson', '3.23.3', '3.23.4', 1, '2023-09-03 18:53:49');
INSERT INTO `tb_notify_record`
VALUES (514, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-09-03 18:53:49');
INSERT INTO `tb_notify_record`
VALUES (515, 10, 'org.apache.tika', 'tika-core', '2.8.0', '2.9.0', 1, '2023-09-03 18:53:49');
INSERT INTO `tb_notify_record`
VALUES (516, 10, 'com.h2database', 'h2', '2.2.220', '2.2.222', 1, '2023-09-03 18:53:49');
INSERT INTO `tb_notify_record`
VALUES (517, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.3', 1, '2023-09-03 20:07:01');
INSERT INTO `tb_notify_record`
VALUES (518, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-03 20:07:01');
INSERT INTO `tb_notify_record`
VALUES (519, 10, 'org.redisson', 'redisson', '3.23.3', '3.23.4', 1, '2023-09-03 20:07:01');
INSERT INTO `tb_notify_record`
VALUES (520, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-09-03 20:07:01');
INSERT INTO `tb_notify_record`
VALUES (521, 10, 'org.apache.tika', 'tika-core', '2.8.0', '2.9.0', 1, '2023-09-03 20:07:01');
INSERT INTO `tb_notify_record`
VALUES (522, 10, 'com.h2database', 'h2', '2.2.220', '2.2.222', 1, '2023-09-03 20:07:01');
INSERT INTO `tb_notify_record`
VALUES (523, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.3', 1, '2023-09-03 20:12:44');
INSERT INTO `tb_notify_record`
VALUES (524, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-03 20:12:44');
INSERT INTO `tb_notify_record`
VALUES (525, 10, 'org.redisson', 'redisson', '3.23.3', '3.23.4', 1, '2023-09-03 20:12:44');
INSERT INTO `tb_notify_record`
VALUES (526, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-09-03 20:12:44');
INSERT INTO `tb_notify_record`
VALUES (527, 10, 'org.apache.tika', 'tika-core', '2.8.0', '2.9.0', 1, '2023-09-03 20:12:44');
INSERT INTO `tb_notify_record`
VALUES (528, 10, 'com.h2database', 'h2', '2.2.220', '2.2.222', 1, '2023-09-03 20:12:44');
INSERT INTO `tb_notify_record`
VALUES (529, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.3', 1, '2023-09-03 22:03:23');
INSERT INTO `tb_notify_record`
VALUES (530, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-03 22:03:23');
INSERT INTO `tb_notify_record`
VALUES (531, 10, 'org.redisson', 'redisson', '3.23.3', '3.23.4', 1, '2023-09-03 22:03:23');
INSERT INTO `tb_notify_record`
VALUES (532, 10, 'commons-codec', 'commons-codec', '1.15', '1.16.0', 1, '2023-09-03 22:03:23');
INSERT INTO `tb_notify_record`
VALUES (533, 10, 'org.apache.tika', 'tika-core', '2.8.0', '2.9.0', 1, '2023-09-03 22:03:23');
INSERT INTO `tb_notify_record`
VALUES (534, 10, 'com.h2database', 'h2', '2.2.220', '2.2.222', 1, '2023-09-03 22:03:23');
INSERT INTO `tb_notify_record`
VALUES (537, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.8.22', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (538, 3, 'cn.hutool', 'hutool-all', '5.6.3', '5.8.22', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (539, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (540, 3, 'cn.hutool', 'hutool-core', '5.6.3', '5.8.22', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (541, 3, 'cn.hutool', 'hutool-core', '5.6.3', '5.8.22', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (542, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (543, 3, 'cn.hutool', 'hutool-http', '5.6.3', '5.8.22', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (544, 3, 'cn.hutool', 'hutool-http', '5.6.3', '5.8.22', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (545, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (546, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.32', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (547, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.32', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (548, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.32', 1, '2023-09-14 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (549, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.33', 1, '2023-09-15 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (550, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.33', 1, '2023-09-15 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (551, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.33', 1, '2023-09-15 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (552, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.34', 1, '2023-09-15 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (553, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.34', 1, '2023-09-15 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (554, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.34', 1, '2023-09-15 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (555, 3, 'com.h2database', 'h2', '1.4.200', '2.2.224', 1, '2023-09-19 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (556, 3, 'com.h2database', 'h2', '1.4.200', '2.2.224', 1, '2023-09-19 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (557, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-19 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (558, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.9', '2.2.16', 1, '2023-09-19 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (559, 3, 'io.swagger.core.v3', 'swagger-annotations', '2.1.9', '2.2.16', 1, '2023-09-19 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (560, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-19 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (561, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.35', 1, '2023-09-19 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (562, 3, 'com.nimbusds', 'nimbus-jose-jwt', '8.21', '9.35', 1, '2023-09-19 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (563, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-19 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (564, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.3', 1, '2023-09-19 15:19:22');
INSERT INTO `tb_notify_record`
VALUES (565, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-19 15:19:22');
INSERT INTO `tb_notify_record`
VALUES (566, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-19 15:19:22');
INSERT INTO `tb_notify_record`
VALUES (567, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-19 15:19:22');
INSERT INTO `tb_notify_record`
VALUES (568, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-19 15:19:22');
INSERT INTO `tb_notify_record`
VALUES (569, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-19 15:19:22');
INSERT INTO `tb_notify_record`
VALUES (570, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-19 15:19:22');
INSERT INTO `tb_notify_record`
VALUES (571, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-19 15:19:22');
INSERT INTO `tb_notify_record`
VALUES (572, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.3', 1, '2023-09-19 17:02:21');
INSERT INTO `tb_notify_record`
VALUES (573, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-19 17:02:21');
INSERT INTO `tb_notify_record`
VALUES (574, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-19 17:02:21');
INSERT INTO `tb_notify_record`
VALUES (575, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-19 17:02:21');
INSERT INTO `tb_notify_record`
VALUES (576, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-19 17:02:21');
INSERT INTO `tb_notify_record`
VALUES (577, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-19 17:02:21');
INSERT INTO `tb_notify_record`
VALUES (578, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-19 17:02:21');
INSERT INTO `tb_notify_record`
VALUES (579, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-19 17:02:21');
INSERT INTO `tb_notify_record`
VALUES (580, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.3', 1, '2023-09-19 18:21:18');
INSERT INTO `tb_notify_record`
VALUES (581, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-19 18:21:18');
INSERT INTO `tb_notify_record`
VALUES (582, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-19 18:21:18');
INSERT INTO `tb_notify_record`
VALUES (583, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-19 18:21:18');
INSERT INTO `tb_notify_record`
VALUES (584, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-19 18:21:18');
INSERT INTO `tb_notify_record`
VALUES (585, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-19 18:21:18');
INSERT INTO `tb_notify_record`
VALUES (586, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-19 18:21:18');
INSERT INTO `tb_notify_record`
VALUES (587, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-19 18:21:18');
INSERT INTO `tb_notify_record`
VALUES (588, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-20 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (589, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.3', 1, '2023-09-20 01:19:56');
INSERT INTO `tb_notify_record`
VALUES (590, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-20 01:19:56');
INSERT INTO `tb_notify_record`
VALUES (591, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-20 01:19:56');
INSERT INTO `tb_notify_record`
VALUES (592, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-20 01:19:56');
INSERT INTO `tb_notify_record`
VALUES (593, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-20 01:19:56');
INSERT INTO `tb_notify_record`
VALUES (594, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-20 01:19:56');
INSERT INTO `tb_notify_record`
VALUES (595, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-20 01:19:56');
INSERT INTO `tb_notify_record`
VALUES (596, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-20 01:19:56');
INSERT INTO `tb_notify_record`
VALUES (597, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-20 01:19:56');
INSERT INTO `tb_notify_record`
VALUES (600, 10, 'org.projectlombok', 'lombok', '1.18.28', '1.18.30', 1, '2023-09-21 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (601, 3, 'org.springframework.boot', 'spring-boot-starter-parent', '2.4.5', '3.1.4', 1, '2023-09-22 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (602, 3, 'org.springframework.boot', 'spring-boot-starter-parent', '2.4.5', '3.1.4', 1, '2023-09-22 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (603, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.4', 1, '2023-09-22 09:00:00');
INSERT INTO `tb_notify_record`
VALUES (604, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.4', 1, '2023-09-21 22:00:45');
INSERT INTO `tb_notify_record`
VALUES (605, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-21 22:00:45');
INSERT INTO `tb_notify_record`
VALUES (606, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-21 22:00:45');
INSERT INTO `tb_notify_record`
VALUES (607, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-21 22:00:45');
INSERT INTO `tb_notify_record`
VALUES (608, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-21 22:00:45');
INSERT INTO `tb_notify_record`
VALUES (609, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-21 22:00:45');
INSERT INTO `tb_notify_record`
VALUES (610, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-21 22:00:45');
INSERT INTO `tb_notify_record`
VALUES (611, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-21 22:00:45');
INSERT INTO `tb_notify_record`
VALUES (612, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-21 22:00:45');
INSERT INTO `tb_notify_record`
VALUES (613, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.4', 1, '2023-09-21 22:02:18');
INSERT INTO `tb_notify_record`
VALUES (614, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-21 22:02:18');
INSERT INTO `tb_notify_record`
VALUES (615, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-21 22:02:18');
INSERT INTO `tb_notify_record`
VALUES (616, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-21 22:02:18');
INSERT INTO `tb_notify_record`
VALUES (617, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-21 22:02:18');
INSERT INTO `tb_notify_record`
VALUES (618, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-21 22:02:18');
INSERT INTO `tb_notify_record`
VALUES (619, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-21 22:02:18');
INSERT INTO `tb_notify_record`
VALUES (620, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-21 22:02:18');
INSERT INTO `tb_notify_record`
VALUES (621, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-21 22:02:18');
INSERT INTO `tb_notify_record`
VALUES (622, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.4', 1, '2023-09-26 00:37:16');
INSERT INTO `tb_notify_record`
VALUES (623, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-26 00:37:16');
INSERT INTO `tb_notify_record`
VALUES (624, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-26 00:37:16');
INSERT INTO `tb_notify_record`
VALUES (625, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-26 00:37:16');
INSERT INTO `tb_notify_record`
VALUES (626, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-26 00:37:16');
INSERT INTO `tb_notify_record`
VALUES (627, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-26 00:37:16');
INSERT INTO `tb_notify_record`
VALUES (628, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-26 00:37:16');
INSERT INTO `tb_notify_record`
VALUES (629, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-26 00:37:16');
INSERT INTO `tb_notify_record`
VALUES (630, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-26 00:37:16');
INSERT INTO `tb_notify_record`
VALUES (631, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.4', 1, '2023-09-26 19:43:48');
INSERT INTO `tb_notify_record`
VALUES (632, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-26 19:43:48');
INSERT INTO `tb_notify_record`
VALUES (633, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-26 19:43:48');
INSERT INTO `tb_notify_record`
VALUES (634, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-26 19:43:48');
INSERT INTO `tb_notify_record`
VALUES (635, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-26 19:43:48');
INSERT INTO `tb_notify_record`
VALUES (636, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-26 19:43:48');
INSERT INTO `tb_notify_record`
VALUES (637, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-26 19:43:48');
INSERT INTO `tb_notify_record`
VALUES (638, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-26 19:43:48');
INSERT INTO `tb_notify_record`
VALUES (639, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-26 19:43:48');
INSERT INTO `tb_notify_record`
VALUES (640, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.4', 1, '2023-09-26 23:37:55');
INSERT INTO `tb_notify_record`
VALUES (641, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-26 23:37:55');
INSERT INTO `tb_notify_record`
VALUES (642, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-26 23:37:55');
INSERT INTO `tb_notify_record`
VALUES (643, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-26 23:37:55');
INSERT INTO `tb_notify_record`
VALUES (644, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-26 23:37:55');
INSERT INTO `tb_notify_record`
VALUES (645, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-26 23:37:55');
INSERT INTO `tb_notify_record`
VALUES (646, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-26 23:37:55');
INSERT INTO `tb_notify_record`
VALUES (647, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-26 23:37:55');
INSERT INTO `tb_notify_record`
VALUES (648, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-26 23:37:55');
INSERT INTO `tb_notify_record`
VALUES (649, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.4', 1, '2023-09-26 23:53:23');
INSERT INTO `tb_notify_record`
VALUES (650, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-26 23:53:23');
INSERT INTO `tb_notify_record`
VALUES (651, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-26 23:53:23');
INSERT INTO `tb_notify_record`
VALUES (652, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-26 23:53:23');
INSERT INTO `tb_notify_record`
VALUES (653, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-26 23:53:23');
INSERT INTO `tb_notify_record`
VALUES (654, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-26 23:53:23');
INSERT INTO `tb_notify_record`
VALUES (655, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-26 23:53:23');
INSERT INTO `tb_notify_record`
VALUES (656, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-26 23:53:23');
INSERT INTO `tb_notify_record`
VALUES (657, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-26 23:53:23');
INSERT INTO `tb_notify_record`
VALUES (658, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.4', 1, '2023-09-28 15:39:03');
INSERT INTO `tb_notify_record`
VALUES (659, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-28 15:39:03');
INSERT INTO `tb_notify_record`
VALUES (660, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-28 15:39:03');
INSERT INTO `tb_notify_record`
VALUES (661, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-28 15:39:03');
INSERT INTO `tb_notify_record`
VALUES (662, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-28 15:39:03');
INSERT INTO `tb_notify_record`
VALUES (663, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-28 15:39:03');
INSERT INTO `tb_notify_record`
VALUES (664, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-28 15:39:03');
INSERT INTO `tb_notify_record`
VALUES (665, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-28 15:39:03');
INSERT INTO `tb_notify_record`
VALUES (666, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-28 15:39:03');
INSERT INTO `tb_notify_record`
VALUES (667, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-28 23:03:53');
INSERT INTO `tb_notify_record`
VALUES (668, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-28 23:03:53');
INSERT INTO `tb_notify_record`
VALUES (669, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-28 23:03:53');
INSERT INTO `tb_notify_record`
VALUES (670, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-28 23:03:53');
INSERT INTO `tb_notify_record`
VALUES (671, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-28 23:03:53');
INSERT INTO `tb_notify_record`
VALUES (672, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-28 23:03:53');
INSERT INTO `tb_notify_record`
VALUES (673, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-28 23:03:53');
INSERT INTO `tb_notify_record`
VALUES (674, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-28 23:03:53');
INSERT INTO `tb_notify_record`
VALUES (675, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-28 23:03:53');
INSERT INTO `tb_notify_record`
VALUES (676, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-29 10:22:01');
INSERT INTO `tb_notify_record`
VALUES (677, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-29 10:22:01');
INSERT INTO `tb_notify_record`
VALUES (678, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-29 10:22:01');
INSERT INTO `tb_notify_record`
VALUES (679, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-29 10:22:01');
INSERT INTO `tb_notify_record`
VALUES (680, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-29 10:22:01');
INSERT INTO `tb_notify_record`
VALUES (681, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-29 10:22:01');
INSERT INTO `tb_notify_record`
VALUES (682, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-29 10:22:01');
INSERT INTO `tb_notify_record`
VALUES (683, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-29 10:22:01');
INSERT INTO `tb_notify_record`
VALUES (684, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-29 10:22:01');
INSERT INTO `tb_notify_record`
VALUES (685, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.4', 1, '2023-09-29 14:04:19');
INSERT INTO `tb_notify_record`
VALUES (686, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-29 14:04:19');
INSERT INTO `tb_notify_record`
VALUES (687, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-29 14:04:19');
INSERT INTO `tb_notify_record`
VALUES (688, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-29 14:04:19');
INSERT INTO `tb_notify_record`
VALUES (689, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-29 14:04:19');
INSERT INTO `tb_notify_record`
VALUES (690, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-29 14:04:19');
INSERT INTO `tb_notify_record`
VALUES (691, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-29 14:04:19');
INSERT INTO `tb_notify_record`
VALUES (692, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-29 14:04:19');
INSERT INTO `tb_notify_record`
VALUES (693, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-29 14:04:19');
INSERT INTO `tb_notify_record`
VALUES (694, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.15', '3.1.4', 1, '2023-09-29 16:06:43');
INSERT INTO `tb_notify_record`
VALUES (695, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-29 16:06:43');
INSERT INTO `tb_notify_record`
VALUES (696, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-29 16:06:43');
INSERT INTO `tb_notify_record`
VALUES (697, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-29 16:06:43');
INSERT INTO `tb_notify_record`
VALUES (698, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-29 16:06:43');
INSERT INTO `tb_notify_record`
VALUES (699, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-29 16:06:43');
INSERT INTO `tb_notify_record`
VALUES (700, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-29 16:06:43');
INSERT INTO `tb_notify_record`
VALUES (701, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-29 16:06:43');
INSERT INTO `tb_notify_record`
VALUES (702, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-29 16:06:43');
INSERT INTO `tb_notify_record`
VALUES (703, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-30 00:35:20');
INSERT INTO `tb_notify_record`
VALUES (704, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-30 00:35:20');
INSERT INTO `tb_notify_record`
VALUES (705, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-30 00:35:20');
INSERT INTO `tb_notify_record`
VALUES (706, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-30 00:35:20');
INSERT INTO `tb_notify_record`
VALUES (707, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-30 00:35:20');
INSERT INTO `tb_notify_record`
VALUES (708, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-30 00:35:20');
INSERT INTO `tb_notify_record`
VALUES (709, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-30 00:35:20');
INSERT INTO `tb_notify_record`
VALUES (710, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-30 00:35:20');
INSERT INTO `tb_notify_record`
VALUES (711, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-30 00:35:20');
INSERT INTO `tb_notify_record`
VALUES (712, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-30 00:54:27');
INSERT INTO `tb_notify_record`
VALUES (713, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-30 00:54:27');
INSERT INTO `tb_notify_record`
VALUES (714, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-30 00:54:27');
INSERT INTO `tb_notify_record`
VALUES (715, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-30 00:54:27');
INSERT INTO `tb_notify_record`
VALUES (716, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-30 00:54:27');
INSERT INTO `tb_notify_record`
VALUES (717, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-30 00:54:27');
INSERT INTO `tb_notify_record`
VALUES (718, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-30 00:54:27');
INSERT INTO `tb_notify_record`
VALUES (719, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-30 00:54:27');
INSERT INTO `tb_notify_record`
VALUES (720, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-30 00:54:27');
INSERT INTO `tb_notify_record`
VALUES (721, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-30 00:59:31');
INSERT INTO `tb_notify_record`
VALUES (722, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-30 00:59:31');
INSERT INTO `tb_notify_record`
VALUES (723, 10, 'org.redisson', 'redisson', '3.23.4', '3.23.5', 1, '2023-09-30 00:59:31');
INSERT INTO `tb_notify_record`
VALUES (724, 10, 'io.swagger.core.v3', 'swagger-annotations', '2.2.15', '2.2.16', 1, '2023-09-30 00:59:31');
INSERT INTO `tb_notify_record`
VALUES (725, 10, 'com.nimbusds', 'nimbus-jose-jwt', '9.31', '9.35', 1, '2023-09-30 00:59:31');
INSERT INTO `tb_notify_record`
VALUES (726, 10, 'cn.hutool', 'hutool-core', '5.8.21', '5.8.22', 1, '2023-09-30 00:59:31');
INSERT INTO `tb_notify_record`
VALUES (727, 10, 'cn.hutool', 'hutool-all', '5.8.21', '5.8.22', 1, '2023-09-30 00:59:31');
INSERT INTO `tb_notify_record`
VALUES (728, 10, 'cn.hutool', 'hutool-http', '5.8.21', '5.8.22', 1, '2023-09-30 00:59:31');
INSERT INTO `tb_notify_record`
VALUES (729, 10, 'com.h2database', 'h2', '2.2.222', '2.2.224', 1, '2023-09-30 00:59:31');
INSERT INTO `tb_notify_record`
VALUES (730, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-30 01:15:35');
INSERT INTO `tb_notify_record`
VALUES (731, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-30 01:15:35');
INSERT INTO `tb_notify_record`
VALUES (732, 12, 'org.codehaus.mojo', 'license-maven-plugin', '2.0.0', '2.2.0', 1, '2023-09-30 01:25:14');
INSERT INTO `tb_notify_record`
VALUES (733, 12, 'org.apache.maven.plugins', 'maven-source-plugin', '3.2.1', '3.3.0', 1, '2023-09-30 01:25:14');
INSERT INTO `tb_notify_record`
VALUES (734, 12, 'org.apache.maven.plugins', 'maven-javadoc-plugin', '3.2.0', '3.6.0', 1, '2023-09-30 01:25:14');
INSERT INTO `tb_notify_record`
VALUES (735, 12, 'org.apache.maven.plugins', 'maven-surefire-plugin', '3.0.0', '3.1.2', 1, '2023-09-30 01:25:14');
INSERT INTO `tb_notify_record`
VALUES (736, 12, 'org.codehaus.mojo', 'sonar-maven-plugin', '3.7.0.1746', '3.10.0.2594', 1, '2023-09-30 01:25:14');
INSERT INTO `tb_notify_record`
VALUES (737, 12, 'org.codehaus.mojo', 'versions-maven-plugin', '2.7', '2.16.1', 1, '2023-09-30 01:25:14');
INSERT INTO `tb_notify_record`
VALUES (738, 12, 'pl.project13.maven', 'git-commit-id-plugin', '2.1.5', '4.9.10', 1, '2023-09-30 01:25:14');
INSERT INTO `tb_notify_record`
VALUES (739, 13, 'org.apache.maven.plugins', 'maven-gpg-plugin', '3.0.1', '3.1.0', 1, '2023-09-30 01:37:32');
INSERT INTO `tb_notify_record`
VALUES (740, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-30 01:56:02');
INSERT INTO `tb_notify_record`
VALUES (741, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-30 01:56:02');
INSERT INTO `tb_notify_record`
VALUES (742, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-30 02:21:15');
INSERT INTO `tb_notify_record`
VALUES (743, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-30 02:21:15');
INSERT INTO `tb_notify_record`
VALUES (744, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-30 11:57:24');
INSERT INTO `tb_notify_record`
VALUES (745, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-30 11:57:24');
INSERT INTO `tb_notify_record`
VALUES (746, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-09-30 11:57:24');
INSERT INTO `tb_notify_record`
VALUES (747, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-30 12:20:19');
INSERT INTO `tb_notify_record`
VALUES (748, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-30 12:20:19');
INSERT INTO `tb_notify_record`
VALUES (749, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-09-30 12:20:19');
INSERT INTO `tb_notify_record`
VALUES (750, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-09-30 21:37:10');
INSERT INTO `tb_notify_record`
VALUES (751, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-09-30 21:37:10');
INSERT INTO `tb_notify_record`
VALUES (752, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-09-30 21:37:10');
INSERT INTO `tb_notify_record`
VALUES (753, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-01 19:09:57');
INSERT INTO `tb_notify_record`
VALUES (754, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-01 19:09:57');
INSERT INTO `tb_notify_record`
VALUES (755, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-01 19:09:57');
INSERT INTO `tb_notify_record`
VALUES (756, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-01 20:52:29');
INSERT INTO `tb_notify_record`
VALUES (757, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-01 20:52:29');
INSERT INTO `tb_notify_record`
VALUES (758, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-01 20:52:29');
INSERT INTO `tb_notify_record`
VALUES (759, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-01 20:56:33');
INSERT INTO `tb_notify_record`
VALUES (760, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-01 20:56:33');
INSERT INTO `tb_notify_record`
VALUES (761, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-01 20:56:33');
INSERT INTO `tb_notify_record`
VALUES (762, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-01 21:00:07');
INSERT INTO `tb_notify_record`
VALUES (763, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-01 21:00:07');
INSERT INTO `tb_notify_record`
VALUES (764, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-01 21:00:07');
INSERT INTO `tb_notify_record`
VALUES (765, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-01 22:07:56');
INSERT INTO `tb_notify_record`
VALUES (766, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-01 22:07:56');
INSERT INTO `tb_notify_record`
VALUES (767, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-01 22:07:56');
INSERT INTO `tb_notify_record`
VALUES (768, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-02 00:23:42');
INSERT INTO `tb_notify_record`
VALUES (769, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-02 00:23:42');
INSERT INTO `tb_notify_record`
VALUES (770, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-02 00:23:42');
INSERT INTO `tb_notify_record`
VALUES (771, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-02 02:51:53');
INSERT INTO `tb_notify_record`
VALUES (772, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-02 02:51:53');
INSERT INTO `tb_notify_record`
VALUES (773, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-02 02:51:53');
INSERT INTO `tb_notify_record`
VALUES (774, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-02 16:27:09');
INSERT INTO `tb_notify_record`
VALUES (775, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-02 16:27:09');
INSERT INTO `tb_notify_record`
VALUES (776, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-02 16:27:09');
INSERT INTO `tb_notify_record`
VALUES (777, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-02 17:37:45');
INSERT INTO `tb_notify_record`
VALUES (778, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-02 17:37:45');
INSERT INTO `tb_notify_record`
VALUES (779, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-02 17:37:45');
INSERT INTO `tb_notify_record`
VALUES (780, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-02 18:12:42');
INSERT INTO `tb_notify_record`
VALUES (781, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-02 18:12:42');
INSERT INTO `tb_notify_record`
VALUES (782, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-02 18:12:42');
INSERT INTO `tb_notify_record`
VALUES (783, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-02 21:30:30');
INSERT INTO `tb_notify_record`
VALUES (784, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-02 21:30:30');
INSERT INTO `tb_notify_record`
VALUES (785, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-02 21:30:30');
INSERT INTO `tb_notify_record`
VALUES (786, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-02 22:16:30');
INSERT INTO `tb_notify_record`
VALUES (787, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-02 22:16:30');
INSERT INTO `tb_notify_record`
VALUES (788, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-02 22:16:30');
INSERT INTO `tb_notify_record`
VALUES (789, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-02 22:21:02');
INSERT INTO `tb_notify_record`
VALUES (790, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-02 22:21:02');
INSERT INTO `tb_notify_record`
VALUES (791, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-02 22:21:02');
INSERT INTO `tb_notify_record`
VALUES (792, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-03 00:07:22');
INSERT INTO `tb_notify_record`
VALUES (793, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-03 00:07:22');
INSERT INTO `tb_notify_record`
VALUES (794, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-03 00:07:22');
INSERT INTO `tb_notify_record`
VALUES (795, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-03 00:32:17');
INSERT INTO `tb_notify_record`
VALUES (796, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-03 00:32:17');
INSERT INTO `tb_notify_record`
VALUES (797, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-03 00:32:17');
INSERT INTO `tb_notify_record`
VALUES (798, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-03 10:25:54');
INSERT INTO `tb_notify_record`
VALUES (799, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-03 10:25:54');
INSERT INTO `tb_notify_record`
VALUES (800, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-03 10:25:54');
INSERT INTO `tb_notify_record`
VALUES (801, 10, 'org.springframework.boot', 'spring-boot-starter-parent', '2.7.16', '3.1.4', 1, '2023-10-03 10:39:16');
INSERT INTO `tb_notify_record`
VALUES (802, 10, 'org.springframework.cloud', 'spring-cloud-dependencies', '2021.0.8', '2022.0.4', 1,
        '2023-10-03 10:39:16');
INSERT INTO `tb_notify_record`
VALUES (803, 10, 'commons-io', 'commons-io', '2.13.0', '2.14.0', 1, '2023-10-03 10:39:16');
/*!40000 ALTER TABLE `tb_notify_record` ENABLE KEYS */;
UNLOCK
TABLES;

--
-- Dumping data for table `tb_project`
--

LOCK
TABLES `tb_project` WRITE;
/*!40000 ALTER TABLE `tb_project` DISABLE KEYS */;
INSERT INTO `tb_project`
VALUES (3, 'cn.itlym', 'shoulder-dependencies', NULL, 'shoulder-dependencies', NULL, '1', 'NORMAL',
        '2020-08-01 01:06:18', '2021-05-27 00:27:48');
INSERT INTO `tb_project`
VALUES (10, 'cn.itlym', 'shoulder-dependencies', NULL, 'shoulder-dependencies', NULL, '1', 'NORMAL',
        '2023-03-19 09:21:53', '2023-10-03 10:39:16');
INSERT INTO `tb_project`
VALUES (11, 'com.example', 'spider', '0.0.1-SNAPSHOT', 'spider', 'Demo project for Spring Boot', '1', 'NORMAL',
        '2023-08-13 00:11:53', '2023-09-03 18:38:05');
INSERT INTO `tb_project`
VALUES (12, 'cn.itlym', 'shoulder-parent', NULL, 'shoulder-parent', NULL, '1', 'NORMAL', '2023-09-30 01:16:02',
        '2023-09-30 01:25:09');
INSERT INTO `tb_project`
VALUES (13, 'cn.itlym', 'shoulder-framework', '0.7-SNAPSHOT', 'shoulder Build',
        'Modules to centralize common resources and configuration for shoulder Maven builds.', '1', 'NORMAL',
        '2023-09-30 01:37:30', NULL);
INSERT INTO `tb_project`
VALUES (23, 'cn.itlym', 'shoulder-archetype-simple', NULL, 'shoulder-archetype-simple',
        'simple maven-archetype for Shoulder Framework', '1', 'NORMAL', '2023-09-30 02:16:02', NULL);
/*!40000 ALTER TABLE `tb_project` ENABLE KEYS */;
UNLOCK
TABLES;

--
-- Dumping data for table `tb_third_project`
--

LOCK
TABLES `tb_third_project` WRITE;
/*!40000 ALTER TABLE `tb_third_project` DISABLE KEYS */;
INSERT INTO `tb_third_project`
VALUES ('cn.hutool', 'hutool-all', '5.8.22', '5.8.22', NULL, NULL, 'https://gitee.com/dromara/hutool',
        'https://gitee.com/dromara/hutool/blob/v5-master/CHANGELOG.md', NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:00');
INSERT INTO `tb_third_project`
VALUES ('cn.hutool', 'hutool-core', '5.8.22', '5.8.22', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:01');
INSERT INTO `tb_third_project`
VALUES ('cn.hutool', 'hutool-http', '5.8.22', '5.8.22', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:02');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-api-doc', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:02');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-autoconfiguration', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:02');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-batch', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:02');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-cluster', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:02');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-core', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:02');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-crypto', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:02');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-crypto-negotiation', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:02');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-data-db', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:03');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-dependencies', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:03');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-ext-autoconfiguration', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:03');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-ext-common', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:03');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-ext-config', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:03');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-ext-dictionary', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:03');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-framework', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:03');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-http', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:03');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-monitor', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:03');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-operation-log', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:03');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-security', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:04');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-security-code', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:04');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:04');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter-auth-server', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:04');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter-auth-session', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:04');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter-auth-token', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:04');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter-beanmap', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:04');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter-crypto', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:04');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter-monitor', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:05');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter-mysql', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:05');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter-operation-log', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:05');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter-security-code', '0.6', '0.6', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:05');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-starter-web', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:05');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-validation', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:05');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym', 'shoulder-web', '0.7.1', '0.7.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:05');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym.shoulder', 'lombok', '0.1', '0.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:05');
INSERT INTO `tb_third_project`
VALUES ('cn.itlym.shoulder', 'shoulder-maven-plugin', '1.1', '1.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:05');
INSERT INTO `tb_third_project`
VALUES ('com.alibaba', 'druid-spring-boot-starter', '1.2.19', '1.2.19', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:06');
INSERT INTO `tb_third_project`
VALUES ('com.alibaba', 'transmittable-thread-local', '2.14.3', '2.14.3', NULL, NULL,
        'https://github.com/alibaba/transmittable-thread-local',
        'https://github.com/alibaba/transmittable-thread-local/releases', NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:06');
INSERT INTO `tb_third_project`
VALUES ('com.aliyun.oss', 'aliyun-sdk-oss', '3.17.1', '3.17.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:06');
INSERT INTO `tb_third_project`
VALUES ('com.baomidou', 'mybatis-plus-boot-starter', '3.5.3.2', '3.5.3.2', NULL, NULL,
        'https://github.com/baomidou/mybatis-plus', 'https://github.com/baomidou/mybatis-plus/blob/3.0/CHANGELOG.md',
        NULL, '.*', 'x.y.z', 'NORMAL', '2023-10-03 16:00:06');
INSERT INTO `tb_third_project`
VALUES ('com.baomidou', 'mybatis-plus-generator', '3.5.3.2', '3.5.3.2', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:06');
INSERT INTO `tb_third_project`
VALUES ('com.belerweb', 'pinyin4j', '2.5.1', '2.5.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:07');
INSERT INTO `tb_third_project`
VALUES ('com.github.chris2018998', 'beecp', '3.4.2', '3.4.2', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:07');
INSERT INTO `tb_third_project`
VALUES ('com.github.pagehelper', 'pagehelper', '5.3.3', '5.3.3', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:07');
INSERT INTO `tb_third_project`
VALUES ('com.github.pagehelper', 'pagehelper-spring-boot-starter', '1.4.7', '1.4.7', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:07');
INSERT INTO `tb_third_project`
VALUES ('com.github.xiaoymin', 'knife4j-spring-boot-starter', '3.0.3', '3.0.3', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:07');
INSERT INTO `tb_third_project`
VALUES ('com.github.xiaoymin', 'knife4j-spring-ui', '3.0.3', '3.0.3', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:07');
INSERT INTO `tb_third_project`
VALUES ('com.google.code.findbugs', 'annotations', '3.0.1', '3.0.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:07');
INSERT INTO `tb_third_project`
VALUES ('com.google.guava', 'guava', '32.1.2-jre', '32.1.2-jre', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:07');
INSERT INTO `tb_third_project`
VALUES ('com.h2database', 'h2', '2.2.224', '2.2.224', NULL, NULL, 'https://github.com/h2database/h2database',
        'https://github.com/h2database/h2database/releases', NULL, '.*', 'x.y.z', 'NORMAL', '2023-10-03 16:00:08');
INSERT INTO `tb_third_project`
VALUES ('com.nimbusds', 'nimbus-jose-jwt', '9.35', '9.35', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:08');
INSERT INTO `tb_third_project`
VALUES ('com.thoughtworks.xstream', 'xstream', '1.4.20', '1.4.20', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:09');
INSERT INTO `tb_third_project`
VALUES ('com.univocity', 'univocity-parsers', '2.9.1', '2.9.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:09');
INSERT INTO `tb_third_project`
VALUES ('commons-codec', 'commons-codec', '20041127.091804', '1.16.0', NULL, NULL,
        'https://github.com/apache/commons-codec', 'https://github.com/apache/commons-codec/tags', NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:09');
INSERT INTO `tb_third_project`
VALUES ('commons-configuration', 'commons-configuration', '20041012.002804', '1.10', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:09');
INSERT INTO `tb_third_project`
VALUES ('commons-daemon', 'commons-daemon', '1.3.4', '1.3.4', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:09');
INSERT INTO `tb_third_project`
VALUES ('commons-io', 'commons-io', '20030203.000550', '2.14.0', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:10');
INSERT INTO `tb_third_project`
VALUES ('io.springfox', 'springfox-boot-starter', '3.0.0', '3.0.0', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:10');
INSERT INTO `tb_third_project`
VALUES ('io.springfox', 'springfox-core', '3.0.0', '3.0.0', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:10');
INSERT INTO `tb_third_project`
VALUES ('io.swagger', 'swagger-annotations', '2.0.0-rc2', '1.6.11', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:10');
INSERT INTO `tb_third_project`
VALUES ('io.swagger.core.v3', 'swagger-annotations', '2.2.16', '2.2.16', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:10');
INSERT INTO `tb_third_project`
VALUES ('javax.activation', 'activation', '1.1.1', '1.1.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:10');
INSERT INTO `tb_third_project`
VALUES ('javax.ws.rs', 'javax.ws.rs-api', '2.1.1', '2.1.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:10');
INSERT INTO `tb_third_project`
VALUES ('javax.xml.bind', 'jaxb-api', '2.4.0-b180830.0359', '2.4.0-b180830.0359', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:10');
INSERT INTO `tb_third_project`
VALUES ('net.java.dev.jna', 'jna', '5.13.0', '5.13.0', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:11');
INSERT INTO `tb_third_project`
VALUES ('net.sourceforge.tess4j', 'tess4j', '5.8.0', '5.8.0', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:11');
INSERT INTO `tb_third_project`
VALUES ('org.apache.commons', 'commons-collections4', '4.4', '4.4', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:11');
INSERT INTO `tb_third_project`
VALUES ('org.apache.commons', 'commons-lang3', '3.13.0', '3.13.0', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:11');
INSERT INTO `tb_third_project`
VALUES ('org.apache.maven.plugins', 'maven-archetype-plugin', '3.2.1', '3.2.1', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:11');
INSERT INTO `tb_third_project`
VALUES ('org.apache.maven.plugins', 'maven-compiler-plugin', '3.11.0', '3.11.0', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:11');
INSERT INTO `tb_third_project`
VALUES ('org.apache.maven.plugins', 'maven-gpg-plugin', '3.1.0', '3.1.0', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:11');
INSERT INTO `tb_third_project`
VALUES ('org.apache.maven.plugins', 'maven-jar-plugin', '3.3.0', '3.3.0', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:11');
INSERT INTO `tb_third_project`
VALUES ('org.apache.maven.plugins', 'maven-javadoc-plugin', '3.6.0', '3.6.0', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:12');
INSERT INTO `tb_third_project`
VALUES ('org.apache.maven.plugins', 'maven-resources-plugin', '3.3.1', '3.3.1', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:12');
INSERT INTO `tb_third_project`
VALUES ('org.apache.maven.plugins', 'maven-source-plugin', '3.3.0', '3.3.0', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:12');
INSERT INTO `tb_third_project`
VALUES ('org.apache.maven.plugins', 'maven-surefire-plugin', '3.1.2', '3.1.2', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:12');
INSERT INTO `tb_third_project`
VALUES ('org.apache.tika', 'tika-core', '2.9.0', '2.9.0', NULL, NULL, 'https://github.com/apache/tika',
        'https://github.com/apache/tika/blob/main/CHANGES.txt', NULL, '.*', 'x.y.z', 'NORMAL', '2023-10-03 16:00:13');
INSERT INTO `tb_third_project`
VALUES ('org.bouncycastle', 'bcpkix-jdk15on', '1.70', '1.70', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:13');
INSERT INTO `tb_third_project`
VALUES ('org.bouncycastle', 'bcprov-jdk15on', '1.70', '1.70', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:13');
INSERT INTO `tb_third_project`
VALUES ('org.codehaus.mojo', 'cobertura-maven-plugin', '2.7', '2.7', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:13');
INSERT INTO `tb_third_project`
VALUES ('org.codehaus.mojo', 'findbugs-maven-plugin', '3.0.5', '3.0.5', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:13');
INSERT INTO `tb_third_project`
VALUES ('org.codehaus.mojo', 'license-maven-plugin', '2.2.0', '2.2.0', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:13');
INSERT INTO `tb_third_project`
VALUES ('org.codehaus.mojo', 'sonar-maven-plugin', '3.10.0.2594', '3.10.0.2594', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:13');
INSERT INTO `tb_third_project`
VALUES ('org.codehaus.mojo', 'versions-maven-plugin', '2.16.1', '2.16.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:13');
INSERT INTO `tb_third_project`
VALUES ('org.glassfish.jaxb', 'jaxb-runtime', '4.0.3', '4.0.3', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:14');
INSERT INTO `tb_third_project`
VALUES ('org.javassist', 'javassist', '3.29.2-GA', '3.29.2-GA', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:14');
INSERT INTO `tb_third_project`
VALUES ('org.jsoup', 'jsoup', '1.16.1', '1.16.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:14');
INSERT INTO `tb_third_project`
VALUES ('org.lz4', 'lz4-java', '1.8.0', '1.8.0', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:14');
INSERT INTO `tb_third_project`
VALUES ('org.mapstruct', 'mapstruct', '1.5.5.Final', '1.5.5.Final', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:15');
INSERT INTO `tb_third_project`
VALUES ('org.mapstruct', 'mapstruct-processor', '1.5.5.Final', '1.5.5.Final', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:15');
INSERT INTO `tb_third_project`
VALUES ('org.mockito', 'mockito-all', '2.0.2-beta', '1.10.19', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:15');
INSERT INTO `tb_third_project`
VALUES ('org.powermock', 'powermock-api-mockito', '1.7.4', '1.7.4', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:15');
INSERT INTO `tb_third_project`
VALUES ('org.powermock', 'powermock-api-mockito2', '2.0.9', '2.0.9', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:16');
INSERT INTO `tb_third_project`
VALUES ('org.powermock', 'powermock-module-junit4', '2.0.9', '2.0.9', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:16');
INSERT INTO `tb_third_project`
VALUES ('org.projectlombok', 'lombok', '1.18.30', '1.18.30', NULL, NULL, 'https://github.com/projectlombok/lombok',
        'https://github.com/projectlombok/lombok/releases', NULL, '.*', 'x.y.z', 'NORMAL', '2023-10-03 16:00:16');
INSERT INTO `tb_third_project`
VALUES ('org.redisson', 'redisson', '3.23.5', '3.23.5', NULL, NULL, 'https://github.com/redisson/redisson',
        'https://github.com/redisson/redisson/blob/master/CHANGELOG.md', NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:16');
INSERT INTO `tb_third_project`
VALUES ('org.sonatype.plugins', 'nexus-staging-maven-plugin', '1.6.13', '1.6.13', NULL, NULL, NULL, NULL, NULL, '.*',
        'x.y.z', 'NORMAL', '2023-10-03 16:00:17');
INSERT INTO `tb_third_project`
VALUES ('org.springframework.boot', 'spring-boot-starter-parent', '3.1.4', '3.1.4', NULL, NULL,
        'https://github.com/spring-projects/spring-boot', 'https://github.com/spring-projects/spring-boot/releases',
        NULL, '.*', 'x.y.z', 'NORMAL', '2023-10-03 16:00:17');
INSERT INTO `tb_third_project`
VALUES ('org.springframework.cloud', 'spring-cloud-dependencies', '2022.0.4', '2022.0.4', NULL, NULL,
        'https://spring.io/projects/spring-cloud#overview',
        'https://docs.spring.io/spring-cloud/docs/current/reference/html', NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:17');
INSERT INTO `tb_third_project`
VALUES ('org.springframework.security.experimental', 'spring-security-oauth2-authorization-server', '0.1.2', '0.1.2',
        NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL', '2023-10-03 16:00:17');
INSERT INTO `tb_third_project`
VALUES ('org.springframework.security.oauth', 'spring-security-oauth2', '2.5.2.RELEASE', '2.5.2.RELEASE', NULL, NULL,
        NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL', '2023-10-03 16:00:17');
INSERT INTO `tb_third_project`
VALUES ('org.springframework.security.oauth.boot', 'spring-security-oauth2-autoconfigure', '2.6.8', '2.6.8', NULL, NULL,
        NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL', '2023-10-03 16:00:18');
INSERT INTO `tb_third_project`
VALUES ('p6spy', 'p6spy', '3.9.1', '3.9.1', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z', 'NORMAL',
        '2023-10-03 16:00:18');
INSERT INTO `tb_third_project`
VALUES ('pl.project13.maven', 'git-commit-id-plugin', '4.9.10', '4.9.10', NULL, NULL, NULL, NULL, NULL, '.*', 'x.y.z',
        'NORMAL', '2023-10-03 16:00:18');
/*!40000 ALTER TABLE `tb_third_project` ENABLE KEYS */;
UNLOCK
TABLES;
