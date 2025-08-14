/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: uoh
-- ------------------------------------------------------
-- Server version	11.8.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `digimons`
--

DROP TABLE IF EXISTS `digimons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `digimons` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `digimons`
--

LOCK TABLES `digimons` WRITE;
/*!40000 ALTER TABLE `digimons` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `digimons` VALUES
(1,'Enton'),
(2,'Mauzi'),
(3,'Glumanda'),
(4,'Rattfratz'),
(6,'Evoli'),
(7,'Feelinara');
/*!40000 ALTER TABLE `digimons` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Temporary table structure for view `digimons_view`
--

DROP TABLE IF EXISTS `digimons_view`;
/*!50001 DROP VIEW IF EXISTS `digimons_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `digimons_view` AS SELECT
 1 AS `name` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pokimons`
--

DROP TABLE IF EXISTS `pokimons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokimons` (
  `id` smallint(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokimons`
--

LOCK TABLES `pokimons` WRITE;
/*!40000 ALTER TABLE `pokimons` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `pokimons` VALUES
(1,'Agumon'),
(2,'Weregarurumon'),
(3,'Chinchin'),
(4,'Angemon'),
(5,'Angewomon'),
(6,'Omnimon'),
(8,'Wargraymon');
/*!40000 ALTER TABLE `pokimons` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Final view structure for view `digimons_view`
--

/*!50001 DROP VIEW IF EXISTS `digimons_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`chen`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `digimons_view` AS select `digimons`.`name` AS `name` from `digimons` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-08-11 10:35:52
