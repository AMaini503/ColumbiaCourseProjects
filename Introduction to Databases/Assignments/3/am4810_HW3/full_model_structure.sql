-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: hw3
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
-- Temporary view structure for view `CoursesTaken`
--

DROP TABLE IF EXISTS `CoursesTaken`;
/*!50001 DROP VIEW IF EXISTS `CoursesTaken`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `CoursesTaken` AS SELECT 
 1 AS `UNI`,
 1 AS `course_id`,
 1 AS `year`,
 1 AS `semester`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `CoursesTaught`
--

DROP TABLE IF EXISTS `CoursesTaught`;
/*!50001 DROP VIEW IF EXISTS `CoursesTaught`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `CoursesTaught` AS SELECT 
 1 AS `UNI`,
 1 AS `course_id`,
 1 AS `year`,
 1 AS `semester`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Faculty`
--

DROP TABLE IF EXISTS `Faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Faculty` (
  `UNI` varchar(12) NOT NULL,
  `pay_grade` int(11) NOT NULL,
  `title` varchar(20) NOT NULL,
  PRIMARY KEY (`UNI`),
  CONSTRAINT `fk_Faculty_uni` FOREIGN KEY (`UNI`) REFERENCES `Person` (`UNI`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `FacultyAll`
--

DROP TABLE IF EXISTS `FacultyAll`;
/*!50001 DROP VIEW IF EXISTS `FacultyAll`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `FacultyAll` AS SELECT 
 1 AS `UNI`,
 1 AS `last_name`,
 1 AS `first_name`,
 1 AS `email`,
 1 AS `department`,
 1 AS `pay_grade`,
 1 AS `title`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Person` (
  `UNI` varchar(12) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `department` varchar(32) NOT NULL,
  PRIMARY KEY (`UNI`),
  KEY `fk_Person_dept_idx` (`department`),
  CONSTRAINT `fk_Person_dept` FOREIGN KEY (`department`) REFERENCES `department` (`dname`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `School`
--

DROP TABLE IF EXISTS `School`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `School` (
  `sid` varchar(12) NOT NULL,
  `sname` varchar(45) NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE KEY `sname_UNIQUE` (`sname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Student` (
  `UNI` varchar(12) NOT NULL,
  `year` int(11) NOT NULL,
  PRIMARY KEY (`UNI`),
  CONSTRAINT `fk_table1_uni` FOREIGN KEY (`UNI`) REFERENCES `Person` (`UNI`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `StudentAll`
--

DROP TABLE IF EXISTS `StudentAll`;
/*!50001 DROP VIEW IF EXISTS `StudentAll`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `StudentAll` AS SELECT 
 1 AS `UNI`,
 1 AS `last_name`,
 1 AS `first_name`,
 1 AS `email`,
 1 AS `department`,
 1 AS `year`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `course_participant`
--

DROP TABLE IF EXISTS `course_participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_participant` (
  `UNI` varchar(12) NOT NULL,
  `section_call_no` char(5) NOT NULL,
  KEY `cp_section_fk` (`section_call_no`),
  KEY `cp_participant_fk_idx` (`UNI`),
  CONSTRAINT `cp_participant_fk` FOREIGN KEY (`UNI`) REFERENCES `Student` (`UNI`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cp_section_fk` FOREIGN KEY (`section_call_no`) REFERENCES `sections` (`call_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `hw3`.`course_participant_BEFORE_INSERT` BEFORE INSERT ON `course_participant` FOR EACH ROW
BEGIN
	
    
    DECLARE current_enrollment INT;
    DECLARE enrollment_l INT;
    
    
    DECLARE cid VARCHAR(12);
    DECLARE num_unsatisfied_prereqs INT;
    DECLARE unsatisfied_prereqs VARCHAR(100);
    DECLARE year_of_section INT;
    DECLARE semester_of_section VARCHAR(10);
    
    -- check if there is space on the section for another student
    
    SET enrollment_l = (SELECT enrollment_limit FROM sections WHERE call_no = NEW.section_call_no);
    SET current_enrollment = (SELECT COUNT(*) FROM course_participant WHERE section_call_no = NEW.section_call_no);
    
    IF current_enrollment = enrollment_l THEN
		SIGNAL SQLSTATE '04000' SET MESSAGE_TEXT='Section is full';
    END IF;
    
    -- check if the student has completed the pre-reqs
	-- get course id for the section    
    SET cid = (SELECT course_id FROM sections WHERE call_no = NEW.section_call_no);
	SET year_of_section = (SELECT year FROM sections WHERE call_no = NEW.section_call_no);
    SET semester_of_section = (SELECT semester FROM sections WHERE call_no = NEW.section_call_no);
    -- get all the prereqs for the course, the student is trying to subscribe for
    -- SELECT prereq_id FROM course_prereqs WHERE course_id = cid;
    
    -- get all the courses this student has taken in the past. Past is year < 2017 or year = 2017 and semester = 'Spring' because current semester is Fall
    -- SELECT DISTINCT T.course_id FROM (SELECT course_id FROM course_participant cp JOIN sections s ON cp.section_call_no = s.call_no WHERE s.year < 2017 OR (s.year = 2017 AND s.semester = 'Spring')) as T;
    
    IF semester_of_section = 'Spring' THEN
		SET num_unsatisfied_prereqs = (SELECT COUNT(p.prereq_id) FROM 
		(SELECT prereq_id  FROM course_prereqs WHERE course_id = cid) AS p
		WHERE p.prereq_id NOT IN 
		(SELECT DISTINCT T.course_id FROM (SELECT course_id FROM course_participant cp JOIN sections s ON cp.section_call_no = s.call_no WHERE cp.UNI = NEW.UNI and s.year < year_of_section) as T));
		

	   IF  num_unsatisfied_prereqs <> 0 THEN
		SELECT GROUP_CONCAT(p.prereq_id) INTO unsatisfied_prereqs FROM 
		(SELECT prereq_id  FROM course_prereqs WHERE course_id = cid) AS p
		WHERE p.prereq_id NOT IN 
		(SELECT DISTINCT T.course_id FROM (SELECT course_id FROM course_participant cp JOIN sections s ON cp.section_call_no = s.call_no WHERE cp.UNI = NEW.UNI and s.year < year_of_section) as T);
		
		
		SELECT concat('Pre-Reqs not satisfied: ', unsatisfied_prereqs) INTO unsatisfied_prereqs;
		SIGNAL SQLSTATE '03000' SET MESSAGE_TEXT = unsatisfied_prereqs; 
		
	   END IF;
	ELSEIF semester_of_section = 'Fall' THEN
		SET num_unsatisfied_prereqs = 
        (
			SELECT COUNT(p.prereq_id) FROM 
			(
				SELECT prereq_id  FROM course_prereqs WHERE course_id = cid
			) AS p
			WHERE p.prereq_id NOT IN 
			(
					SELECT DISTINCT T.course_id 
					FROM 
					(
						SELECT course_id 
							FROM 
							course_participant cp 
							JOIN 
							sections s 
							ON cp.section_call_no = s.call_no 
							WHERE 
							cp.UNI = NEW.UNI 
							AND 
							(
								s.year < year_of_section 
								OR 
								(
									s.year = year_of_section AND s.semester = 'Spring'
								)
							)
					) as T
			)
        );
		

	   IF  num_unsatisfied_prereqs <> 0 THEN
			SELECT GROUP_CONCAT(p.prereq_id) INTO unsatisfied_prereqs FROM 
			(SELECT prereq_id  FROM course_prereqs WHERE course_id = cid) AS p
			WHERE p.prereq_id NOT IN 
			(
				SELECT DISTINCT T.course_id 
				FROM 
				(
					SELECT course_id 
					FROM 
					course_participant cp 
					JOIN 
					sections s 
					ON cp.section_call_no = s.call_no 
					WHERE 
					cp.UNI = NEW.UNI 
					AND 
					(
						s.year < year_of_section 
						OR 
						(
							s.year = year_of_section AND s.semester = 'Spring'
						)
					)
				) as T
			);
			
			
			SELECT concat('Pre-Reqs not satisfied: ', unsatisfied_prereqs) INTO unsatisfied_prereqs;
			SIGNAL SQLSTATE '03000' SET MESSAGE_TEXT = unsatisfied_prereqs;
			END IF;
	END IF;
    
   
   
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `course_prereqs`
--

DROP TABLE IF EXISTS `course_prereqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_prereqs` (
  `course_id` varchar(12) NOT NULL,
  `prereq_id` varchar(12) NOT NULL,
  PRIMARY KEY (`course_id`,`prereq_id`),
  KEY `prereq_prereq_fk` (`prereq_id`),
  CONSTRAINT `prereq_course_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prereq_prereq_fk` FOREIGN KEY (`prereq_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `dept_code` char(4) NOT NULL,
  `faculty_code` enum('BC','C','E','F','G','V','W','X') NOT NULL,
  `level` enum('0','1','2','3','4','6','8','9') NOT NULL,
  `number` char(3) NOT NULL,
  `title` varchar(32) NOT NULL,
  `description` varchar(128) NOT NULL,
  `course_id` varchar(12) GENERATED ALWAYS AS (concat(`dept_code`,`faculty_code`,`level`,`number`)) STORED,
  `full_number` char(4) GENERATED ALWAYS AS (concat(`level`,`number`)) VIRTUAL,
  PRIMARY KEY (`dept_code`,`faculty_code`,`level`,`number`),
  UNIQUE KEY `course_id` (`course_id`),
  FULLTEXT KEY `keywords` (`title`,`description`),
  CONSTRAINT `course2_dept_fk` FOREIGN KEY (`dept_code`) REFERENCES `department` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `code` char(4) NOT NULL,
  `dname` varchar(32) NOT NULL,
  `sname` varchar(45) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `dname_UNIQUE` (`dname`),
  KEY `fk_department_sname_idx` (`sname`),
  CONSTRAINT `fk_department_sname` FOREIGN KEY (`sname`) REFERENCES `School` (`sname`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `section_taught_by`
--

DROP TABLE IF EXISTS `section_taught_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_taught_by` (
  `UNI` varchar(12) NOT NULL,
  `call_no` char(5) NOT NULL,
  PRIMARY KEY (`UNI`,`call_no`),
  UNIQUE KEY `unique` (`UNI`,`call_no`),
  KEY `fk_course_taught_by_call_no_idx` (`call_no`),
  KEY `fk_uni_idx` (`UNI`),
  CONSTRAINT `fk_course_taught_by_call_no` FOREIGN KEY (`call_no`) REFERENCES `sections` (`call_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_taught_by_uni` FOREIGN KEY (`UNI`) REFERENCES `Faculty` (`UNI`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `hw3`.`section_taught_by_BEFORE_INSERT` BEFORE INSERT ON `section_taught_by` FOR EACH ROW
BEGIN
	DECLARE this_year INT;
    DECLARE this_semester VARCHAR(10);
	DECLARE num_sections_taught INT;
    
    SET this_year = (SELECT year FROM sections WHERE NEW.call_no = sections.call_no);
    SET this_semester = (SELECT semester FROM sections WHERE NEW.call_no = sections.call_no);
    
    SET num_sections_taught = 
    (
		SELECT COUNT(*) 
        FROM 
        (	
			SELECT s.call_no
            FROM sections s
            JOIN 
            section_taught_by stb
            ON s.call_no = stb.call_no
            WHERE
            stb.UNI = NEW.UNI
            AND
            s.year = this_year
            AND
            s.semester = this_semester
		) as T
	);
    IF num_sections_taught  = 3 THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'A faculty is not allowed to instruct for more than 3 sections';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `call_no` char(5) NOT NULL,
  `course_id` varchar(12) NOT NULL,
  `section_no` varchar(45) NOT NULL,
  `year` int(11) NOT NULL,
  `semester` varchar(45) NOT NULL,
  `enrollment_limit` int(11) NOT NULL,
  `section_key` varchar(45) GENERATED ALWAYS AS (concat(`year`,`semester`,`course_id`,`section_no`)) STORED,
  PRIMARY KEY (`call_no`),
  UNIQUE KEY `unique` (`course_id`,`section_no`,`year`,`semester`),
  CONSTRAINT `section_course_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'hw3'
--

--
-- Final view structure for view `CoursesTaken`
--

/*!50001 DROP VIEW IF EXISTS `CoursesTaken`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `CoursesTaken` AS (select `cp`.`UNI` AS `UNI`,`s`.`course_id` AS `course_id`,`s`.`year` AS `year`,`s`.`semester` AS `semester` from (`course_participant` `cp` join `sections` `s` on((`s`.`call_no` = `cp`.`section_call_no`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CoursesTaught`
--

/*!50001 DROP VIEW IF EXISTS `CoursesTaught`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `CoursesTaught` AS (select `stb`.`UNI` AS `UNI`,`s`.`course_id` AS `course_id`,`s`.`year` AS `year`,`s`.`semester` AS `semester` from (`section_taught_by` `stb` join `sections` `s` on((`s`.`call_no` = `stb`.`call_no`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `FacultyAll`
--

/*!50001 DROP VIEW IF EXISTS `FacultyAll`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `FacultyAll` AS (select `F`.`UNI` AS `UNI`,`P`.`last_name` AS `last_name`,`P`.`first_name` AS `first_name`,`P`.`email` AS `email`,`P`.`department` AS `department`,`F`.`pay_grade` AS `pay_grade`,`F`.`title` AS `title` from (`Faculty` `F` join `Person` `P` on((`F`.`UNI` = `P`.`UNI`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `StudentAll`
--

/*!50001 DROP VIEW IF EXISTS `StudentAll`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `StudentAll` AS (select `S`.`UNI` AS `UNI`,`P`.`last_name` AS `last_name`,`P`.`first_name` AS `first_name`,`P`.`email` AS `email`,`P`.`department` AS `department`,`S`.`year` AS `year` from (`Student` `S` join `Person` `P` on((`S`.`UNI` = `P`.`UNI`)))) */;
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

-- Dump completed on 2017-10-28 14:38:47
