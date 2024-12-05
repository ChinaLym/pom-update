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
    `notified`        tinyint DEFAULT NULL,
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