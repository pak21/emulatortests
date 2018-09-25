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
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emulator_version_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `result` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `emulator_version_id` (`emulator_version_id`,`test_id`),
  KEY `test_id` (`test_id`),
  KEY `result` (`result`),
  CONSTRAINT `results_ibfk_1` FOREIGN KEY (`emulator_version_id`) REFERENCES `emulator_versions` (`id`),
  CONSTRAINT `results_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `testsuite_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `testsuite_id` (`testsuite_id`,`name`),
  KEY `name` (`name`),
  CONSTRAINT `tests_ibfk_1` FOREIGN KEY (`testsuite_id`) REFERENCES `testsuites` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=502 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES (80,1,'000 SELF TEST'),(36,1,'001 SCF'),(97,1,'002 CCF'),(134,1,'003 SCF+CCF'),(131,1,'004 CCF+SCF'),(110,1,'005 DAA'),(15,1,'006 CPL'),(37,1,'007 NEG'),(9,1,'008 NEG\''),(25,1,'009 ADD A,N'),(130,1,'010 ADC A,N'),(39,1,'011 SUB A,N'),(89,1,'012 SBC A,N'),(26,1,'013 AND N'),(136,1,'014 XOR N'),(42,1,'015 OR N'),(135,1,'016 CP N'),(63,1,'017 ALO A,A'),(61,1,'018 ALO A,[B,C]'),(122,1,'019 ALO A,[D,E]'),(128,1,'020 ALO A,[H,L]'),(56,1,'021 ALO A,(HL)'),(13,1,'022 ALO A,[HX,LX]'),(145,1,'023 ALO A,[HY,LY]'),(101,1,'024 ALO A,(XY)'),(70,1,'025 RLCA'),(81,1,'026 RRCA'),(22,1,'027 RLA'),(77,1,'028 RRA'),(50,1,'029 RLD'),(59,1,'030 RRD'),(49,1,'031 RLC A'),(112,1,'032 RRC A'),(140,1,'033 RL A'),(34,1,'034 RR A'),(68,1,'035 SLA A'),(51,1,'036 SRA A'),(147,1,'037 SLIA A'),(71,1,'038 SRL A'),(141,1,'039 RLC [R,(HL)]'),(106,1,'040 RRC [R,(HL)]'),(99,1,'041 RL [R,(HL)]'),(4,1,'042 RR [R,(HL)]'),(74,1,'043 SLA [R,(HL)]'),(12,1,'044 SRA [R,(HL)]'),(40,1,'045 SLIA [R,(HL)]'),(19,1,'046 SRL [R,(HL)]'),(100,1,'047 SRO (XY)'),(104,1,'048 SRO (XY),R'),(54,1,'049 INC A'),(32,1,'050 DEC A'),(119,1,'051 INC [R,(HL)]'),(24,1,'052 DEC [R,(HL)]'),(14,1,'053 INC X'),(87,1,'054 DEC X'),(18,1,'055 INC (XY)'),(111,1,'056 DEC (XY)'),(91,1,'057 INC RR'),(105,1,'058 DEC RR'),(21,1,'059 INC XY'),(151,1,'060 DEC XY'),(117,1,'061 ADD HL,RR'),(3,1,'062 ADD IX,RR'),(127,1,'063 ADD IY,RR'),(93,1,'064 ADC HL,RR'),(113,1,'065 SBC HL,RR'),(65,1,'066 BIT N,A'),(17,1,'067 BIT N,(HL)'),(64,1,'068 BIT N,[R,(HL)]'),(7,1,'069 BIT N,(XY)'),(23,1,'070 BIT N,(XY),-'),(2,1,'071 SET N,A'),(95,1,'072 SET N,(HL)'),(143,1,'073 SET N,[R,(HL)]'),(107,1,'074 SET N,(XY)'),(150,1,'075 SET N,(XY),R'),(139,1,'076 RES N,A'),(1,1,'077 RES N,(HL)'),(43,1,'078 RES N,[R,(HL)]'),(58,1,'079 RES N,(XY)'),(27,1,'080 RES N,(XY),R'),(38,1,'081 LDI'),(120,1,'082 LDD'),(149,1,'083 LDIR'),(146,1,'084 LDDR'),(142,1,'085 CPI'),(90,1,'086 CPD'),(62,1,'087 CPIR'),(86,1,'088 CPDR'),(33,1,'089 IN A,(N)'),(115,1,'090 IN R,(C)'),(53,1,'091 IN (C)'),(31,1,'092 INI'),(125,1,'093 IND'),(129,1,'094 INIR'),(6,1,'095 INDR'),(132,1,'096 OUT (N),A'),(98,1,'097 OUT (C),R'),(79,1,'098 OUT (C),0'),(118,1,'099 OUTI'),(55,1,'100 OUTD'),(133,1,'101 OTIR'),(10,1,'102 OTDR'),(83,1,'103 JP NN'),(41,1,'104 JP CC,NN'),(114,1,'105 JP (HL)'),(137,1,'106 JP (XY)'),(103,1,'107 JR N'),(94,1,'108 JR CC,N'),(85,1,'109 DJNZ N'),(8,1,'110 CALL NN'),(44,1,'111 CALL CC,NN'),(16,1,'112 RET'),(35,1,'113 RET CC'),(46,1,'114 RETN'),(76,1,'115 RETI'),(45,1,'116 RETI/RETN'),(138,1,'117 PUSH+POP RR'),(152,1,'118 POP+PUSH AF'),(73,1,'119 PUSH+POP XY'),(20,1,'120 EX DE,HL'),(108,1,'121 EX AF,AF\''),(88,1,'122 EXX'),(92,1,'123 EX (SP),HL'),(78,1,'124 EX (SP),XY'),(116,1,'125 LD [R,(HL)],[R,(HL)]'),(82,1,'126 LD [X,(XY)],[X,(XY)]'),(148,1,'127 LD R,(XY)'),(96,1,'128 LD (XY),R'),(52,1,'129 LD [R,(HL)],N'),(47,1,'130 LD X,N'),(5,1,'131 LD (XY),N'),(48,1,'132 LD A,([BC,DE])'),(29,1,'133 LD ([BC,DE]),A'),(69,1,'134 LD A,(NN)'),(84,1,'135 LD (NN),A'),(102,1,'136 LD RR,NN'),(28,1,'137 LD XY,NN'),(57,1,'138 LD HL,(NN)'),(124,1,'139 LD XY,(NN)'),(121,1,'140 LD RR,(NN)'),(30,1,'141 LD (NN),HL'),(11,1,'142 LD (NN),XY'),(126,1,'143 LD (NN),RR'),(109,1,'144 LD SP,HL'),(123,1,'145 LD SP,XY'),(66,1,'146 LD I,A'),(67,1,'147 LD R,A'),(75,1,'148 LD A,I'),(60,1,'149 LD A,R'),(72,1,'150 EI+DI'),(144,1,'151 IM N'),(429,2,'000 SELF TEST'),(385,2,'001 SCF'),(446,2,'002 CCF'),(483,2,'003 SCF+CCF'),(480,2,'004 CCF+SCF'),(459,2,'005 DAA'),(364,2,'006 CPL'),(386,2,'007 NEG'),(358,2,'008 NEG\''),(374,2,'009 ADD A,N'),(479,2,'010 ADC A,N'),(388,2,'011 SUB A,N'),(438,2,'012 SBC A,N'),(375,2,'013 AND N'),(485,2,'014 XOR N'),(391,2,'015 OR N'),(484,2,'016 CP N'),(412,2,'017 ALO A,A'),(410,2,'018 ALO A,[B,C]'),(471,2,'019 ALO A,[D,E]'),(477,2,'020 ALO A,[H,L]'),(405,2,'021 ALO A,(HL)'),(362,2,'022 ALO A,[HX,LX]'),(494,2,'023 ALO A,[HY,LY]'),(450,2,'024 ALO A,(XY)'),(419,2,'025 RLCA'),(430,2,'026 RRCA'),(371,2,'027 RLA'),(426,2,'028 RRA'),(399,2,'029 RLD'),(408,2,'030 RRD'),(398,2,'031 RLC A'),(461,2,'032 RRC A'),(489,2,'033 RL A'),(383,2,'034 RR A'),(417,2,'035 SLA A'),(400,2,'036 SRA A'),(496,2,'037 SLIA A'),(420,2,'038 SRL A'),(490,2,'039 RLC [R,(HL)]'),(455,2,'040 RRC [R,(HL)]'),(448,2,'041 RL [R,(HL)]'),(353,2,'042 RR [R,(HL)]'),(423,2,'043 SLA [R,(HL)]'),(361,2,'044 SRA [R,(HL)]'),(389,2,'045 SLIA [R,(HL)]'),(368,2,'046 SRL [R,(HL)]'),(449,2,'047 SRO (XY)'),(453,2,'048 SRO (XY),R'),(403,2,'049 INC A'),(381,2,'050 DEC A'),(468,2,'051 INC [R,(HL)]'),(373,2,'052 DEC [R,(HL)]'),(363,2,'053 INC X'),(436,2,'054 DEC X'),(367,2,'055 INC (XY)'),(460,2,'056 DEC (XY)'),(440,2,'057 INC RR'),(454,2,'058 DEC RR'),(370,2,'059 INC XY'),(500,2,'060 DEC XY'),(466,2,'061 ADD HL,RR'),(352,2,'062 ADD IX,RR'),(476,2,'063 ADD IY,RR'),(442,2,'064 ADC HL,RR'),(462,2,'065 SBC HL,RR'),(414,2,'066 BIT N,A'),(366,2,'067 BIT N,(HL)'),(413,2,'068 BIT N,[R,(HL)]'),(356,2,'069 BIT N,(XY)'),(372,2,'070 BIT N,(XY),-'),(351,2,'071 SET N,A'),(444,2,'072 SET N,(HL)'),(492,2,'073 SET N,[R,(HL)]'),(456,2,'074 SET N,(XY)'),(499,2,'075 SET N,(XY),R'),(488,2,'076 RES N,A'),(350,2,'077 RES N,(HL)'),(392,2,'078 RES N,[R,(HL)]'),(407,2,'079 RES N,(XY)'),(376,2,'080 RES N,(XY),R'),(387,2,'081 LDI'),(469,2,'082 LDD'),(498,2,'083 LDIR'),(495,2,'084 LDDR'),(491,2,'085 CPI'),(439,2,'086 CPD'),(411,2,'087 CPIR'),(435,2,'088 CPDR'),(382,2,'089 IN A,(N)'),(464,2,'090 IN R,(C)'),(402,2,'091 IN (C)'),(380,2,'092 INI'),(474,2,'093 IND'),(478,2,'094 INIR'),(355,2,'095 INDR'),(481,2,'096 OUT (N),A'),(447,2,'097 OUT (C),R'),(428,2,'098 OUT (C),0'),(467,2,'099 OUTI'),(404,2,'100 OUTD'),(482,2,'101 OTIR'),(359,2,'102 OTDR'),(432,2,'103 JP NN'),(390,2,'104 JP CC,NN'),(463,2,'105 JP (HL)'),(486,2,'106 JP (XY)'),(452,2,'107 JR N'),(443,2,'108 JR CC,N'),(434,2,'109 DJNZ N'),(357,2,'110 CALL NN'),(393,2,'111 CALL CC,NN'),(365,2,'112 RET'),(384,2,'113 RET CC'),(395,2,'114 RETN'),(425,2,'115 RETI'),(394,2,'116 RETI/RETN'),(487,2,'117 PUSH+POP RR'),(501,2,'118 POP+PUSH AF'),(422,2,'119 PUSH+POP XY'),(369,2,'120 EX DE,HL'),(457,2,'121 EX AF,AF\''),(437,2,'122 EXX'),(441,2,'123 EX (SP),HL'),(427,2,'124 EX (SP),XY'),(465,2,'125 LD [R,(HL)],[R,(HL)]'),(431,2,'126 LD [X,(XY)],[X,(XY)]'),(497,2,'127 LD R,(XY)'),(445,2,'128 LD (XY),R'),(401,2,'129 LD [R,(HL)],N'),(396,2,'130 LD X,N'),(354,2,'131 LD (XY),N'),(397,2,'132 LD A,([BC,DE])'),(378,2,'133 LD ([BC,DE]),A'),(418,2,'134 LD A,(NN)'),(433,2,'135 LD (NN),A'),(451,2,'136 LD RR,NN'),(377,2,'137 LD XY,NN'),(406,2,'138 LD HL,(NN)'),(473,2,'139 LD XY,(NN)'),(470,2,'140 LD RR,(NN)'),(379,2,'141 LD (NN),HL'),(360,2,'142 LD (NN),XY'),(475,2,'143 LD (NN),RR'),(458,2,'144 LD SP,HL'),(472,2,'145 LD SP,XY'),(415,2,'146 LD I,A'),(416,2,'147 LD R,A'),(424,2,'148 LD A,I'),(409,2,'149 LD A,R'),(421,2,'150 EI+DI'),(493,2,'151 IM N'),(275,3,'000 SELF TEST'),(233,3,'001 SCF'),(294,3,'002 CCF'),(331,3,'003 SCF+CCF'),(328,3,'004 CCF+SCF'),(307,3,'005 DAA'),(212,3,'006 CPL'),(234,3,'007 NEG'),(206,3,'008 NEG\''),(222,3,'009 ADD A,N'),(326,3,'010 ADC A,N'),(236,3,'011 SUB A,N'),(285,3,'012 SBC A,N'),(223,3,'013 AND N'),(333,3,'014 XOR N'),(239,3,'015 OR N'),(332,3,'016 CP N'),(260,3,'017 ALO A,A'),(258,3,'018 ALO A,[B,C]'),(319,3,'019 ALO A,[D,E]'),(325,3,'020 ALO A,[H,L]'),(253,3,'021 ALO A,(HL)'),(210,3,'022 ALO A,[HX,LX]'),(342,3,'023 ALO A,[HY,LY]'),(298,3,'024 ALO A,(XY)'),(267,3,'025 RLCA'),(278,3,'026 RRCA'),(219,3,'027 RLA'),(274,3,'028 RRA'),(247,3,'029 RLD'),(256,3,'030 RRD'),(246,3,'031 RLC A'),(309,3,'032 RRC A'),(337,3,'033 RL A'),(231,3,'034 RR A'),(265,3,'035 SLA A'),(248,3,'036 SRA A'),(344,3,'037 SLIA A'),(268,3,'038 SRL A'),(338,3,'039 RLC [R,(HL)]'),(303,3,'040 RRC [R,(HL)]'),(296,3,'041 RL [R,(HL)]'),(201,3,'042 RR [R,(HL)]'),(271,3,'043 SLA [R,(HL)]'),(209,3,'044 SRA [R,(HL)]'),(237,3,'045 SLIA [R,(HL)]'),(216,3,'046 SRL [R,(HL)]'),(297,3,'047 SRO (XY)'),(301,3,'048 SRO (XY),R'),(251,3,'049 INC A'),(229,3,'050 DEC A'),(316,3,'051 INC [R,(HL)]'),(221,3,'052 DEC [R,(HL)]'),(211,3,'053 INC X'),(284,3,'054 DEC X'),(215,3,'055 INC (XY)'),(308,3,'056 DEC (XY)'),(288,3,'057 INC RR'),(302,3,'058 DEC RR'),(218,3,'059 INC XY'),(348,3,'060 DEC XY'),(314,3,'061 ADD HL,RR'),(200,3,'062 ADD IX,RR'),(324,3,'063 ADD IY,RR'),(290,3,'064 ADC HL,RR'),(310,3,'065 SBC HL,RR'),(262,3,'066 BIT N,A'),(214,3,'067 BIT N,(HL)'),(261,3,'068 BIT N,[R,(HL)]'),(204,3,'069 BIT N,(XY)'),(220,3,'070 BIT N,(XY),-'),(199,3,'071 SET N,A'),(292,3,'072 SET N,(HL)'),(340,3,'073 SET N,[R,(HL)]'),(304,3,'074 SET N,(XY)'),(347,3,'075 SET N,(XY),R'),(336,3,'076 RES N,A'),(198,3,'077 RES N,(HL)'),(240,3,'078 RES N,[R,(HL)]'),(255,3,'079 RES N,(XY)'),(224,3,'080 RES N,(XY),R'),(235,3,'081 LDI'),(317,3,'082 LDD'),(346,3,'083 LDIR'),(343,3,'084 LDDR'),(339,3,'085 CPI'),(287,3,'086 CPD'),(259,3,'087 CPIR'),(283,3,'088 CPDR'),(230,3,'089 IN A,(N)'),(312,3,'090 IN R,(C)'),(250,3,'091 IN (C)'),(228,3,'092 INI'),(322,3,'093 IND'),(327,3,'094 INIR'),(203,3,'095 INDR'),(329,3,'096 OUT (N),A'),(295,3,'097 OUT (C),R'),(277,3,'098 OUT (C),0'),(315,3,'099 OUTI'),(252,3,'100 OUTD'),(330,3,'101 OTIR'),(207,3,'102 OTDR'),(280,3,'103 JP NN'),(238,3,'104 JP CC,NN'),(311,3,'105 JP (HL)'),(334,3,'106 JP (XY)'),(300,3,'107 JR N'),(291,3,'108 JR CC,N'),(282,3,'109 DJNZ N'),(205,3,'110 CALL NN'),(241,3,'111 CALL CC,NN'),(213,3,'112 RET'),(232,3,'113 RET CC'),(243,3,'114 RETN'),(273,3,'115 RETI'),(242,3,'116 RETI/RETN'),(335,3,'117 PUSH+POP RR'),(349,3,'118 POP+PUSH AF'),(270,3,'119 PUSH+POP XY'),(217,3,'120 EX DE,HL'),(305,3,'121 EX AF,AF\''),(286,3,'122 EXX'),(289,3,'123 EX (SP),HL'),(276,3,'124 EX (SP),XY'),(313,3,'125 LD [R,(HL)],[R,(HL)]'),(279,3,'126 LD [X,(XY)],[X,(XY)]'),(345,3,'127 LD R,(XY)'),(293,3,'128 LD (XY),R'),(249,3,'129 LD [R,(HL)],N'),(244,3,'130 LD X,N'),(202,3,'131 LD (XY),N'),(245,3,'132 LD A,([BC,DE])'),(226,3,'133 LD ([BC,DE]),A'),(266,3,'134 LD A,(NN)'),(281,3,'135 LD (NN),A'),(299,3,'136 LD RR,NN'),(225,3,'137 LD XY,NN'),(254,3,'138 LD HL,(NN)'),(321,3,'139 LD XY,(NN)'),(318,3,'140 LD RR,(NN)'),(227,3,'141 LD (NN),HL'),(208,3,'142 LD (NN),XY'),(323,3,'143 LD (NN),RR'),(306,3,'144 LD SP,HL'),(320,3,'145 LD SP,XY'),(263,3,'146 LD I,A'),(264,3,'147 LD R,A'),(272,3,'148 LD A,I'),(257,3,'149 LD A,R'),(269,3,'150 EI+DI'),(341,3,'151 IM N'),(186,4,'0x3ffd read'),(190,4,'0x7ffd read'),(187,4,'0xbffd read'),(188,4,'BIT n,(IX+d)'),(195,4,'Contended IN'),(196,4,'Contended memory'),(183,4,'Contention offset'),(184,4,'DAA'),(191,4,'Floating bus'),(197,4,'Frame length'),(192,4,'High port contention 1'),(185,4,'High port contention 2'),(193,4,'LDIR'),(189,4,'Machine type'),(194,4,'OUTI'),(171,5,'0x3ffd read'),(175,5,'0x7ffd read'),(172,5,'0xbffd read'),(173,5,'BIT n,(IX+d)'),(180,5,'Contended IN'),(181,5,'Contended memory'),(168,5,'Contention offset'),(169,5,'DAA'),(176,5,'Floating bus'),(182,5,'Frame length'),(177,5,'High port contention 1'),(170,5,'High port contention 2'),(178,5,'LDIR'),(174,5,'Machine type'),(179,5,'OUTI'),(156,6,'0x3ffd read'),(160,6,'0x7ffd read'),(157,6,'0xbffd read'),(158,6,'BIT n,(IX+d)'),(165,6,'Contended IN'),(166,6,'Contended memory'),(153,6,'Contention offset'),(154,6,'DAA'),(161,6,'Floating bus'),(167,6,'Frame length'),(162,6,'High port contention 1'),(155,6,'High port contention 2'),(163,6,'LDIR'),(159,6,'Machine type'),(164,6,'OUTI');
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
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

-- Dump completed on 2018-09-25 21:45:23
