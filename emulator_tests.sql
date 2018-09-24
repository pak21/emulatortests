-- MySQL dump 10.16  Distrib 10.1.35-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: emulator_tests
-- ------------------------------------------------------
-- Server version	10.1.35-MariaDB-1

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
-- Table structure for table `emulator_versions`
--

DROP TABLE IF EXISTS `emulator_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emulator_versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emulator_id` int(11) NOT NULL,
  `version` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `release_date` date DEFAULT NULL,
  `test_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `emulator_id_2` (`emulator_id`,`version`),
  KEY `emulator_id` (`emulator_id`),
  KEY `version` (`version`),
  KEY `key` (`key`),
  KEY `release_date` (`release_date`),
  KEY `test_date` (`test_date`),
  CONSTRAINT `emulator_versions_ibfk_1` FOREIGN KEY (`emulator_id`) REFERENCES `emulators` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emulator_versions`
--

LOCK TABLES `emulator_versions` WRITE;
/*!40000 ALTER TABLE `emulator_versions` DISABLE KEYS */;
INSERT INTO `emulator_versions` VALUES (1,1,'1.5.6','1.5.6','2018-08-06','2018-08-31'),(2,1,'1.5.5','1.5.5','2018-07-01','2018-08-31'),(3,1,'1.3.2','1.3.2','2016-12-05','2018-08-31'),(4,2,'7.0','7.0',NULL,'2018-09-02'),(5,3,'0.666','0.666',NULL,'2018-09-02');
/*!40000 ALTER TABLE `emulator_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emulators`
--

DROP TABLE IF EXISTS `emulators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emulators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emulators`
--

LOCK TABLES `emulators` WRITE;
/*!40000 ALTER TABLE `emulators` DISABLE KEYS */;
INSERT INTO `emulators` VALUES (1,'Fuse','fuse'),(2,'ZEsarUX','zesarux'),(3,'ZXSpin','zxspin');
/*!40000 ALTER TABLE `emulators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testsuites`
--

DROP TABLE IF EXISTS `testsuites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testsuites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `parser` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  UNIQUE KEY `name` (`name`),
  KEY `parser` (`parser`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testsuites`
--

LOCK TABLES `testsuites` WRITE;
/*!40000 ALTER TABLE `testsuites` DISABLE KEYS */;
INSERT INTO `testsuites` VALUES (1,'z80test - z80full','z80full','z80test'),(2,'z80test - z80memptr','z80memptr','z80test'),(3,'z80test - z80ccf','z80ccf','z80test'),(4,'fusetest - 48','fusetest48','fusetest'),(5,'fusetest - 128','fusetest128','fusetest'),(6,'fusetest - +3','fusetest+3','fusetest');
/*!40000 ALTER TABLE `testsuites` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-24 21:14:27
