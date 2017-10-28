CREATE TABLE `course_prereqs` (
  `course_id` varchar(12) NOT NULL,
  `prereq_id` varchar(12) NOT NULL,
  PRIMARY KEY (`course_id`,`prereq_id`),
  KEY `prereq_prereq_fk` (`prereq_id`),
  CONSTRAINT `prereq_course_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prereq_prereq_fk` FOREIGN KEY (`prereq_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;