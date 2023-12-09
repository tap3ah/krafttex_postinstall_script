-- MariaDB dump 10.19  Distrib 10.5.22-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: raus
-- ------------------------------------------------------
-- Server version	10.5.22-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Tbl_Centrals`
--

DROP TABLE IF EXISTS `Tbl_Centrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tbl_Centrals` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cen_name` text NOT NULL,
  `cen_address` text NOT NULL,
  `cen_longitude` double DEFAULT NULL,
  `cen_latitude` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Tbl_Generators_1`
--

DROP TABLE IF EXISTS `Tbl_Generators_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tbl_Generators_1` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `central_id` bigint(20) NOT NULL,
  `fn_prefix` text NOT NULL,
  `freq_nominal` double DEFAULT NULL,
  `pelec_nominal` double DEFAULT NULL,
  `db_min` double DEFAULT NULL,
  `db_max` double DEFAULT NULL,
  `droop_min` double DEFAULT NULL,
  `droop_max` double DEFAULT NULL,
  `rise_time_min` double DEFAULT NULL,
  `rise_time_max` double DEFAULT NULL,
  `p_set_min` double DEFAULT NULL,
  `p_set_max` double DEFAULT NULL,
  `psetp_min_difference_pu` double DEFAULT NULL,
  `pearson_max` double DEFAULT NULL,
  `rau_master_id` bigint(20) DEFAULT NULL,
  `rau_slave_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Tbl_Generators_1_ibfk_1` (`central_id`),
  KEY `rau_master_id` (`rau_master_id`),
  KEY `rau_slave_id` (`rau_slave_id`),
  CONSTRAINT `Tbl_Generators_1_ibfk_1` FOREIGN KEY (`central_id`) REFERENCES `Tbl_Centrals` (`id`),
  CONSTRAINT `Tbl_Generators_1_ibfk_2` FOREIGN KEY (`rau_master_id`) REFERENCES `Tbl_RAU` (`id`),
  CONSTRAINT `Tbl_Generators_1_ibfk_3` FOREIGN KEY (`rau_slave_id`) REFERENCES `Tbl_RAU` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Tbl_ProcessedData`
--

DROP TABLE IF EXISTS `Tbl_ProcessedData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tbl_ProcessedData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ts` datetime NOT NULL,
  `f` double DEFAULT NULL,
  `p` double DEFAULT NULL,
  `q` double DEFAULT NULL,
  `p_set` double DEFAULT NULL,
  `gen_id` int(11) NOT NULL,
  `id_m` bigint(20) DEFAULT NULL,
  `id_s` bigint(20) DEFAULT NULL,
  `rau_id_m` int(11) DEFAULT NULL,
  `rau_id_s` int(11) DEFAULT NULL,
  `processed` smallint(6) NOT NULL DEFAULT 0,
  `fn_prefix` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12759 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tbl_ProcessedData`
--

LOCK TABLES `Tbl_ProcessedData` WRITE;
/*!40000 ALTER TABLE `Tbl_ProcessedData` DISABLE KEYS */;
/*!40000 ALTER TABLE `Tbl_ProcessedData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tbl_RAU`
--

DROP TABLE IF EXISTS `Tbl_RAU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tbl_RAU` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rau_type_id` bigint(20) NOT NULL,
  `gen_id` bigint(20) DEFAULT NULL,
  `is_master` tinyint(1) NOT NULL DEFAULT 0,
  `running` tinyint(1) NOT NULL DEFAULT 0,
  `scale_factor_u` double DEFAULT NULL,
  `scale_factor_i` double DEFAULT NULL,
  `p_set_scale` double DEFAULT NULL,
  `p_set_offset` double DEFAULT NULL,
  `rau_conf` text DEFAULT NULL,
  `started` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Tbl_RAU_ibfk_1` (`gen_id`),
  KEY `Tbl_RAU_ibfk_2` (`rau_type_id`),
  CONSTRAINT `Tbl_RAU_ibfk_1` FOREIGN KEY (`gen_id`) REFERENCES `Tbl_Generators_1` (`id`),
  CONSTRAINT `Tbl_RAU_ibfk_2` FOREIGN KEY (`rau_type_id`) REFERENCES `Tbl_Rau_Type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Tbl_Rau_Type`
--

DROP TABLE IF EXISTS `Tbl_Rau_Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tbl_Rau_Type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_name` text NOT NULL,
  `type_description` text NOT NULL,
  `conf_file` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tbl_Rau_Type`
--

