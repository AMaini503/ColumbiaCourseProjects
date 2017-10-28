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