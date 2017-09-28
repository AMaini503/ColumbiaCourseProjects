CREATE DATABASE  IF NOT EXISTS `hw2m` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `hw2m`;
-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: hw2m
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

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
-- Table structure for table `Course`
--

DROP TABLE IF EXISTS `Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course` (
  `CourseID` varchar(20) NOT NULL,
  `FullName` varchar(50) NOT NULL,
  `CourseCode` varchar(10) NOT NULL,
  PRIMARY KEY (`CourseID`,`FullName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course`
--

LOCK TABLES `Course` WRITE;
/*!40000 ALTER TABLE `Course` DISABLE KEYS */;
INSERT INTO `Course` VALUES ('1','Intro to DBMS','CS-0001'),('10','Principles of Network Security','CS-0010'),('11','Basic Electrical Science','ES-1001'),('12','Analog Circuits','ES-1002'),('13','Embedded Hardware Design','ES-1003'),('14','Signals & Systems','ES-1004'),('15','Wireless Communications','ES-1005'),('16','Communication Theory','ES-1006'),('17','Communication Networks','ES-1007'),('18','Error Correcting Codes','ES-1008'),('19','Computational Electromagnetics','ES-1009'),('2','Machine Learning','CS-0002'),('20','Analog & mixed signal design','ES-1010'),('21','Building materials & construction','BS-2001'),('22','Mechanics of Solids','BS-2002'),('23','Structural Analysis','BS-2003'),('24','Strength of materials','BS-2004'),('25','Water Resource Engg.','BS-2005'),('26','Design of concrete Structures','BS-2006'),('27','Soil Mechanics','BS-2007'),('28','Environmental Science','BS-2008'),('29','Design of steel Structures','BS-2009'),('3','Deep Learning','CS-0003'),('30','Transportation Engg.','BS-2010'),('31','Digital Logic Design','EL-3001'),('32','Engineering Electronics 1','EL-3002'),('33','Basic Electronic Circuits','EL-3003'),('34','Linear Electronic Circuits','EL-3004'),('35','Digital Integrated Circuits','EL-3005'),('36','Semiconductor Processing','EL-3006'),('37','Lasers & Photonics','EL-3007'),('38','Microelectronics','EL-3008'),('39','Bioelectrics','EL-3009'),('4','Analysis of Algorithms 1','CS-0004'),('40','Optical Communications','EL-3010'),('41','Linear Algebra','MT-4001'),('42','Calculus 1','MT-4002'),('43','Calculus 2','MT-4003'),('44','Probability Theory & Statistics','MT-4004'),('45','Differential Equations','MT-4005'),('46','Number Theory in Cryptography','MT-4006'),('47','Abstract Algebra','MT-4007'),('48','Mathematics 1','MT-4008'),('49','Complex Numbers','MT-4009'),('5','Analysis of Algorithms 2','CS-0005'),('50','Fourier & Laplace Transforms','MT-4010'),('51','General Chemistry for Engineers','NS-5001'),('52','University Physics','NS-5002'),('53','Electromagnetic Field Theory','NS-5003'),('54','Intro to Quantum Optics','NS-5004'),('55','Quantum Mechanics','NS-5005'),('56','Semiconductor Physics','NS-5006'),('57','Electricity, Magnetism, and Waves','NS-5007'),('58','Mathematical Methods for Physics','NS-5008'),('59','Thermodynamics and Kinetic Theory','NS-5009'),('6','Advanced Machine Learning','CS-0006'),('60','Foundations of Modern Physics','NS-5010'),('61','History of Black Magic','BM-6001'),('62','Chemistry for black magic','BM-6002'),('63','Computational Black Magic','BM-6003'),('64','Black Magic lab 1','BM-6004'),('65','Practical Applications of black magic','BM-6005'),('66','Acing interviews with black magic','BM-6006'),('67','Case study - How google search uses black magic','BM-6007'),('68','Ethical Concerns associated with black magic','BM-6008'),('69','Gray Hat and White hat practitioners','BM-6009'),('7','Bayesian Models','CS-0007'),('70','Solving NP-Hard problems with black magic','BM-6010'),('8','Data Structures','CS-0008'),('9','Graphics & Animation','CS-0009');
/*!40000 ALTER TABLE `Course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Department` (
  `ID` int(8) NOT NULL,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`,`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (1,'Computer Science'),(2,'Electrical Science'),(3,'Electronics'),(4,'Building Science'),(5,'Natural Sciences'),(6,'Mathematics'),(7,'Black Magic');
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Faculty`
--

DROP TABLE IF EXISTS `Faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Faculty` (
  `FacultyID` varchar(50) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `EmailID` varchar(45) NOT NULL,
  `DeptID` int(8) NOT NULL,
  `DeptName` varchar(20) NOT NULL,
  PRIMARY KEY (`FacultyID`,`FirstName`,`LastName`,`DeptID`,`DeptName`),
  KEY `fk_Faculty_1_idx` (`DeptID`,`DeptName`),
  CONSTRAINT `fk_Faculty_1` FOREIGN KEY (`DeptID`, `DeptName`) REFERENCES `Department` (`ID`, `Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faculty`
--

LOCK TABLES `Faculty` WRITE;
/*!40000 ALTER TABLE `Faculty` DISABLE KEYS */;
INSERT INTO `Faculty` VALUES ('4383597','Dominic','Jones','kuhlman.george@example.net',6,'Mathematics'),('4387189','Velva','Greenfelder','west.blaise@example.net',3,'Electronics'),('4416925','Petra','Windler','robb60@example.org',4,'Building Science'),('4452493','Herman','Monahan','bo68@example.com',4,'Building Science'),('4498251','Meredith','Kling','austin60@example.org',7,'Black Magic'),('4547617','Elmore','Gislason','grimes.rick@example.org',2,'Electrical Science'),('4701832','Mina','Crona','breana.sporer@example.com',7,'Black Magic'),('4773645','Carmen','Yundt','gsteuber@example.org',1,'Computer Science'),('5121001','Robert','OKon','ehuel@example.org',5,'Natural Sciences'),('5147071','Tomas','Pollich','lgrant@example.net',6,'Mathematics'),('9211397','Marcelle','Bruen','stevie85@example.com',4,'Building Science'),('9334741','Alisha','Jacobs','monahan.una@example.com',5,'Natural Sciences'),('9367129','Paula','Nikolaus','mmarks@example.com',2,'Electrical Science'),('9429138','Zoila','Maggio','margot10@example.com',5,'Natural Sciences'),('9460352','Toby','Ratke','shields.miller@example.org',3,'Electronics'),('9538638','Rodolfo','Stracke','greta.wisozk@example.net',5,'Natural Sciences'),('974054','Zoie','Mohr','tina.purdy@example.org',3,'Electronics'),('9744898','Hailee','Walsh','kpacocha@example.net',1,'Computer Science'),('978516','Katelynn','Wisozk','cjakubowski@example.org',4,'Building Science'),('9936696','Paxton','Spencer','wilma.dare@example.net',3,'Electronics');
/*!40000 ALTER TABLE `Faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Has_completed`
--

DROP TABLE IF EXISTS `Has_completed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Has_completed` (
  `StudentID` varchar(50) NOT NULL,
  `StudentFName` varchar(45) NOT NULL,
  `StudentLName` varchar(45) NOT NULL,
  `CourseID` varchar(20) NOT NULL,
  `CourseName` varchar(50) NOT NULL,
  `SectionNumber` int(5) NOT NULL,
  `Grade` char(1) NOT NULL,
  PRIMARY KEY (`StudentID`,`StudentFName`,`StudentLName`,`CourseID`,`CourseName`,`SectionNumber`),
  KEY `fk_Has_completed_idx_2` (`StudentID`,`StudentFName`,`StudentLName`),
  KEY `fk_Has_completed_idx_1` (`CourseID`,`CourseName`,`SectionNumber`),
  CONSTRAINT `fk_has_completed_1` FOREIGN KEY (`StudentID`, `StudentFName`, `StudentLName`) REFERENCES `Student` (`StudentID`, `FirstName`, `LastName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_has_completed_2` FOREIGN KEY (`CourseID`, `CourseName`, `SectionNumber`) REFERENCES `Sections` (`CourseID`, `CourseName`, `SectionNumber`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Has_completed`
--

LOCK TABLES `Has_completed` WRITE;
/*!40000 ALTER TABLE `Has_completed` DISABLE KEYS */;
INSERT INTO `Has_completed` VALUES ('108305','Derick','Herzog','35','Digital Integrated Circuits',1,'B'),('1122938','Kaleb','Wunsch','34','Linear Electronic Circuits',1,'A'),('1122938','Kaleb','Wunsch','37','Lasers & Photonics',3,'B'),('1226675','Guiseppe','Trantow','42','Calculus 1',1,'C'),('1456827','Monserrate','Donnelly','63','Computational Black Magic',2,'C'),('1483094','Mckayla','Marks','61','History of Black Magic',1,'C'),('1483094','Mckayla','Marks','68','Ethical Concerns associated with black magic',2,'B'),('187456','Khalil','Swift','31','Digital Logic Design',1,'B'),('187456','Khalil','Swift','61','History of Black Magic',2,'A'),('187456','Khalil','Swift','68','Ethical Concerns associated with black magic',2,'C'),('2166740','Garnet','Bode','31','Digital Logic Design',1,'C'),('2166740','Garnet','Bode','32','Engineering Electronics 1',2,'C'),('2166740','Garnet','Bode','38','Microelectronics',1,'C'),('2166740','Garnet','Bode','61','History of Black Magic',1,'A'),('2166740','Garnet','Bode','68','Ethical Concerns associated with black magic',2,'B'),('2214635','Fannie','Marquardt','53','Electromagnetic Field Theory',1,'C'),('2214635','Fannie','Marquardt','59','Thermodynamics and Kinetic Theory',1,'C'),('2323349','Roxane','Treutel','37','Lasers & Photonics',3,'B'),('2348464','Lou','Mayer','64','Black Magic lab 1',1,'B'),('249892','Melyna','Rolfson','51','General Chemistry for Engineers',1,'A'),('249892','Melyna','Rolfson','57','Electricity, Magnetism, and Waves',2,'B'),('2519995','Tiara','Mitchell','13','Embedded Hardware Design',1,'C'),('2675321','Julie','Bergstrom','17','Communication Networks',2,'C'),('2689948','Viva','Douglas','64','Black Magic lab 1',2,'B'),('2843927','Madisen','Grimes','17','Communication Networks',2,'C'),('3110237','Ruthie','Goldner','63','Computational Black Magic',2,'C'),('3211500','Eileen','Rowe','31','Digital Logic Design',1,'B'),('3211500','Eileen','Rowe','32','Engineering Electronics 1',2,'A'),('3211500','Eileen','Rowe','38','Microelectronics',3,'B'),('3211500','Eileen','Rowe','61','History of Black Magic',1,'A'),('3211500','Eileen','Rowe','68','Ethical Concerns associated with black magic',2,'B'),('3353909','Carson','Huel','44','Probability Theory & Statistics',1,'C'),('3353909','Carson','Huel','63','Computational Black Magic',2,'C'),('3363152','Queen','Sawayn','63','Computational Black Magic',2,'A'),('3487297','Stacy','McLaughlin','42','Calculus 1',1,'C'),('3487297','Stacy','McLaughlin','44','Probability Theory & Statistics',1,'A'),('3487297','Stacy','McLaughlin','63','Computational Black Magic',2,'A'),('350835','Aditya','Stokes','61','History of Black Magic',2,'A'),('350835','Aditya','Stokes','68','Ethical Concerns associated with black magic',2,'C'),('3635025','Raheem','Rogahn','14','Signals & Systems',2,'B'),('3635025','Raheem','Rogahn','19','Computational Electromagnetics',1,'A'),('3894755','Willow','Kovacek','35','Digital Integrated Circuits',1,'B'),('3901455','Athena','Conroy','51','General Chemistry for Engineers',1,'C'),('3901455','Athena','Conroy','57','Electricity, Magnetism, and Waves',2,'A'),('4038360','Angus','Welch','35','Digital Integrated Circuits',2,'A'),('4124507','Gerard','Hahn','63','Computational Black Magic',1,'B'),('4146108','Brant','Rippin','11','Basic Electrical Science',1,'C'),('4146108','Brant','Rippin','15','Wireless Communications',2,'A'),('4146108','Brant','Rippin','64','Black Magic lab 1',2,'A'),('4291180','Cynthia','Sanford','61','History of Black Magic',2,'C'),('4291180','Cynthia','Sanford','64','Black Magic lab 1',1,'A'),('4291180','Cynthia','Sanford','68','Ethical Concerns associated with black magic',2,'A'),('5194621','Carrie','Ullrich','63','Computational Black Magic',2,'C'),('5209857','Lue','Jenkins','21','Building materials & construction',3,'C'),('5209857','Lue','Jenkins','51','General Chemistry for Engineers',1,'A'),('5209857','Lue','Jenkins','57','Electricity, Magnetism, and Waves',2,'A'),('5279488','Janice','Waters','13','Embedded Hardware Design',2,'B'),('5286705','Aida','Lemke','64','Black Magic lab 1',2,'C'),('5357196','Bernardo','Ledner','35','Digital Integrated Circuits',2,'B'),('5357196','Bernardo','Ledner','64','Black Magic lab 1',1,'A'),('5544611','Davonte','Bartoletti','35','Digital Integrated Circuits',2,'B'),('577128','Howell','VonRueden','34','Linear Electronic Circuits',1,'B'),('577128','Howell','VonRueden','37','Lasers & Photonics',3,'C'),('5878911','Vada','Dare','2','Machine Learning',1,'C'),('6127813','Carmine','Muller','31','Digital Logic Design',3,'C'),('6127813','Carmine','Muller','35','Digital Integrated Circuits',1,'C'),('6127813','Carmine','Muller','61','History of Black Magic',1,'C'),('6127813','Carmine','Muller','68','Ethical Concerns associated with black magic',2,'B'),('6230579','Mittie','Medhurst','14','Signals & Systems',2,'B'),('6230579','Mittie','Medhurst','19','Computational Electromagnetics',1,'B'),('6312014','Wiley','Daniel','35','Digital Integrated Circuits',1,'C'),('6312014','Wiley','Daniel','64','Black Magic lab 1',1,'C'),('6390411','Teagan','Morar','14','Signals & Systems',2,'C'),('6390411','Teagan','Morar','19','Computational Electromagnetics',1,'C'),('63991','Kobe','Baumbach','11','Basic Electrical Science',1,'A'),('63991','Kobe','Baumbach','15','Wireless Communications',2,'B'),('63991','Kobe','Baumbach','64','Black Magic lab 1',2,'B'),('6488326','Rene','Wintheiser','11','Basic Electrical Science',1,'B'),('6488326','Rene','Wintheiser','15','Wireless Communications',2,'C'),('6488326','Rene','Wintheiser','64','Black Magic lab 1',2,'B'),('6518392','Pietro','Cole','64','Black Magic lab 1',2,'A'),('6573643','Kitty','Blanda','11','Basic Electrical Science',1,'B'),('6573643','Kitty','Blanda','15','Wireless Communications',2,'B'),('6573643','Kitty','Blanda','64','Black Magic lab 1',2,'A'),('6581486','Milford','Fay','35','Digital Integrated Circuits',1,'A'),('6581486','Milford','Fay','63','Computational Black Magic',1,'C'),('6605236','Magnus','Dibbert','28','Environmental Science',2,'B'),('6605236','Magnus','Dibbert','42','Calculus 1',1,'C'),('6605236','Magnus','Dibbert','44','Probability Theory & Statistics',2,'C'),('6605236','Magnus','Dibbert','63','Computational Black Magic',1,'A'),('7157161','Hayley','Homenick','35','Digital Integrated Circuits',2,'A'),('7157161','Hayley','Homenick','53','Electromagnetic Field Theory',2,'B'),('7297006','Shane','Metz','63','Computational Black Magic',1,'B'),('7700462','Jessika','Terry','35','Digital Integrated Circuits',1,'C'),('7700462','Jessika','Terry','64','Black Magic lab 1',1,'B'),('786717','Effie','Quitzon','21','Building materials & construction',3,'A'),('786717','Effie','Quitzon','51','General Chemistry for Engineers',1,'C'),('786717','Effie','Quitzon','57','Electricity, Magnetism, and Waves',2,'A'),('7868325','Berta','Auer','13','Embedded Hardware Design',2,'C'),('7868325','Berta','Auer','41','Linear Algebra',1,'C'),('7868325','Berta','Auer','42','Calculus 1',1,'A'),('7868325','Berta','Auer','49','Complex Numbers',1,'B'),('8005225','Alek','Streich','13','Embedded Hardware Design',1,'B'),('8005225','Alek','Streich','28','Environmental Science',2,'C'),('8005225','Alek','Streich','41','Linear Algebra',1,'B'),('8005225','Alek','Streich','42','Calculus 1',1,'C'),('8005225','Alek','Streich','44','Probability Theory & Statistics',1,'A'),('8005225','Alek','Streich','49','Complex Numbers',1,'C'),('8005225','Alek','Streich','63','Computational Black Magic',1,'B'),('8006202','Reymundo','Glover','48','Mathematics 1',1,'B'),('8006814','Nichole','Tillman','35','Digital Integrated Circuits',2,'A'),('8006814','Nichole','Tillman','53','Electromagnetic Field Theory',3,'B'),('810465','Jordane','Watsica','48','Mathematics 1',1,'B'),('834354','Ova','Upton','44','Probability Theory & Statistics',1,'C'),('834354','Ova','Upton','63','Computational Black Magic',1,'A'),('8392592','Evert','Friesen','13','Embedded Hardware Design',2,'A'),('8392592','Evert','Friesen','28','Environmental Science',2,'B'),('8392592','Evert','Friesen','35','Digital Integrated Circuits',1,'C'),('8392592','Evert','Friesen','41','Linear Algebra',1,'A'),('8392592','Evert','Friesen','42','Calculus 1',1,'A'),('8392592','Evert','Friesen','44','Probability Theory & Statistics',2,'A'),('8392592','Evert','Friesen','49','Complex Numbers',1,'C'),('8392592','Evert','Friesen','63','Computational Black Magic',1,'A'),('8933058','Rocky','Hills','21','Building materials & construction',3,'A'),('8933058','Rocky','Hills','51','General Chemistry for Engineers',1,'C'),('8933058','Rocky','Hills','57','Electricity, Magnetism, and Waves',2,'C');
/*!40000 ALTER TABLE `Has_completed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Has_enrolled_in`
--

DROP TABLE IF EXISTS `Has_enrolled_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Has_enrolled_in` (
  `StudentID` varchar(50) NOT NULL,
  `StudentFName` varchar(45) NOT NULL,
  `StudentLName` varchar(45) NOT NULL,
  `CourseID` varchar(20) NOT NULL,
  `CourseName` varchar(50) NOT NULL,
  `SectionNumber` int(5) NOT NULL,
  PRIMARY KEY (`StudentID`,`CourseID`,`SectionNumber`,`StudentFName`,`StudentLName`,`CourseName`),
  KEY `fk_has_enrolled_in_idx_1` (`CourseID`,`CourseName`,`SectionNumber`),
  KEY `fk_has_enrolled_in_idx_2` (`StudentID`,`StudentFName`,`StudentLName`),
  CONSTRAINT `fk_has_enrolled_in_1` FOREIGN KEY (`StudentID`, `StudentFName`, `StudentLName`) REFERENCES `Student` (`StudentID`, `FirstName`, `LastName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_has_enrolled_in_2` FOREIGN KEY (`CourseID`, `CourseName`, `SectionNumber`) REFERENCES `Sections` (`CourseID`, `CourseName`, `SectionNumber`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Has_enrolled_in`
--

LOCK TABLES `Has_enrolled_in` WRITE;
/*!40000 ALTER TABLE `Has_enrolled_in` DISABLE KEYS */;
INSERT INTO `Has_enrolled_in` VALUES ('2166740','Garnet','Bode','1','Intro to DBMS',1),('2214635','Fannie','Marquardt','1','Intro to DBMS',1),('9003709','Wilburn','Kirlin','1','Intro to DBMS',1),('2724427','Abdullah','Gerlach','10','Principles of Network Security',1),('7891745','Allan','Lang','10','Principles of Network Security',1),('3058253','Angeline','Predovic','10','Principles of Network Security',2),('6168118','Kasandra','Jacobi','10','Principles of Network Security',2),('2519995','Tiara','Mitchell','11','Basic Electrical Science',1),('5279488','Janice','Waters','11','Basic Electrical Science',1),('6390411','Teagan','Morar','11','Basic Electrical Science',1),('7048760','Hector','Bauch','11','Basic Electrical Science',1),('2675321','Julie','Bergstrom','12','Analog Circuits',2),('2843927','Madisen','Grimes','12','Analog Circuits',2),('3635025','Raheem','Rogahn','13','Embedded Hardware Design',1),('6230579','Mittie','Medhurst','13','Embedded Hardware Design',2),('6547859','Bruce','Thompson','13','Embedded Hardware Design',2),('2689948','Viva','Douglas','14','Signals & Systems',1),('4146108','Brant','Rippin','14','Signals & Systems',1),('63991','Kobe','Baumbach','14','Signals & Systems',1),('6573643','Kitty','Blanda','14','Signals & Systems',2),('6547859','Bruce','Thompson','15','Wireless Communications',2),('9064924','Telly','Moore','15','Wireless Communications',2),('786717','Effie','Quitzon','16','Communication Theory',2),('7048760','Hector','Bauch','17','Communication Networks',2),('2519995','Tiara','Mitchell','19','Computational Electromagnetics',1),('2843927','Madisen','Grimes','19','Computational Electromagnetics',1),('6312014','Wiley','Daniel','19','Computational Electromagnetics',1),('6573643','Kitty','Blanda','19','Computational Electromagnetics',1),('3635025','Raheem','Rogahn','20','Analog & mixed signal design',2),('6390411','Teagan','Morar','20','Analog & mixed signal design',2),('6488326','Rene','Wintheiser','21','Building materials & construction',3),('3842048','Carlie','Kerluke','22','Mechanics of Solids',4),('8933058','Rocky','Hills','22','Mechanics of Solids',4),('3901455','Athena','Conroy','23','Structural Analysis',1),('5209857','Lue','Jenkins','23','Structural Analysis',1),('786717','Effie','Quitzon','23','Structural Analysis',1),('8933058','Rocky','Hills','23','Structural Analysis',1),('63991','Kobe','Baumbach','25','Water Resource Engg.',1),('1830038','Briana','Pouros','25','Water Resource Engg.',4),('4291180','Cynthia','Sanford','25','Water Resource Engg.',4),('577128','Howell','VonRueden','25','Water Resource Engg.',4),('1046236','Emmanuelle','Champlin','26','Design of concrete Structures',1),('4124507','Gerard','Hahn','26','Design of concrete Structures',1),('5544611','Davonte','Bartoletti','26','Design of concrete Structures',1),('6605236','Magnus','Dibbert','26','Design of concrete Structures',1),('8005225','Alek','Streich','26','Design of concrete Structures',1),('6581486','Milford','Fay','26','Design of concrete Structures',2),('8392592','Evert','Friesen','26','Design of concrete Structures',2),('8005225','Alek','Streich','27','Soil Mechanics',3),('3487297','Stacy','McLaughlin','27','Soil Mechanics',4),('6605236','Magnus','Dibbert','27','Soil Mechanics',4),('7868325','Berta','Auer','27','Soil Mechanics',4),('1456827','Monserrate','Donnelly','28','Environmental Science',2),('3363152','Queen','Sawayn','28','Environmental Science',2),('4124507','Gerard','Hahn','28','Environmental Science',2),('3363152','Queen','Sawayn','29','Design of steel Structures',4),('5209857','Lue','Jenkins','29','Design of steel Structures',4),('5878911','Vada','Dare','3','Deep Learning',2),('8813103','Soledad','Dietrich','3','Deep Learning',2),('1830038','Briana','Pouros','30','Transportation Engg.',2),('6488326','Rene','Wintheiser','30','Transportation Engg.',2),('119385','Kelsi','Bahringer','30','Transportation Engg.',4),('4146108','Brant','Rippin','30','Transportation Engg.',4),('1122938','Kaleb','Wunsch','31','Digital Logic Design',1),('2323349','Roxane','Treutel','32','Engineering Electronics 1',2),('7700462','Jessika','Terry','32','Engineering Electronics 1',2),('1122938','Kaleb','Wunsch','33','Basic Electronic Circuits',2),('577128','Howell','VonRueden','33','Basic Electronic Circuits',2),('6127813','Carmine','Muller','34','Linear Electronic Circuits',1),('1483094','Mckayla','Marks','34','Linear Electronic Circuits',4),('187456','Khalil','Swift','34','Linear Electronic Circuits',4),('4038360','Angus','Welch','34','Linear Electronic Circuits',4),('119385','Kelsi','Bahringer','36','Semiconductor Processing',3),('2675321','Julie','Bergstrom','36','Semiconductor Processing',3),('2243042','Tina','Hudson','37','Lasers & Photonics',3),('9003709','Wilburn','Kirlin','37','Lasers & Photonics',3),('7700462','Jessika','Terry','38','Microelectronics',1),('108305','Derick','Herzog','38','Microelectronics',3),('3894755','Willow','Kovacek','38','Microelectronics',3),('4038360','Angus','Welch','38','Microelectronics',3),('5286705','Aida','Lemke','38','Microelectronics',3),('5357196','Bernardo','Ledner','38','Microelectronics',4),('187456','Khalil','Swift','39','Bioelectrics',2),('2166740','Garnet','Bode','39','Bioelectrics',2),('3211500','Eileen','Rowe','39','Bioelectrics',2),('8813103','Soledad','Dietrich','4','Analysis of Algorithms 1',2),('3894755','Willow','Kovacek','40','Optical Communications',2),('5544611','Davonte','Bartoletti','40','Optical Communications',2),('6127813','Carmine','Muller','40','Optical Communications',2),('1226675','Guiseppe','Trantow','41','Linear Algebra',1),('3353909','Carson','Huel','41','Linear Algebra',1),('3487297','Stacy','McLaughlin','41','Linear Algebra',1),('834354','Ova','Upton','41','Linear Algebra',1),('8006202','Reymundo','Glover','42','Calculus 1',1),('8006202','Reymundo','Glover','43','Calculus 2',1),('810465','Jordane','Watsica','43','Calculus 2',1),('1226675','Guiseppe','Trantow','44','Probability Theory & Statistics',2),('3110237','Ruthie','Goldner','46','Number Theory in Cryptography',2),('3353909','Carson','Huel','46','Number Theory in Cryptography',2),('4120205','Michele','Sauer','46','Number Theory in Cryptography',2),('6168118','Kasandra','Jacobi','46','Number Theory in Cryptography',2),('834354','Ova','Upton','46','Number Theory in Cryptography',2),('2003939','Simone','Lubowitz','47','Abstract Algebra',1),('5279488','Janice','Waters','47','Abstract Algebra',1),('7868325','Berta','Auer','47','Abstract Algebra',1),('3211500','Eileen','Rowe','48','Mathematics 1',1),('5878911','Vada','Dare','5','Analysis of Algorithms 2',2),('2243042','Tina','Hudson','50','Fourier & Laplace Transforms',2),('3842048','Carlie','Kerluke','50','Fourier & Laplace Transforms',2),('2003939','Simone','Lubowitz','51','General Chemistry for Engineers',1),('2724427','Abdullah','Gerlach','51','General Chemistry for Engineers',1),('249892','Melyna','Rolfson','52','University Physics',2),('2952864','Jorge','Cummerata','52','University Physics',2),('3901455','Athena','Conroy','52','University Physics',3),('7891745','Allan','Lang','53','Electromagnetic Field Theory',1),('8392592','Evert','Friesen','53','Electromagnetic Field Theory',1),('2399880','Esperanza','Fahey','54','Intro to Quantum Optics',3),('7097159','Marianna','Lebsack','54','Intro to Quantum Optics',3),('2952864','Jorge','Cummerata','55','Quantum Mechanics',4),('6230579','Mittie','Medhurst','55','Quantum Mechanics',4),('8006814','Nichole','Tillman','55','Quantum Mechanics',4),('7097159','Marianna','Lebsack','56','Semiconductor Physics',3),('2214635','Fannie','Marquardt','57','Electricity, Magnetism, and Waves',2),('108305','Derick','Herzog','58','Mathematical Methods for Physics',2),('7157161','Hayley','Homenick','58','Mathematical Methods for Physics',2),('8006814','Nichole','Tillman','58','Mathematical Methods for Physics',2),('7297006','Shane','Metz','59','Thermodynamics and Kinetic Theory',2),('249892','Melyna','Rolfson','59','Thermodynamics and Kinetic Theory',3),('2399880','Esperanza','Fahey','6','Advanced Machine Learning',2),('7157161','Hayley','Homenick','60','Foundations of Modern Physics',4),('8348742','Zackery','Paucek','61','History of Black Magic',1),('9064924','Telly','Moore','61','History of Black Magic',1),('4120205','Michele','Sauer','62','Chemistry for black magic',1),('8348742','Zackery','Paucek','62','Chemistry for black magic',1),('1483094','Mckayla','Marks','63','Computational Black Magic',1),('350835','Aditya','Stokes','63','Computational Black Magic',1),('810465','Jordane','Watsica','63','Computational Black Magic',2),('5194621','Carrie','Ullrich','64','Black Magic lab 1',1),('7297006','Shane','Metz','64','Black Magic lab 1',2),('3110237','Ruthie','Goldner','65','Practical Applications of black magic',1),('5194621','Carrie','Ullrich','65','Practical Applications of black magic',1),('1456827','Monserrate','Donnelly','65','Practical Applications of black magic',2),('6518392','Pietro','Cole','65','Practical Applications of black magic',2),('2323349','Roxane','Treutel','66','Acing interviews with black magic',1),('2348464','Lou','Mayer','68','Ethical Concerns associated with black magic',2),('5286705','Aida','Lemke','68','Ethical Concerns associated with black magic',2),('6518392','Pietro','Cole','68','Ethical Concerns associated with black magic',2),('6581486','Milford','Fay','69','Gray Hat and White hat practitioners',2),('1046236','Emmanuelle','Champlin','7','Bayesian Models',2),('3058253','Angeline','Predovic','7','Bayesian Models',2),('3218640','Jermey','Willms','7','Bayesian Models',2),('2348464','Lou','Mayer','70','Solving NP-Hard problems with black magic',1),('2689948','Viva','Douglas','70','Solving NP-Hard problems with black magic',1),('350835','Aditya','Stokes','70','Solving NP-Hard problems with black magic',1),('4291180','Cynthia','Sanford','70','Solving NP-Hard problems with black magic',1),('6426769','Haley','Kunde','70','Solving NP-Hard problems with black magic',1),('3218640','Jermey','Willms','8','Data Structures',1),('6426769','Haley','Kunde','8','Data Structures',1),('5357196','Bernardo','Ledner','9','Graphics & Animation',1),('6312014','Wiley','Daniel','9','Graphics & Animation',1);
/*!40000 ALTER TABLE `Has_enrolled_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Headed_by`
--

DROP TABLE IF EXISTS `Headed_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Headed_by` (
  `FacultyID` varchar(50) NOT NULL,
  `FacultyFName` varchar(45) NOT NULL,
  `FacultyLName` varchar(45) NOT NULL,
  `DeptID` int(8) NOT NULL,
  `DeptName` varchar(20) NOT NULL,
  PRIMARY KEY (`FacultyID`,`FacultyFName`,`FacultyLName`,`DeptID`,`DeptName`),
  KEY `fk_Headed_by_idx_1` (`FacultyID`,`FacultyFName`,`FacultyLName`),
  KEY `fk_Headed_by_Department1_idx` (`DeptID`,`DeptName`),
  CONSTRAINT `fk_Headed_by_2` FOREIGN KEY (`FacultyID`, `FacultyFName`, `FacultyLName`) REFERENCES `Faculty` (`FacultyID`, `FirstName`, `LastName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Headed_by_Department1` FOREIGN KEY (`DeptID`, `DeptName`) REFERENCES `Department` (`ID`, `Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Headed_by`
--

LOCK TABLES `Headed_by` WRITE;
/*!40000 ALTER TABLE `Headed_by` DISABLE KEYS */;
INSERT INTO `Headed_by` VALUES ('4547617','Elmore','Gislason',0,''),('4701832','Mina','Crona',0,''),('4773645','Carmen','Yundt',0,''),('5147071','Tomas','Pollich',0,''),('9538638','Rodolfo','Stracke',0,''),('974054','Zoie','Mohr',0,''),('978516','Katelynn','Wisozk',0,'');
/*!40000 ALTER TABLE `Headed_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Offered_by`
--

DROP TABLE IF EXISTS `Offered_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Offered_by` (
  `DeptID` int(8) NOT NULL,
  `DeptName` varchar(20) NOT NULL,
  `CourseID` varchar(20) NOT NULL,
  `CourseName` varchar(50) NOT NULL,
  PRIMARY KEY (`DeptID`,`DeptName`,`CourseID`,`CourseName`),
  KEY `fk_Offered_by_idx_1` (`DeptID`,`DeptName`),
  KEY `fk_Offered_by_idx_2` (`CourseID`,`CourseName`),
  CONSTRAINT `fk_Offered_by_1` FOREIGN KEY (`CourseID`, `CourseName`) REFERENCES `Course` (`CourseID`, `FullName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Offered_by_2` FOREIGN KEY (`DeptID`, `DeptName`) REFERENCES `Department` (`ID`, `Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Offered_by`
--

LOCK TABLES `Offered_by` WRITE;
/*!40000 ALTER TABLE `Offered_by` DISABLE KEYS */;
INSERT INTO `Offered_by` VALUES (1,'Computer Science','1','Intro to DBMS'),(1,'Computer Science','10','Principles of Network Security'),(1,'Computer Science','2','Machine Learning'),(1,'Computer Science','3','Deep Learning'),(1,'Computer Science','4','Analysis of Algorithms 1'),(1,'Computer Science','5','Analysis of Algorithms 2'),(1,'Computer Science','6','Advanced Machine Learning'),(1,'Computer Science','7','Bayesian Models'),(1,'Computer Science','8','Data Structures'),(1,'Computer Science','9','Graphics & Animation'),(2,'Electrical Science','11','Basic Electrical Science'),(2,'Electrical Science','12','Analog Circuits'),(2,'Electrical Science','13','Embedded Hardware Design'),(2,'Electrical Science','14','Signals & Systems'),(2,'Electrical Science','15','Wireless Communications'),(2,'Electrical Science','16','Communication Theory'),(2,'Electrical Science','17','Communication Networks'),(2,'Electrical Science','18','Error Correcting Codes'),(2,'Electrical Science','19','Computational Electromagnetics'),(2,'Electrical Science','20','Analog & mixed signal design'),(3,'Electronics','31','Digital Logic Design'),(3,'Electronics','32','Engineering Electronics 1'),(3,'Electronics','33','Basic Electronic Circuits'),(3,'Electronics','34','Linear Electronic Circuits'),(3,'Electronics','35','Digital Integrated Circuits'),(3,'Electronics','36','Semiconductor Processing'),(3,'Electronics','37','Lasers & Photonics'),(3,'Electronics','38','Microelectronics'),(3,'Electronics','39','Bioelectrics'),(3,'Electronics','40','Optical Communications'),(4,'Building Science','21','Building materials & construction'),(4,'Building Science','22','Mechanics of Solids'),(4,'Building Science','23','Structural Analysis'),(4,'Building Science','24','Strength of materials'),(4,'Building Science','25','Water Resource Engg.'),(4,'Building Science','26','Design of concrete Structures'),(4,'Building Science','27','Soil Mechanics'),(4,'Building Science','28','Environmental Science'),(4,'Building Science','29','Design of steel Structures'),(4,'Building Science','30','Transportation Engg.'),(5,'Natural Sciences','51','General Chemistry for Engineers'),(5,'Natural Sciences','52','University Physics'),(5,'Natural Sciences','53','Electromagnetic Field Theory'),(5,'Natural Sciences','54','Intro to Quantum Optics'),(5,'Natural Sciences','55','Quantum Mechanics'),(5,'Natural Sciences','56','Semiconductor Physics'),(5,'Natural Sciences','57','Electricity, Magnetism, and Waves'),(5,'Natural Sciences','58','Mathematical Methods for Physics'),(5,'Natural Sciences','59','Thermodynamics and Kinetic Theory'),(5,'Natural Sciences','60','Foundations of Modern Physics'),(6,'Mathematics','41','Linear Algebra'),(6,'Mathematics','42','Calculus 1'),(6,'Mathematics','43','Calculus 2'),(6,'Mathematics','44','Probability Theory & Statistics'),(6,'Mathematics','45','Differential Equations'),(6,'Mathematics','46','Number Theory in Cryptography'),(6,'Mathematics','47','Abstract Algebra'),(6,'Mathematics','48','Mathematics 1'),(6,'Mathematics','49','Complex Numbers'),(6,'Mathematics','50','Fourier & Laplace Transforms'),(7,'Black Magic','61','History of Black Magic'),(7,'Black Magic','62','Chemistry for black magic'),(7,'Black Magic','63','Computational Black Magic'),(7,'Black Magic','64','Black Magic lab 1'),(7,'Black Magic','65','Practical Applications of black magic'),(7,'Black Magic','66','Acing interviews with black magic'),(7,'Black Magic','67','Case study - How google search uses black magic'),(7,'Black Magic','68','Ethical Concerns associated with black magic'),(7,'Black Magic','69','Gray Hat and White hat practitioners'),(7,'Black Magic','70','Solving NP-Hard problems with black magic');
/*!40000 ALTER TABLE `Offered_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prerequisite`
--

DROP TABLE IF EXISTS `Prerequisite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prerequisite` (
  `CourseID` varchar(20) NOT NULL,
  `CourseName` varchar(50) NOT NULL,
  `PrereqCourseID` varchar(45) NOT NULL,
  `PrereqCourseName` varchar(50) NOT NULL,
  PRIMARY KEY (`CourseID`,`CourseName`,`PrereqCourseID`,`PrereqCourseName`),
  KEY `fk_Prerequisite_idx_1` (`PrereqCourseID`,`PrereqCourseName`),
  KEY `fk_Prerequisite_idx_2` (`CourseID`,`CourseName`),
  CONSTRAINT `fk_Prerequisite_1` FOREIGN KEY (`CourseID`, `CourseName`) REFERENCES `Course` (`CourseID`, `FullName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prerequisite_2` FOREIGN KEY (`PrereqCourseID`, `PrereqCourseName`) REFERENCES `Course` (`CourseID`, `FullName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prerequisite`
--

LOCK TABLES `Prerequisite` WRITE;
/*!40000 ALTER TABLE `Prerequisite` DISABLE KEYS */;
INSERT INTO `Prerequisite` VALUES ('1','Intro to DBMS','9','Graphics & Animation'),('11','Basic Electrical Science','13','Embedded Hardware Design'),('12','Analog Circuits','17','Communication Networks'),('13','Embedded Hardware Design','14','Signals & Systems'),('13','Embedded Hardware Design','19','Computational Electromagnetics'),('14','Signals & Systems','11','Basic Electrical Science'),('14','Signals & Systems','15','Wireless Communications'),('16','Communication Theory','17','Communication Networks'),('18','Error Correcting Codes','16','Communication Theory'),('19','Computational Electromagnetics','17','Communication Networks'),('2','Machine Learning','4','Analysis of Algorithms 1'),('21','Building materials & construction','26','Design of concrete Structures'),('21','Building materials & construction','27','Soil Mechanics'),('21','Building materials & construction','28','Environmental Science'),('22','Mechanics of Solids','21','Building materials & construction'),('22','Mechanics of Solids','25','Water Resource Engg.'),('23','Structural Analysis','21','Building materials & construction'),('27','Soil Mechanics','28','Environmental Science'),('29','Design of steel Structures','22','Mechanics of Solids'),('3','Deep Learning','6','Advanced Machine Learning'),('32','Engineering Electronics 1','37','Lasers & Photonics'),('33','Basic Electronic Circuits','34','Linear Electronic Circuits'),('33','Basic Electronic Circuits','37','Lasers & Photonics'),('34','Linear Electronic Circuits','31','Digital Logic Design'),('35','Digital Integrated Circuits','39','Bioelectrics'),('38','Microelectronics','35','Digital Integrated Circuits'),('39','Bioelectrics','32','Engineering Electronics 1'),('39','Bioelectrics','38','Microelectronics'),('43','Calculus 2','48','Mathematics 1'),('44','Probability Theory & Statistics','42','Calculus 1'),('46','Number Theory in Cryptography','44','Probability Theory & Statistics'),('47','Abstract Algebra','41','Linear Algebra'),('47','Abstract Algebra','42','Calculus 1'),('47','Abstract Algebra','49','Complex Numbers'),('48','Mathematics 1','47','Abstract Algebra'),('49','Complex Numbers','43','Calculus 2'),('5','Analysis of Algorithms 2','2','Machine Learning'),('52','University Physics','51','General Chemistry for Engineers'),('52','University Physics','57','Electricity, Magnetism, and Waves'),('53','Electromagnetic Field Theory','59','Thermodynamics and Kinetic Theory'),('57','Electricity, Magnetism, and Waves','53','Electromagnetic Field Theory'),('57','Electricity, Magnetism, and Waves','59','Thermodynamics and Kinetic Theory'),('58','Mathematical Methods for Physics','53','Electromagnetic Field Theory'),('6','Advanced Machine Learning','1','Intro to DBMS'),('6','Advanced Machine Learning','2','Machine Learning'),('6','Advanced Machine Learning','4','Analysis of Algorithms 1'),('6','Advanced Machine Learning','9','Graphics & Animation'),('63','Computational Black Magic','61','History of Black Magic'),('63','Computational Black Magic','68','Ethical Concerns associated with black magic'),('65','Practical Applications of black magic','63','Computational Black Magic'),('68','Ethical Concerns associated with black magic','64','Black Magic lab 1'),('69','Gray Hat and White hat practitioners','63','Computational Black Magic'),('69','Gray Hat and White hat practitioners','65','Practical Applications of black magic');
/*!40000 ALTER TABLE `Prerequisite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sections`
--

DROP TABLE IF EXISTS `Sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sections` (
  `CourseID` varchar(20) NOT NULL,
  `CourseName` varchar(50) NOT NULL,
  `SectionNumber` int(5) NOT NULL,
  `FacultyID` varchar(50) NOT NULL,
  `InstructorFName` varchar(45) NOT NULL,
  `InstructorLName` varchar(45) NOT NULL,
  PRIMARY KEY (`CourseID`,`CourseName`,`SectionNumber`,`FacultyID`,`InstructorFName`,`InstructorLName`),
  KEY `fk_Sections_idx_1` (`FacultyID`,`InstructorFName`,`InstructorLName`),
  KEY `fk_Section_idx_2` (`CourseID`,`CourseName`),
  CONSTRAINT `fk_Sections_1` FOREIGN KEY (`CourseID`, `CourseName`) REFERENCES `Course` (`CourseID`, `FullName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sections_2` FOREIGN KEY (`FacultyID`, `InstructorFName`, `InstructorLName`) REFERENCES `Faculty` (`FacultyID`, `FirstName`, `LastName`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sections`
--

LOCK TABLES `Sections` WRITE;
/*!40000 ALTER TABLE `Sections` DISABLE KEYS */;
INSERT INTO `Sections` VALUES ('1','Intro to DBMS',1,'4773645','Carmen','Yundt'),('10','Principles of Network Security',1,'4773645','Carmen','Yundt'),('10','Principles of Network Security',2,'9744898','Hailee','Walsh'),('11','Basic Electrical Science',1,'4547617','Elmore','Gislason'),('12','Analog Circuits',2,'9367129','Paula','Nikolaus'),('13','Embedded Hardware Design',1,'4547617','Elmore','Gislason'),('13','Embedded Hardware Design',2,'9367129','Paula','Nikolaus'),('14','Signals & Systems',1,'4547617','Elmore','Gislason'),('14','Signals & Systems',2,'9367129','Paula','Nikolaus'),('15','Wireless Communications',2,'9367129','Paula','Nikolaus'),('16','Communication Theory',2,'9367129','Paula','Nikolaus'),('17','Communication Networks',2,'9367129','Paula','Nikolaus'),('18','Error Correcting Codes',1,'4547617','Elmore','Gislason'),('19','Computational Electromagnetics',1,'4547617','Elmore','Gislason'),('2','Machine Learning',1,'4773645','Carmen','Yundt'),('2','Machine Learning',2,'9744898','Hailee','Walsh'),('20','Analog & mixed signal design',2,'9367129','Paula','Nikolaus'),('21','Building materials & construction',3,'9211397','Marcelle','Bruen'),('22','Mechanics of Solids',2,'4452493','Herman','Monahan'),('22','Mechanics of Solids',4,'978516','Katelynn','Wisozk'),('23','Structural Analysis',1,'4416925','Petra','Windler'),('24','Strength of materials',2,'4452493','Herman','Monahan'),('24','Strength of materials',3,'9211397','Marcelle','Bruen'),('25','Water Resource Engg.',1,'4416925','Petra','Windler'),('25','Water Resource Engg.',4,'978516','Katelynn','Wisozk'),('26','Design of concrete Structures',1,'4416925','Petra','Windler'),('26','Design of concrete Structures',2,'4452493','Herman','Monahan'),('27','Soil Mechanics',3,'9211397','Marcelle','Bruen'),('27','Soil Mechanics',4,'978516','Katelynn','Wisozk'),('28','Environmental Science',2,'4452493','Herman','Monahan'),('29','Design of steel Structures',3,'9211397','Marcelle','Bruen'),('29','Design of steel Structures',4,'978516','Katelynn','Wisozk'),('3','Deep Learning',2,'9744898','Hailee','Walsh'),('30','Transportation Engg.',2,'4452493','Herman','Monahan'),('30','Transportation Engg.',4,'978516','Katelynn','Wisozk'),('31','Digital Logic Design',1,'4387189','Velva','Greenfelder'),('31','Digital Logic Design',3,'974054','Zoie','Mohr'),('32','Engineering Electronics 1',2,'9460352','Toby','Ratke'),('33','Basic Electronic Circuits',2,'9460352','Toby','Ratke'),('33','Basic Electronic Circuits',3,'974054','Zoie','Mohr'),('34','Linear Electronic Circuits',1,'4387189','Velva','Greenfelder'),('34','Linear Electronic Circuits',3,'974054','Zoie','Mohr'),('34','Linear Electronic Circuits',4,'9936696','Paxton','Spencer'),('35','Digital Integrated Circuits',1,'4387189','Velva','Greenfelder'),('35','Digital Integrated Circuits',2,'9460352','Toby','Ratke'),('36','Semiconductor Processing',3,'974054','Zoie','Mohr'),('37','Lasers & Photonics',3,'974054','Zoie','Mohr'),('38','Microelectronics',1,'4387189','Velva','Greenfelder'),('38','Microelectronics',3,'974054','Zoie','Mohr'),('38','Microelectronics',4,'9936696','Paxton','Spencer'),('39','Bioelectrics',2,'9460352','Toby','Ratke'),('4','Analysis of Algorithms 1',2,'9744898','Hailee','Walsh'),('40','Optical Communications',2,'9460352','Toby','Ratke'),('41','Linear Algebra',1,'4383597','Dominic','Jones'),('42','Calculus 1',1,'4383597','Dominic','Jones'),('43','Calculus 2',1,'4383597','Dominic','Jones'),('43','Calculus 2',2,'5147071','Tomas','Pollich'),('44','Probability Theory & Statistics',1,'4383597','Dominic','Jones'),('44','Probability Theory & Statistics',2,'5147071','Tomas','Pollich'),('45','Differential Equations',1,'4383597','Dominic','Jones'),('46','Number Theory in Cryptography',2,'5147071','Tomas','Pollich'),('47','Abstract Algebra',1,'4383597','Dominic','Jones'),('48','Mathematics 1',1,'4383597','Dominic','Jones'),('49','Complex Numbers',1,'4383597','Dominic','Jones'),('5','Analysis of Algorithms 2',2,'9744898','Hailee','Walsh'),('50','Fourier & Laplace Transforms',2,'5147071','Tomas','Pollich'),('51','General Chemistry for Engineers',1,'5121001','Robert','OKon'),('52','University Physics',2,'9334741','Alisha','Jacobs'),('52','University Physics',3,'9429138','Zoila','Maggio'),('53','Electromagnetic Field Theory',1,'5121001','Robert','OKon'),('53','Electromagnetic Field Theory',2,'9334741','Alisha','Jacobs'),('53','Electromagnetic Field Theory',3,'9429138','Zoila','Maggio'),('54','Intro to Quantum Optics',1,'5121001','Robert','OKon'),('54','Intro to Quantum Optics',3,'9429138','Zoila','Maggio'),('55','Quantum Mechanics',4,'9538638','Rodolfo','Stracke'),('56','Semiconductor Physics',3,'9429138','Zoila','Maggio'),('56','Semiconductor Physics',4,'9538638','Rodolfo','Stracke'),('57','Electricity, Magnetism, and Waves',2,'9334741','Alisha','Jacobs'),('58','Mathematical Methods for Physics',2,'9334741','Alisha','Jacobs'),('59','Thermodynamics and Kinetic Theory',1,'5121001','Robert','OKon'),('59','Thermodynamics and Kinetic Theory',2,'9334741','Alisha','Jacobs'),('59','Thermodynamics and Kinetic Theory',3,'9429138','Zoila','Maggio'),('6','Advanced Machine Learning',2,'9744898','Hailee','Walsh'),('60','Foundations of Modern Physics',2,'9334741','Alisha','Jacobs'),('60','Foundations of Modern Physics',3,'9429138','Zoila','Maggio'),('60','Foundations of Modern Physics',4,'9538638','Rodolfo','Stracke'),('61','History of Black Magic',1,'4498251','Meredith','Kling'),('61','History of Black Magic',2,'4701832','Mina','Crona'),('62','Chemistry for black magic',1,'4498251','Meredith','Kling'),('63','Computational Black Magic',1,'4498251','Meredith','Kling'),('63','Computational Black Magic',2,'4701832','Mina','Crona'),('64','Black Magic lab 1',1,'4498251','Meredith','Kling'),('64','Black Magic lab 1',2,'4701832','Mina','Crona'),('65','Practical Applications of black magic',1,'4498251','Meredith','Kling'),('65','Practical Applications of black magic',2,'4701832','Mina','Crona'),('66','Acing interviews with black magic',1,'4498251','Meredith','Kling'),('66','Acing interviews with black magic',2,'4701832','Mina','Crona'),('67','Case study - How google search uses black magic',1,'4498251','Meredith','Kling'),('67','Case study - How google search uses black magic',2,'4701832','Mina','Crona'),('68','Ethical Concerns associated with black magic',2,'4701832','Mina','Crona'),('69','Gray Hat and White hat practitioners',2,'4701832','Mina','Crona'),('7','Bayesian Models',2,'9744898','Hailee','Walsh'),('70','Solving NP-Hard problems with black magic',1,'4498251','Meredith','Kling'),('8','Data Structures',1,'4773645','Carmen','Yundt'),('8','Data Structures',2,'9744898','Hailee','Walsh'),('9','Graphics & Animation',1,'4773645','Carmen','Yundt');
/*!40000 ALTER TABLE `Sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Serves_in`
--

DROP TABLE IF EXISTS `Serves_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Serves_in` (
  `DeptID` int(8) NOT NULL,
  `DeptName` varchar(45) NOT NULL,
  `FacultyID` varchar(50) NOT NULL,
  `FacultyFName` varchar(45) NOT NULL,
  `FacultyLName` varchar(45) NOT NULL,
  `Designation` varchar(45) NOT NULL,
  PRIMARY KEY (`DeptID`,`DeptName`,`FacultyID`,`FacultyFName`,`FacultyLName`,`Designation`),
  KEY `fk_Serves_in_idx_1` (`FacultyID`,`FacultyFName`,`FacultyLName`),
  KEY `fk_Serves_in_idx_2` (`DeptID`,`DeptName`),
  CONSTRAINT `fk_Serves_in_1` FOREIGN KEY (`FacultyID`, `FacultyFName`, `FacultyLName`) REFERENCES `Faculty` (`FacultyID`, `FirstName`, `LastName`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Serves_in_2` FOREIGN KEY (`DeptID`, `DeptName`) REFERENCES `Department` (`ID`, `Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Serves_in`
--

LOCK TABLES `Serves_in` WRITE;
/*!40000 ALTER TABLE `Serves_in` DISABLE KEYS */;
/*!40000 ALTER TABLE `Serves_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Student` (
  `StudentID` varchar(50) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `EmailID` varchar(45) NOT NULL,
  `Gender` char(1) NOT NULL,
  `DOB` date NOT NULL,
  `DeptID` int(8) NOT NULL,
  `DeptName` varchar(20) NOT NULL,
  PRIMARY KEY (`StudentID`,`FirstName`,`LastName`,`DeptID`,`DeptName`),
  KEY `fk_idx_1` (`DeptID`,`DeptName`),
  CONSTRAINT `fk_Student_1` FOREIGN KEY (`DeptID`, `DeptName`) REFERENCES `Department` (`ID`, `Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES ('1046236','Emmanuelle','Champlin','reilly.swaniawski@example.com','F','2001-08-06',4,'Building Science'),('108305','Derick','Herzog','xgrant@example.org','F','2005-05-25',5,'Natural Sciences'),('1122938','Kaleb','Wunsch','thompson.jadyn@example.com','M','1972-09-11',3,'Electronics'),('119385','Kelsi','Bahringer','jamar80@example.org','M','2011-10-26',4,'Building Science'),('1226675','Guiseppe','Trantow','shields.randal@example.net','F','1999-10-07',6,'Mathematics'),('1456827','Monserrate','Donnelly','adolphus66@example.net','F','1993-03-06',4,'Building Science'),('1483094','Mckayla','Marks','srunolfsson@example.org','F','2014-06-27',3,'Electronics'),('1830038','Briana','Pouros','rolfson.louvenia@example.org','F','1970-07-08',4,'Building Science'),('187456','Khalil','Swift','wisozk.mandy@example.net','F','1973-10-21',3,'Electronics'),('2003939','Simone','Lubowitz','mario.satterfield@example.com','F','1971-01-28',6,'Mathematics'),('2166740','Garnet','Bode','fritsch.broderick@example.org','F','1970-07-07',1,'Computer Science'),('2214635','Fannie','Marquardt','eino.skiles@example.com','F','1980-04-01',1,'Computer Science'),('2243042','Tina','Hudson','kohler.regan@example.com','M','1986-11-20',3,'Electronics'),('2323349','Roxane','Treutel','sean.kautzer@example.org','M','1973-03-21',7,'Black Magic'),('2348464','Lou','Mayer','hermiston.mohammed@example.org','M','1978-12-17',7,'Black Magic'),('2399880','Esperanza','Fahey','kheaney@example.com','F','1987-02-06',1,'Computer Science'),('249892','Melyna','Rolfson','rath.robert@example.net','M','2012-03-21',5,'Natural Sciences'),('2519995','Tiara','Mitchell','fmorar@example.com','F','1997-07-23',2,'Electrical Science'),('2675321','Julie','Bergstrom','rdietrich@example.com','M','1972-03-30',3,'Electronics'),('2689948','Viva','Douglas','rbins@example.net','M','1993-12-07',2,'Electrical Science'),('2724427','Abdullah','Gerlach','greyson73@example.com','M','1978-04-13',1,'Computer Science'),('2843927','Madisen','Grimes','libbie08@example.com','M','1986-12-08',2,'Electrical Science'),('2952864','Jorge','Cummerata','annalise.nicolas@example.org','F','1996-05-09',5,'Natural Sciences'),('3058253','Angeline','Predovic','josh12@example.net','F','2015-11-27',1,'Computer Science'),('3110237','Ruthie','Goldner','otilia79@example.org','F','1980-06-04',6,'Mathematics'),('3211500','Eileen','Rowe','pollich.vaughn@example.net','M','1998-05-10',6,'Mathematics'),('3218640','Jermey','Willms','hollis.kub@example.com','F','1998-12-23',1,'Computer Science'),('3353909','Carson','Huel','waelchi.mitchel@example.net','M','2013-12-24',6,'Mathematics'),('3363152','Queen','Sawayn','nmacejkovic@example.net','F','1995-10-01',4,'Building Science'),('3487297','Stacy','McLaughlin','richard90@example.com','F','2005-11-16',4,'Building Science'),('350835','Aditya','Stokes','lkoch@example.org','F','2011-02-02',7,'Black Magic'),('3635025','Raheem','Rogahn','issac.mcglynn@example.org','F','1971-05-03',2,'Electrical Science'),('3842048','Carlie','Kerluke','sawayn.einar@example.org','M','2008-08-02',4,'Building Science'),('3894755','Willow','Kovacek','xleannon@example.com','F','2003-07-01',3,'Electronics'),('3901455','Athena','Conroy','morris65@example.org','M','2007-10-09',4,'Building Science'),('4038360','Angus','Welch','jaquelin93@example.com','F','1970-12-20',3,'Electronics'),('4120205','Michele','Sauer','howard74@example.net','F','1991-08-15',6,'Mathematics'),('4124507','Gerard','Hahn','austin.wolff@example.net','M','1970-08-14',4,'Building Science'),('4146108','Brant','Rippin','marquardt.imani@example.org','M','1995-10-23',4,'Building Science'),('4291180','Cynthia','Sanford','keara.schmeler@example.net','F','2011-02-03',4,'Building Science'),('5194621','Carrie','Ullrich','cleora.dietrich@example.com','F','2008-05-17',7,'Black Magic'),('5209857','Lue','Jenkins','ena.hegmann@example.net','F','2017-06-09',4,'Building Science'),('5279488','Janice','Waters','spencer78@example.com','F','2005-11-14',6,'Mathematics'),('5286705','Aida','Lemke','sonia08@example.org','F','2014-03-07',3,'Electronics'),('5357196','Bernardo','Ledner','daisy67@example.com','F','1980-10-26',1,'Computer Science'),('5544611','Davonte','Bartoletti','rodriguez.elbert@example.net','F','1988-12-02',4,'Building Science'),('577128','Howell','VonRueden','rosalia.watsica@example.org','M','1987-07-18',4,'Building Science'),('5878911','Vada','Dare','melissa31@example.net','F','1997-01-14',1,'Computer Science'),('6127813','Carmine','Muller','agleichner@example.org','F','2003-05-18',3,'Electronics'),('6168118','Kasandra','Jacobi','nona54@example.org','M','1976-11-16',6,'Mathematics'),('6230579','Mittie','Medhurst','ametz@example.net','M','1974-06-26',5,'Natural Sciences'),('6312014','Wiley','Daniel','torrance30@example.org','M','1998-01-31',2,'Electrical Science'),('6390411','Teagan','Morar','mckenzie.bradford@example.com','F','1995-03-06',2,'Electrical Science'),('63991','Kobe','Baumbach','hdare@example.org','M','2015-01-16',4,'Building Science'),('6426769','Haley','Kunde','marlee.kautzer@example.com','M','2001-08-03',7,'Black Magic'),('6488326','Rene','Wintheiser','mariela.mcglynn@example.com','M','1981-04-15',4,'Building Science'),('6518392','Pietro','Cole','lyla53@example.net','F','1981-02-20',7,'Black Magic'),('6547859','Bruce','Thompson','roel.koelpin@example.net','M','2016-06-10',2,'Electrical Science'),('6573643','Kitty','Blanda','rmuller@example.org','F','1987-02-26',2,'Electrical Science'),('6581486','Milford','Fay','purdy.emmanuel@example.org','F','1995-01-06',7,'Black Magic'),('6605236','Magnus','Dibbert','enid.mohr@example.net','F','1973-12-08',4,'Building Science'),('7048760','Hector','Bauch','bette92@example.com','M','1976-02-29',2,'Electrical Science'),('7097159','Marianna','Lebsack','ratke.michale@example.org','M','1992-11-30',5,'Natural Sciences'),('7157161','Hayley','Homenick','joshua62@example.org','F','1988-10-13',5,'Natural Sciences'),('7297006','Shane','Metz','dana.jaskolski@example.com','F','1981-11-24',5,'Natural Sciences'),('7700462','Jessika','Terry','laurence.cronin@example.com','F','1992-04-08',3,'Electronics'),('786717','Effie','Quitzon','zkreiger@example.org','F','2003-03-31',2,'Electrical Science'),('7868325','Berta','Auer','michael.bins@example.org','F','1990-04-18',4,'Building Science'),('7891745','Allan','Lang','sawayn.leola@example.org','M','1988-02-29',5,'Natural Sciences'),('8005225','Alek','Streich','doyle.edythe@example.net','M','1996-12-25',4,'Building Science'),('8006202','Reymundo','Glover','eulalia.witting@example.org','F','2015-12-11',6,'Mathematics'),('8006814','Nichole','Tillman','jermaine94@example.net','F','1973-03-19',5,'Natural Sciences'),('810465','Jordane','Watsica','mlowe@example.net','F','1974-06-21',7,'Black Magic'),('834354','Ova','Upton','ole.kihn@example.com','M','2005-01-13',6,'Mathematics'),('8348742','Zackery','Paucek','yhackett@example.net','F','1974-09-10',7,'Black Magic'),('8392592','Evert','Friesen','hellen16@example.net','F','2010-10-15',5,'Natural Sciences'),('8813103','Soledad','Dietrich','phansen@example.com','F','1990-01-14',1,'Computer Science'),('8933058','Rocky','Hills','ephraim88@example.org','F','1974-09-29',4,'Building Science'),('9003709','Wilburn','Kirlin','cauer@example.org','M','1979-12-08',1,'Computer Science'),('9064924','Telly','Moore','zboncak.marion@example.net','F','1977-12-28',7,'Black Magic');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-28 19:25:02
