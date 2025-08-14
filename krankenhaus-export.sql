/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.3-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: Krankenhaus
-- ------------------------------------------------------
-- Server version	11.8.3-MariaDB

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
-- Table structure for table `Abteilung`
--

DROP TABLE IF EXISTS `Abteilung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Abteilung` (
  `AbteilungID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(30) NOT NULL,
  PRIMARY KEY (`AbteilungID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Abteilung`
--

LOCK TABLES `Abteilung` WRITE;
/*!40000 ALTER TABLE `Abteilung` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Abteilung` VALUES
(1,'Innere Medizin'),
(2,'Chirurgie'),
(3,'Urologie'),
(4,'Orthopädie');
/*!40000 ALTER TABLE `Abteilung` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Arzt`
--

DROP TABLE IF EXISTS `Arzt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Arzt` (
  `ArztId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Adresse` varchar(60) NOT NULL,
  `Plz` char(4) NOT NULL,
  `AbteilungID` int(11) NOT NULL,
  PRIMARY KEY (`ArztId`),
  KEY `AbteilungID` (`AbteilungID`),
  CONSTRAINT `Arzt_ibfk_1` FOREIGN KEY (`AbteilungID`) REFERENCES `Abteilung` (`AbteilungID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Arzt`
--

LOCK TABLES `Arzt` WRITE;
/*!40000 ALTER TABLE `Arzt` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Arzt` VALUES
(1,'Jamie Oliver','Annenstraße 7','8020',1),
(2,'Jakob Bruder','Rebengasse 20','8020',1),
(3,'Matt Damon','Ballhausgasse 6','8010',2),
(4,'Rami Malek','Sauraugasse 24','8010',2),
(5,'Jimmy Blue Ochsenknecht','Andritzer Reichsstraße 42a','8045',3),
(6,'Otto Waalkes','Am Andritzbach 34','8045',4);
/*!40000 ALTER TABLE `Arzt` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `Behandlung`
--

DROP TABLE IF EXISTS `Behandlung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Behandlung` (
  `BehandlungID` int(11) NOT NULL AUTO_INCREMENT,
  `ArztID` int(11) DEFAULT NULL,
  `PersonalID` int(11) DEFAULT NULL,
  `PatientID` int(11) NOT NULL,
  `RaumID` int(11) DEFAULT NULL,
  `Datum` date DEFAULT NULL,
  `Anmerkungen` text DEFAULT NULL,
  PRIMARY KEY (`BehandlungID`),
  KEY `ArztID` (`ArztID`),
  KEY `PersonalID` (`PersonalID`),
  KEY `PatientID` (`PatientID`),
  KEY `RaumID` (`RaumID`),
  CONSTRAINT `Behandlung_ibfk_1` FOREIGN KEY (`ArztID`) REFERENCES `Arzt` (`ArztId`),
  CONSTRAINT `Behandlung_ibfk_2` FOREIGN KEY (`PersonalID`) REFERENCES `Personal` (`PersonalID`),
  CONSTRAINT `Behandlung_ibfk_3` FOREIGN KEY (`PatientID`) REFERENCES `Patient` (`PatientID`),
  CONSTRAINT `Behandlung_ibfk_4` FOREIGN KEY (`RaumID`) REFERENCES `Raum` (`RaumID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Behandlung`
--

LOCK TABLES `Behandlung` WRITE;
/*!40000 ALTER TABLE `Behandlung` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Behandlung` VALUES
(1,1,1,1,1,'2024-01-01','Text Text Text'),
(2,1,NULL,2,4,'2024-02-01','Füge Arzt-Fachjargon hier ein'),
(3,2,NULL,3,5,'2024-03-01','Test'),
(4,2,NULL,3,5,'2024-03-01','Test');
/*!40000 ALTER TABLE `Behandlung` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`chen`@`localhost`*/ /*!50003 TRIGGER Behandlungsdatum_Neu
BEFORE INSERT ON Behandlung
FOR EACH ROW
BEGIN
    DECLARE aufnahme DATE;
    DECLARE entlassung DATE;

    SELECT Aufnahmedatum, Entlassungsdatum
    INTO aufnahme, entlassung
    FROM Patient
    WHERE PatientID = NEW.PatientID;

    IF entlassung IS NOT NULL AND NEW.Datum > entlassung THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Behandlungsdatum muss übereinstimmen mit den Aufenthaltszeiten des Patienten.';
    END IF;

    IF NEW.Datum < aufnahme THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Behandlungsdatum muss übereinstimmen mit den Aufenthaltszeiten des Patienten.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`chen`@`localhost`*/ /*!50003 TRIGGER Behandlungsdatum_Bearbeiten
BEFORE UPDATE ON Behandlung
FOR EACH ROW
BEGIN
    DECLARE aufnahme DATE;
    DECLARE entlassung DATE;

    SELECT Aufnahmedatum, Entlassungsdatum
    INTO aufnahme, entlassung
    FROM Patient
    WHERE PatientID = NEW.PatientID;

    IF entlassung IS NOT NULL AND NEW.Datum > entlassung THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Behandlungsdatum muss übereinstimmen mit den Aufenthaltszeiten des Patienten.';
    END IF;

    IF NEW.Datum < aufnahme THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Behandlungsdatum muss übereinstimmen mit den Aufenthaltszeiten des Patienten.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `Behandlung_Anzahl`
--

DROP TABLE IF EXISTS `Behandlung_Anzahl`;
/*!50001 DROP VIEW IF EXISTS `Behandlung_Anzahl`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `Behandlung_Anzahl` AS SELECT
 1 AS `Arztname`,
  1 AS `Behandlungen` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Behandlung_Übersicht`
--

DROP TABLE IF EXISTS `Behandlung_Übersicht`;
/*!50001 DROP VIEW IF EXISTS `Behandlung_Übersicht`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `Behandlung_Übersicht` AS SELECT
 1 AS `BehandlungID`,
  1 AS `Patient`,
  1 AS `Arzt`,
  1 AS `Raum`,
  1 AS `Datum` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient` (
  `PatientID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Adresse` varchar(60) NOT NULL,
  `Plz` char(4) NOT NULL,
  `AbteilungID` int(11) DEFAULT NULL,
  `Aufnahmedatum` date NOT NULL,
  `Entlassungsdatum` date DEFAULT NULL,
  PRIMARY KEY (`PatientID`),
  KEY `AbteilungID` (`AbteilungID`),
  CONSTRAINT `Patient_ibfk_1` FOREIGN KEY (`AbteilungID`) REFERENCES `Abteilung` (`AbteilungID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Patient` VALUES
(1,'Hans Müllersohn','Müllersohn Straße 104','8020',1,'2024-01-01','2024-01-02'),
(2,'Hans Müllersohns Sohn','Müllersohn Straße 104','8020',2,'2024-02-01','2024-02-02'),
(3,'Hans Müllersohns Hund','Müllersohn Straße 104','8020',1,'2024-03-01','2024-03-02'),
(4,'Der Sohn von Hans Müllersohns Sohn','Müllersohn Straße 104','8020',2,'2024-04-01','2024-04-02'),
(5,'Hans Müllersohns Reue','Müllersohn Straße 104','8020',1,'2024-01-01',NULL),
(6,'Hans Müllersohns Ambitionen','Müllersohn Straße 104','8020',2,'2024-02-01',NULL),
(7,'Hans Müllersohns Empathievermögen','Müllersohn Straße 104','8020',3,'2024-07-01',NULL),
(8,'Hans Müllersohns Selbstlosigkeit','Müllersohn Straße 104','8020',4,'2024-08-01',NULL),
(9,'Jan Böhmermann','Weiß niemand','8010',3,'2025-08-08',NULL),
(10,'Patrick Stern','Die WasgehtSieDasAn Straße 27','8045',3,'2025-08-10',NULL),
(11,'Wolfgang Petri','Die WasgehtSieDasAn Straße 28','8045',4,'2025-08-12',NULL),
(12,'Lenny Kravitz','Die eine Straße 3','8041',1,'2025-08-12',NULL);
/*!40000 ALTER TABLE `Patient` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`chen`@`localhost`*/ /*!50003 TRIGGER Patientdatum_Neu
BEFORE INSERT ON Patient
FOR EACH ROW
BEGIN
    IF NEW.Entlassungsdatum IS NOT NULL AND NEW.Aufnahmedatum > NEW.Entlassungsdatum THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Aufnahmedatum darf nicht vor Entlassungsdatum stattfinden.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`chen`@`localhost`*/ /*!50003 TRIGGER Patientdatum_Bearbeiten
BEFORE UPDATE ON Patient
FOR EACH ROW
BEGIN
    IF NEW.Entlassungsdatum IS NOT NULL AND NEW.Aufnahmedatum > NEW.Entlassungsdatum THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Aufnahmedatum darf nicht vor Entlassungsdatum stattfinden.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Personal`
--

DROP TABLE IF EXISTS `Personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Personal` (
  `PersonalID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Adresse` varchar(60) NOT NULL,
  `Plz` char(4) NOT NULL,
  `Rolle` enum('Reinigungsdienst','Rezeptionist','Arztassistent') NOT NULL,
  `AbteilungID` int(11) NOT NULL,
  PRIMARY KEY (`PersonalID`),
  KEY `Personal_AbteilungID` (`AbteilungID`),
  CONSTRAINT `Personal_AbteilungID` FOREIGN KEY (`AbteilungID`) REFERENCES `Abteilung` (`AbteilungID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Personal`
--

LOCK TABLES `Personal` WRITE;
/*!40000 ALTER TABLE `Personal` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Personal` VALUES
(1,'Felix Blume','Eine Gasse 1','8010','Rezeptionist',1),
(2,'Peter Pansky','Zweite Gasse 2','8010','Rezeptionist',2),
(3,'Android 16','Gasse 3','8020','Rezeptionist',3),
(4,'Android 17','Gasse 4','8020','Rezeptionist',4),
(5,'Rick Sanchez','Winkelgasse 3','8020','Arztassistent',1),
(6,'Morty Sanchez','Winkelgasse 3','8020','Arztassistent',1),
(7,'Willhelm Tell','Winkelgasse 23','8020','Arztassistent',2),
(8,'Willhelm Tell Me More','Winkelgasse 23','8020','Arztassistent',2),
(9,'Willy Wisser','Straße 2','8010','Arztassistent',3),
(10,'Waldo Wo','Straße 4','8010','Arztassistent',4),
(11,'Wall-E','Straße 1','8020','Reinigungsdienst',1),
(12,'Adam','Straße 100','8020','Reinigungsdienst',2),
(13,'Eva','Straße 100','8020','Reinigungsdienst',2),
(14,'Walter Verwalter','Albrechtgasse 29','8010','Reinigungsdienst',3),
(15,'Brigitte Bitte','Am Linegg','8044','Reinigungsdienst',4),
(16,'Anke Danke','Andreas-Hofer-Platz 2','8010','Reinigungsdienst',4),
(17,'Kunigunde Horvatslos','Forstergasse 9','8053','Reinigungsdienst',4);
/*!40000 ALTER TABLE `Personal` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Temporary table structure for view `Personal_Übersicht`
--

DROP TABLE IF EXISTS `Personal_Übersicht`;
/*!50001 DROP VIEW IF EXISTS `Personal_Übersicht`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `Personal_Übersicht` AS SELECT
 1 AS `Name`,
  1 AS `Rolle`,
  1 AS `Abteilung` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Raum`
--

DROP TABLE IF EXISTS `Raum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Raum` (
  `RaumID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `AbteilungID` int(11) NOT NULL,
  PRIMARY KEY (`RaumID`),
  KEY `AbteilungID` (`AbteilungID`),
  CONSTRAINT `Raum_ibfk_1` FOREIGN KEY (`AbteilungID`) REFERENCES `Abteilung` (`AbteilungID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Raum`
--

LOCK TABLES `Raum` WRITE;
/*!40000 ALTER TABLE `Raum` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `Raum` VALUES
(1,'101',1),
(2,'101E',1),
(3,'102',1),
(4,'103',1),
(5,'Saal 1',2),
(6,'Saal 2',2),
(7,'210',3),
(8,'211',3),
(9,'212',3),
(10,'213',3),
(11,'214',3),
(12,'401',4),
(13,'402',4),
(14,'403',4);
/*!40000 ALTER TABLE `Raum` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Final view structure for view `Behandlung_Anzahl`
--

/*!50001 DROP VIEW IF EXISTS `Behandlung_Anzahl`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`chen`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Behandlung_Anzahl` AS select `a`.`Name` AS `Arztname`,count(0) AS `Behandlungen` from (`Behandlung` `b` join `Arzt` `a` on(`b`.`ArztID` = `a`.`ArztId`)) group by `a`.`ArztId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Behandlung_Übersicht`
--

/*!50001 DROP VIEW IF EXISTS `Behandlung_Übersicht`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`chen`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Behandlung_Übersicht` AS select `Behandlung`.`BehandlungID` AS `BehandlungID`,`Patient`.`Name` AS `Patient`,`Arzt`.`Name` AS `Arzt`,`Raum`.`Name` AS `Raum`,`Behandlung`.`Datum` AS `Datum` from (((`Behandlung` join `Patient` on(`Behandlung`.`PatientID` = `Patient`.`PatientID`)) join `Arzt` on(`Behandlung`.`ArztID` = `Arzt`.`ArztId`)) join `Raum` on(`Behandlung`.`RaumID` = `Raum`.`RaumID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Personal_Übersicht`
--

/*!50001 DROP VIEW IF EXISTS `Personal_Übersicht`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`chen`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Personal_Übersicht` AS select `Personal`.`Name` AS `Name`,`Personal`.`Rolle` AS `Rolle`,`Abteilung`.`Name` AS `Abteilung` from (`Personal` join `Abteilung` on(`Personal`.`AbteilungID` = `Abteilung`.`AbteilungID`)) */;
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

-- Dump completed on 2025-08-14 14:10:06