LOCK TABLES `Tbl_Rau_Type` WRITE;
/*!40000 ALTER TABLE `Tbl_Rau_Type` DISABLE KEYS */;
INSERT INTO `Tbl_Rau_Type`(`type_name`, `type_description`, `conf_file`) VALUES ('RAU_3000','RAU3000','{\"ip_mau\": \"^((\\\\d|[1-9]\\\\d|1\\\\d{2}|2[0-4]\\\\d|25[0-5])\\\\.){3}(\\\\d|[1-9]\\\\d|1\\\\d{2}|2[0-4]\\\\d|25[0-5])$\",\"port_mau\": \"^[1-9]\\\\d*$\",\"ip_rau\": \"^((\\\\d|[1-9]\\\\d|1\\\\d{2}|2[0-4]\\\\d|25[0-5])\\\\.){3}(\\\\d|[1-9]\\\\d|1\\\\d{2}|2[0-4]\\\\d|25[0-5])$\",\"port_rau\": \"^[1-9]\\\\d*$\",\"enabled\": \"^[01]$\",\"save_oscillography\": \"^[01]$\",\"est_pset_channel_number\": \"^[37]$\",\"c_koef_0\": \"^[+-]?(\\\\d*\\\\.\\\\d+|\\\\d+\\\\.\\\\d*|\\\\d+)$\",\"c_koef_1\": \"^[+-]?(\\\\d*\\\\.\\\\d+|\\\\d+\\\\.\\\\d*|\\\\d+)$\",\"c_koef_2\": \"^[+-]?(\\\\d*\\\\.\\\\d+|\\\\d+\\\\.\\\\d*|\\\\d+)$\",\"c_koef_3\": \"^[+-]?(\\\\d*\\\\.\\\\d+|\\\\d+\\\\.\\\\d*|\\\\d+)$\",\"c_koef_4\": \"^[+-]?(\\\\d*\\\\.\\\\d+|\\\\d+\\\\.\\\\d*|\\\\d+)$\",\"c_koef_5\": \"^[+-]?(\\\\d*\\\\.\\\\d+|\\\\d+\\\\.\\\\d*|\\\\d+)$\",\"c_koef_6\": \"^[+-]?(\\\\d*\\\\.\\\\d+|\\\\d+\\\\.\\\\d*|\\\\d+)$\",\"c_koef_7\": \"^[+-]?(\\\\d*\\\\.\\\\d+|\\\\d+\\\\.\\\\d*|\\\\d+)$\",\"log_time_period\": \"^[1-9]\\\\d*$\",\"c_cons_i\": \"^[+-]?(\\\\d*\\\\.\\\\d+|\\\\d+\\\\.\\\\d*|\\\\d+)$\",\"c_cons_u\": \"^[+-]?(\\\\d*\\\\.\\\\d+|\\\\d+\\\\.\\\\d*|\\\\d+)$\",\"mau_2_addr\": \"^((\\\\d|[1-9]\\\\d|1\\\\d{2}|2[0-4]\\\\d|25[0-5])\\\\.){3}(\\\\d|[1-9]\\\\d|1\\\\d{2}|2[0-4]\\\\d|25[0-5])$\",\"mau_2_port\": \"^[1-9]\\\\d*$\",\"dgway\": \"^((\\\\d|[1-9]\\\\d|1\\\\d{2}|2[0-4]\\\\d|25[0-5])\\\\.){3}(\\\\d|[1-9]\\\\d|1\\\\d{2}|2[0-4]\\\\d|25[0-5])$\",\"mac_addr\": \"^((\\\\d|[1-9]\\\\d|1\\\\d{2}|2[0-4]\\\\d|25[0-5])\\\\.){3}(\\\\d|[1-9]\\\\d|1\\\\d{2}|2[0-4]\\\\d|25[0-5])$\"}');
/*!40000 ALTER TABLE `Tbl_Rau_Type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tbl_RawData`
--

DROP TABLE IF EXISTS `Tbl_RawData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tbl_RawData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rau_id` bigint(20) NOT NULL,
  `timestamp` datetime DEFAULT NULL,
  `serial_number` text NOT NULL,
  `status` text NOT NULL,
  `est_freq` double DEFAULT NULL,
  `est_p` double DEFAULT NULL,
  `est_q` double DEFAULT NULL,
  `est_s` double DEFAULT NULL,
  `est_fi` double DEFAULT NULL,
  `est_fi_deg` double DEFAULT NULL,
  `est_pset` double DEFAULT NULL,
  `channel_raw` text NOT NULL,
  `processed` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Tbl_RawData_ibfk_1` (`rau_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1441 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `ts_start` timestamp NULL DEFAULT NULL,
  `ts_end` timestamp NOT NULL DEFAULT current_timestamp(),
  `success` tinyint(1) DEFAULT NULL,
  `message` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_task_id_fk` (`task_id`),
  CONSTRAINT `jobs_task_id_fk` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3559 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` text NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `system_key` (`key`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system`
--

LOCK TABLES `system` WRITE;
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
INSERT INTO `system`(`key`, `value`) VALUES ('ftp_host',''),('ftp_port',''),('ftp_username',''),('ftp_password',''),('ftp_remdir','');
INSERT INTO `system`(`key`, `value`) VALUES ('smtp_host',''),('smtp_auth',''),('smtp_username',''),('smtp_password',''),('smtp_tls',''),('smtp_port',''),('smtp_receiver','');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `period` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`period`)),
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tasks_name_key` (`name`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` text NOT NULL,
  `name` text NOT NULL,
  `password` text NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `mandatory` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_username_key` (`username`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user`(`username`, `name`, `password`, `is_admin`, `mandatory`) VALUES ('admin','admin','$2a$10$xtgT5yhK1tNjYTzNO3ftE.Ep9EDgHdh7Y883QeohXSBB40br8CdTq',1,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-16  7:42:49

INSERT INTO raus.tasks (name,description,period,enabled) VALUES
	 ('archive_csvs','archive_csvs','{"hours":1}',1),
	 ('archive_hires','archive_hires','{"hours":1}',1),
	 ('cleanup_samples','cleanup_samples','{"hours":10}',1),
	 ('process_samples','process_samples','{ "minutes": 10 }',1),
	 ('ftp_transfer','ftp_transfer','{ "minutes": 30 }',1),
	 ('watchdog','watchdog','{ "minutes": 10 }',1),
	 ('mailer','mailer','{ "minutes": 10 }',1),
	 ('aiprocessing','aiprocessing','{ "minutes": 10 }',1);

