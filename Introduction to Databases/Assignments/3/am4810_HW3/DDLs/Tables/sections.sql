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