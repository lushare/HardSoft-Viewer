-- MySQL dump 10.15  Distrib 10.0.17-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: HardSoft
-- ------------------------------------------------------
-- Server version	10.0.17-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `HardSoft`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `HardSoft` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `HardSoft`;

--
-- Table structure for table `Computers`
--

DROP TABLE IF EXISTS `Computers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Computers` (
  `id` varchar(20) NOT NULL,
  `Factory` varchar(50) DEFAULT NULL,
  `Depart` varchar(50) DEFAULT NULL,
  `Owner` varchar(50) DEFAULT NULL,
  `Account` varchar(50) DEFAULT NULL,
  `Locate` varchar(50) DEFAULT NULL,
  `Mark` varchar(20) DEFAULT NULL,
  `Note` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Control`
--

DROP TABLE IF EXISTS `Control`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Control` (
  `id` varchar(40) NOT NULL,
  `ScanTime` datetime DEFAULT NULL,
  `Admin` varchar(200) DEFAULT NULL,
  `Poweruser` varchar(200) DEFAULT NULL,
  `Usb` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `Get_2D_3D_Soft`
--

DROP TABLE IF EXISTS `Get_2D_3D_Soft`;
/*!50001 DROP VIEW IF EXISTS `Get_2D_3D_Soft`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Get_2D_3D_Soft` (
  `Soft_ID` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `SoftName` tinyint NOT NULL,
  `ScanTime` tinyint NOT NULL,
  `Note` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Get_Adobe_Soft`
--

DROP TABLE IF EXISTS `Get_Adobe_Soft`;
/*!50001 DROP VIEW IF EXISTS `Get_Adobe_Soft`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Get_Adobe_Soft` (
  `Soft_ID` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `SoftName` tinyint NOT NULL,
  `ScanTime` tinyint NOT NULL,
  `Note` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Get_MS_Office`
--

DROP TABLE IF EXISTS `Get_MS_Office`;
/*!50001 DROP VIEW IF EXISTS `Get_MS_Office`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Get_MS_Office` (
  `Soft_ID` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `SoftName` tinyint NOT NULL,
  `ScanTime` tinyint NOT NULL,
  `Note` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Get_Null_Info`
--

DROP TABLE IF EXISTS `Get_Null_Info`;
/*!50001 DROP VIEW IF EXISTS `Get_Null_Info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Get_Null_Info` (
  `Factory` tinyint NOT NULL,
  `Depart` tinyint NOT NULL,
  `Owner` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `Locate` tinyint NOT NULL,
  `OS` tinyint NOT NULL,
  `CPU` tinyint NOT NULL,
  `Ram` tinyint NOT NULL,
  `Display_Card` tinyint NOT NULL,
  `Computer_Type` tinyint NOT NULL,
  `MotherBoard_Type` tinyint NOT NULL,
  `HardDisk_Type` tinyint NOT NULL,
  `HardDisk_Size` tinyint NOT NULL,
  `NetCard_Type` tinyint NOT NULL,
  `MAC_Address` tinyint NOT NULL,
  `IP_Address` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Get_Other_Soft`
--

DROP TABLE IF EXISTS `Get_Other_Soft`;
/*!50001 DROP VIEW IF EXISTS `Get_Other_Soft`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Get_Other_Soft` (
  `Soft_ID` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `SoftName` tinyint NOT NULL,
  `ScanTime` tinyint NOT NULL,
  `Note` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Get_Rhino_Soft`
--

DROP TABLE IF EXISTS `Get_Rhino_Soft`;
/*!50001 DROP VIEW IF EXISTS `Get_Rhino_Soft`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Get_Rhino_Soft` (
  `Soft_ID` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `SoftName` tinyint NOT NULL,
  `ScanTime` tinyint NOT NULL,
  `Note` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Get_Scan_Info`
--

DROP TABLE IF EXISTS `Get_Scan_Info`;
/*!50001 DROP VIEW IF EXISTS `Get_Scan_Info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Get_Scan_Info` (
  `Factory` tinyint NOT NULL,
  `Depart` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `Owner` tinyint NOT NULL,
  `Account` tinyint NOT NULL,
  `Locate` tinyint NOT NULL,
  `OS` tinyint NOT NULL,
  `CPU` tinyint NOT NULL,
  `Computer_Type` tinyint NOT NULL,
  `Ram` tinyint NOT NULL,
  `STAND_Ram` tinyint NOT NULL,
  `Display_Card` tinyint NOT NULL,
  `MotherBoard_Vendor` tinyint NOT NULL,
  `MotherBoard_Type` tinyint NOT NULL,
  `HardDisk_Type` tinyint NOT NULL,
  `HardDisk_Size` tinyint NOT NULL,
  `STAND_HD_Size` tinyint NOT NULL,
  `NetCard_Type` tinyint NOT NULL,
  `MAC_Address` tinyint NOT NULL,
  `IP_Address` tinyint NOT NULL,
  `Admin` tinyint NOT NULL,
  `Poweruser` tinyint NOT NULL,
  `USB` tinyint NOT NULL,
  `Mark` tinyint NOT NULL,
  `Note` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Get_Soft`
--

DROP TABLE IF EXISTS `Get_Soft`;
/*!50001 DROP VIEW IF EXISTS `Get_Soft`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Get_Soft` (
  `Soft_ID` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `SoftName` tinyint NOT NULL,
  `ScanTime` tinyint NOT NULL,
  `Note` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `Get_UnScan_Computer`
--

DROP TABLE IF EXISTS `Get_UnScan_Computer`;
/*!50001 DROP VIEW IF EXISTS `Get_UnScan_Computer`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `Get_UnScan_Computer` (
  `廠別` tinyint NOT NULL,
  `部門` tinyint NOT NULL,
  `財產編號` tinyint NOT NULL,
  `使用者` tinyint NOT NULL,
  `帳戶` tinyint NOT NULL,
  `存放位置` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `HardInfo`
--

DROP TABLE IF EXISTS `HardInfo`;
/*!50001 DROP VIEW IF EXISTS `HardInfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `HardInfo` (
  `廠別` tinyint NOT NULL,
  `部門` tinyint NOT NULL,
  `財產編號` tinyint NOT NULL,
  `使用者` tinyint NOT NULL,
  `帳戶` tinyint NOT NULL,
  `存放位置` tinyint NOT NULL,
  `操作系統` tinyint NOT NULL,
  `CPU` tinyint NOT NULL,
  `主機型號` tinyint NOT NULL,
  `內存` tinyint NOT NULL,
  `標準內存` tinyint NOT NULL,
  `顯卡` tinyint NOT NULL,
  `主板廠商` tinyint NOT NULL,
  `主板型號` tinyint NOT NULL,
  `硬盤型號` tinyint NOT NULL,
  `硬盤大小` tinyint NOT NULL,
  `標準硬盤大小` tinyint NOT NULL,
  `網卡型號` tinyint NOT NULL,
  `MAC` tinyint NOT NULL,
  `IP` tinyint NOT NULL,
  `Admin` tinyint NOT NULL,
  `Poweruser` tinyint NOT NULL,
  `USB` tinyint NOT NULL,
  `Mark` tinyint NOT NULL,
  `備註` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Hardware`
--

DROP TABLE IF EXISTS `Hardware`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Hardware` (
  `id` varchar(50) NOT NULL,
  `ScanTime` datetime DEFAULT NULL,
  `OS` varchar(200) DEFAULT NULL,
  `CPU` varchar(200) DEFAULT NULL,
  `Computer_Type` varchar(80) DEFAULT NULL,
  `Ram` varchar(80) DEFAULT NULL,
  `Display_Card` varchar(100) DEFAULT NULL,
  `MotherBoard_Vendor` varchar(80) DEFAULT NULL,
  `MotherBoard_Type` varchar(200) DEFAULT NULL,
  `HardDisk_Type` varchar(200) DEFAULT NULL,
  `HardDisk_Size` varchar(80) DEFAULT NULL,
  `NetCard_Type` varchar(100) DEFAULT NULL,
  `MAC_Address` varchar(200) DEFAULT NULL,
  `IP_Address` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Software`
--

DROP TABLE IF EXISTS `Software`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Software` (
  `Soft_ID` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(80) NOT NULL,
  `ScanTime` datetime DEFAULT NULL,
  `SoftName` varchar(200) DEFAULT NULL,
  `Note` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Soft_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16680 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `HardSoft`
--

USE `HardSoft`;

--
-- Final view structure for view `Get_2D_3D_Soft`
--

/*!50001 DROP TABLE IF EXISTS `Get_2D_3D_Soft`*/;
/*!50001 DROP VIEW IF EXISTS `Get_2D_3D_Soft`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Get_2D_3D_Soft` AS select `Software`.`Soft_ID` AS `Soft_ID`,`Software`.`id` AS `id`,`Software`.`SoftName` AS `SoftName`,max(`Software`.`ScanTime`) AS `ScanTime`,max(`Software`.`Note`) AS `Note` from `Software` where (((lcase(`Software`.`SoftName`) like '%engineer%') or (lcase(`Software`.`SoftName`) like '%magics%') or (lcase(`Software`.`SoftName`) like '%t-splines%') or (lcase(`Software`.`SoftName`) like '%keyshot%') or (lcase(`Software`.`SoftName`) like '%shoecost%') or (lcase(`Software`.`SoftName`) like '%cad%') or (lcase(`Software`.`SoftName`) like '%uvlayout%') or (lcase(`Software`.`SoftName`) like '%coreldraw%') or (lcase(`Software`.`SoftName`) like '%3dmax%') or (lcase(`Software`.`SoftName`) like '%maya%') or (lcase(`Software`.`SoftName`) like '%solidworks%')) and (not((lcase(`Software`.`SoftName`) like '%help%media%'))) and (not((lcase(`Software`.`SoftName`) like '%language%pack%')))) group by `Software`.`SoftName`,`Software`.`id` order by `Software`.`id`,`Software`.`SoftName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Get_Adobe_Soft`
--

/*!50001 DROP TABLE IF EXISTS `Get_Adobe_Soft`*/;
/*!50001 DROP VIEW IF EXISTS `Get_Adobe_Soft`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Get_Adobe_Soft` AS select `Software`.`Soft_ID` AS `Soft_ID`,`Software`.`id` AS `id`,`Software`.`SoftName` AS `SoftName`,max(`Software`.`ScanTime`) AS `ScanTime`,max(`Software`.`Note`) AS `Note` from `Software` where (((lcase(`Software`.`SoftName`) like '%illustrator%') or (lcase(`Software`.`SoftName`) like '%photoshop%') or (lcase(`Software`.`SoftName`) like '%acrobat%') or (lcase(`Software`.`SoftName`) like '%audition%') or (lcase(`Software`.`SoftName`) like '%premiere%') or (lcase(`Software`.`SoftName`) like '%dreamweaver%') or (lcase(`Software`.`SoftName`) like '%fireworks%') or (lcase(`Software`.`SoftName`) like '%lightroom%') or (lcase(`Software`.`SoftName`) like '%flash%professional%') or (lcase(`Software`.`SoftName`) like '%captivate%') or (lcase(`Software`.`SoftName`) like '%coldfusion%') or (lcase(`Software`.`SoftName`) like '%after%effects%')) and (not((lcase(`Software`.`SoftName`) like '%help%media%'))) and (not((lcase(`Software`.`SoftName`) like '%language%pack%')))) group by `Software`.`SoftName`,`Software`.`id` order by `Software`.`id`,`Software`.`SoftName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Get_MS_Office`
--

/*!50001 DROP TABLE IF EXISTS `Get_MS_Office`*/;
/*!50001 DROP VIEW IF EXISTS `Get_MS_Office`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Get_MS_Office` AS select `Software`.`Soft_ID` AS `Soft_ID`,`Software`.`id` AS `id`,`Software`.`SoftName` AS `SoftName`,max(`Software`.`ScanTime`) AS `ScanTime`,max(`Software`.`Note`) AS `Note` from `Software` where ((lcase(`Software`.`SoftName`) like '%microsoft%office%') and (not((lcase(`Software`.`SoftName`) like '%security%'))) and (not((lcase(`Software`.`SoftName`) like '%viewer%'))) and (not((lcase(`Software`.`SoftName`) like '%update%'))) and (not((lcase(`Software`.`SoftName`) like '%add-in%'))) and (not((lcase(`Software`.`SoftName`) like '%mui%'))) and (not((lcase(`Software`.`SoftName`) like '%help%'))) and (not((lcase(`Software`.`SoftName`) like '%proof%'))) and (not((lcase(`Software`.`SoftName`) like '%ime%'))) and (not((lcase(`Software`.`SoftName`) like '%sp%')))) group by `Software`.`SoftName`,`Software`.`id` order by `Software`.`id`,`Software`.`SoftName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Get_Null_Info`
--

/*!50001 DROP TABLE IF EXISTS `Get_Null_Info`*/;
/*!50001 DROP VIEW IF EXISTS `Get_Null_Info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Get_Null_Info` AS select `Computers`.`Factory` AS `Factory`,`Computers`.`Depart` AS `Depart`,`Computers`.`Owner` AS `Owner`,`Computers`.`id` AS `id`,`Computers`.`Locate` AS `Locate`,`Hardware`.`OS` AS `OS`,`Hardware`.`CPU` AS `CPU`,`Hardware`.`Ram` AS `Ram`,`Hardware`.`Display_Card` AS `Display_Card`,`Hardware`.`Computer_Type` AS `Computer_Type`,`Hardware`.`MotherBoard_Type` AS `MotherBoard_Type`,`Hardware`.`HardDisk_Type` AS `HardDisk_Type`,`Hardware`.`HardDisk_Size` AS `HardDisk_Size`,`Hardware`.`NetCard_Type` AS `NetCard_Type`,`Hardware`.`MAC_Address` AS `MAC_Address`,`Hardware`.`IP_Address` AS `IP_Address` from (`Hardware` join `Computers`) where (((length(`Hardware`.`OS`) < 2) or (length(`Hardware`.`CPU`) < 4) or (length(`Hardware`.`Ram`) < 2) or (length(`Hardware`.`Display_Card`) < 2) or (length(`Hardware`.`MotherBoard_Type`) < 2) or (length(`Hardware`.`HardDisk_Type`) < 2) or (length(`Hardware`.`HardDisk_Size`) < 2) or (length(`Hardware`.`NetCard_Type`) < 2) or (length(`Hardware`.`MAC_Address`) < 2) or (length(`Hardware`.`IP_Address`) < 2)) and (`Hardware`.`id` = `Computers`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Get_Other_Soft`
--

/*!50001 DROP TABLE IF EXISTS `Get_Other_Soft`*/;
/*!50001 DROP VIEW IF EXISTS `Get_Other_Soft`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Get_Other_Soft` AS select `Software`.`Soft_ID` AS `Soft_ID`,`Software`.`id` AS `id`,`Software`.`SoftName` AS `SoftName`,max(`Software`.`ScanTime`) AS `ScanTime`,max(`Software`.`Note`) AS `Note` from `Software` where (((lcase(`Software`.`SoftName`) like '%dos%') or (lcase(`Software`.`SoftName`) like '%wps%office%') or (lcase(`Software`.`SoftName`) like '%winrar%') or (lcase(`Software`.`SoftName`) like '%2345%') or (lcase(`Software`.`SoftName`) like '%ghost%') or (lcase(`Software`.`SoftName`) like '%oe-mail%') or (lcase(`Software`.`SoftName`) like '%realvnc%') or (lcase(`Software`.`SoftName`) like '%radmin%') or (lcase(`Software`.`SoftName`) like '%sms%') or (lcase(`Software`.`SoftName`) like 'qq%') or (lcase(`Software`.`SoftName`) like '%sogou%') or (lcase(`Software`.`SoftName`) like '%remote%administrator%') or (lcase(`Software`.`SoftName`) like '%搜狗%')) and (not((lcase(`Software`.`SoftName`) like '%viewer%')))) group by `Software`.`SoftName`,`Software`.`id` order by `Software`.`id`,`Software`.`SoftName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Get_Rhino_Soft`
--

/*!50001 DROP TABLE IF EXISTS `Get_Rhino_Soft`*/;
/*!50001 DROP VIEW IF EXISTS `Get_Rhino_Soft`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Get_Rhino_Soft` AS select max(`b`.`Soft_ID`) AS `Soft_ID`,`b`.`id` AS `id`,`b`.`SoftName` AS `SoftName`,`b`.`ScanTime` AS `ScanTime`,`b`.`Note` AS `Note` from `Software` `b` where (`b`.`id`,`b`.`SoftName`) in (select `a`.`id`,min(`a`.`SoftName`) from `Software` `a` where `a`.`SoftName` in (select distinct `c`.`SoftName` from `Software` `c` where ((lcase(`c`.`SoftName`) like '%rhinoceros%') and (not((lcase(`c`.`SoftName`) like '%help%media%')))) group by `c`.`SoftName`) group by `a`.`id`) group by `b`.`id`,`b`.`SoftName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Get_Scan_Info`
--

/*!50001 DROP TABLE IF EXISTS `Get_Scan_Info`*/;
/*!50001 DROP VIEW IF EXISTS `Get_Scan_Info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Get_Scan_Info` AS select `Computers`.`Factory` AS `Factory`,`Computers`.`Depart` AS `Depart`,`Computers`.`id` AS `id`,`Computers`.`Owner` AS `Owner`,`Computers`.`Account` AS `Account`,`Computers`.`Locate` AS `Locate`,`Hardware`.`OS` AS `OS`,`Hardware`.`CPU` AS `CPU`,`Hardware`.`Computer_Type` AS `Computer_Type`,`Hardware`.`Ram` AS `Ram`,concat((ceiling((`Hardware`.`Ram` / 256)) * 256),'MB') AS `STAND_Ram`,`Hardware`.`Display_Card` AS `Display_Card`,`Hardware`.`MotherBoard_Vendor` AS `MotherBoard_Vendor`,`Hardware`.`MotherBoard_Type` AS `MotherBoard_Type`,`Hardware`.`HardDisk_Type` AS `HardDisk_Type`,`Hardware`.`HardDisk_Size` AS `HardDisk_Size`,concat((case when ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 40) then 40 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 40) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 80)) then 80 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 80) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 120)) then 120 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 120) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 160)) then 160 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 160) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 250)) then 250 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 250) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 320)) then 320 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 320) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 500)) then 500 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 500) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 750)) then 750 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 750) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 1024)) then 1024 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 1024) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 1500)) then 1500 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 1500) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 2048)) then 2048 end),'GB') AS `STAND_HD_Size`,`Hardware`.`NetCard_Type` AS `NetCard_Type`,`Hardware`.`MAC_Address` AS `MAC_Address`,`Hardware`.`IP_Address` AS `IP_Address`,`Control`.`Admin` AS `Admin`,`Control`.`Poweruser` AS `Poweruser`,(case when (`Control`.`Usb` = '1') then '開' else '關' end) AS `USB`,`Computers`.`Mark` AS `Mark`,`Computers`.`Note` AS `Note` from ((`Computers` join `Hardware`) join `Control`) where ((`Computers`.`id` = `Hardware`.`id`) and (`Computers`.`id` = `Control`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Get_Soft`
--

/*!50001 DROP TABLE IF EXISTS `Get_Soft`*/;
/*!50001 DROP VIEW IF EXISTS `Get_Soft`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Get_Soft` AS select `Get_2D_3D_Soft`.`Soft_ID` AS `Soft_ID`,`Get_2D_3D_Soft`.`id` AS `id`,`Get_2D_3D_Soft`.`SoftName` AS `SoftName`,`Get_2D_3D_Soft`.`ScanTime` AS `ScanTime`,`Get_2D_3D_Soft`.`Note` AS `Note` from `Get_2D_3D_Soft` union all select `Get_Adobe_Soft`.`Soft_ID` AS `Soft_ID`,`Get_Adobe_Soft`.`id` AS `id`,`Get_Adobe_Soft`.`SoftName` AS `SoftName`,`Get_Adobe_Soft`.`ScanTime` AS `ScanTime`,`Get_Adobe_Soft`.`Note` AS `Note` from `Get_Adobe_Soft` union all select `Get_MS_Office`.`Soft_ID` AS `Soft_ID`,`Get_MS_Office`.`id` AS `id`,`Get_MS_Office`.`SoftName` AS `SoftName`,`Get_MS_Office`.`ScanTime` AS `ScanTime`,`Get_MS_Office`.`Note` AS `Note` from `Get_MS_Office` union all select `Get_Other_Soft`.`Soft_ID` AS `Soft_ID`,`Get_Other_Soft`.`id` AS `id`,`Get_Other_Soft`.`SoftName` AS `SoftName`,`Get_Other_Soft`.`ScanTime` AS `ScanTime`,`Get_Other_Soft`.`Note` AS `Note` from `Get_Other_Soft` union all select `Get_Rhino_Soft`.`Soft_ID` AS `Soft_ID`,`Get_Rhino_Soft`.`id` AS `id`,`Get_Rhino_Soft`.`SoftName` AS `SoftName`,`Get_Rhino_Soft`.`ScanTime` AS `ScanTime`,`Get_Rhino_Soft`.`Note` AS `Note` from `Get_Rhino_Soft` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Get_UnScan_Computer`
--

/*!50001 DROP TABLE IF EXISTS `Get_UnScan_Computer`*/;
/*!50001 DROP VIEW IF EXISTS `Get_UnScan_Computer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Get_UnScan_Computer` AS select `Computers`.`Factory` AS `廠別`,`Computers`.`Depart` AS `部門`,`Computers`.`id` AS `財產編號`,`Computers`.`Owner` AS `使用者`,`Computers`.`Account` AS `帳戶`,`Computers`.`Locate` AS `存放位置` from `Computers` where (not(`Computers`.`id` in (select `Hardware`.`id` from `Hardware`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `HardInfo`
--

/*!50001 DROP TABLE IF EXISTS `HardInfo`*/;
/*!50001 DROP VIEW IF EXISTS `HardInfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `HardInfo` AS select `Computers`.`Factory` AS `廠別`,`Computers`.`Depart` AS `部門`,`Computers`.`id` AS `財產編號`,`Computers`.`Owner` AS `使用者`,`Computers`.`Account` AS `帳戶`,`Computers`.`Locate` AS `存放位置`,`Hardware`.`OS` AS `操作系統`,`Hardware`.`CPU` AS `CPU`,`Hardware`.`Computer_Type` AS `主機型號`,`Hardware`.`Ram` AS `內存`,concat((ceiling((`Hardware`.`Ram` / 256)) * 256),'MB') AS `標準內存`,`Hardware`.`Display_Card` AS `顯卡`,`Hardware`.`MotherBoard_Vendor` AS `主板廠商`,`Hardware`.`MotherBoard_Type` AS `主板型號`,`Hardware`.`HardDisk_Type` AS `硬盤型號`,`Hardware`.`HardDisk_Size` AS `硬盤大小`,concat((case when ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 40) then 40 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 40) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 80)) then 80 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 80) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 120)) then 120 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 120) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 160)) then 160 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 160) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 250)) then 250 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 250) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 320)) then 320 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 320) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 500)) then 500 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 500) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 750)) then 750 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 750) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 1024)) then 1024 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 1024) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 1500)) then 1500 when (((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) > 1500) and ((`Hardware`.`HardDisk_Size` / ((1024 * 1024) * 1024)) <= 2048)) then 2048 end),'GB') AS `標準硬盤大小`,`Hardware`.`NetCard_Type` AS `網卡型號`,`Hardware`.`MAC_Address` AS `MAC`,`Hardware`.`IP_Address` AS `IP`,`Control`.`Admin` AS `Admin`,`Control`.`Poweruser` AS `Poweruser`,(case when (`Control`.`Usb` = '1') then '開' else '關' end) AS `USB`,`Computers`.`Mark` AS `Mark`,`Computers`.`Note` AS `備註` from ((`Computers` join `Hardware`) join `Control`) where ((`Computers`.`id` = `Hardware`.`id`) and (`Computers`.`id` = `Control`.`id`)) */;
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
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-14 13:46:47
