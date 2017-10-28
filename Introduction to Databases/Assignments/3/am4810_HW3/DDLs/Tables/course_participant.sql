CREATE TABLE `course_participant` (
  `UNI` varchar(12) NOT NULL,
  `section_call_no` char(5) NOT NULL,
  KEY `cp_section_fk` (`section_call_no`),
  KEY `cp_participant_fk_idx` (`UNI`),
  CONSTRAINT `cp_participant_fk` FOREIGN KEY (`UNI`) REFERENCES `Student` (`UNI`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cp_section_fk` FOREIGN KEY (`section_call_no`) REFERENCES `sections` (`call_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;