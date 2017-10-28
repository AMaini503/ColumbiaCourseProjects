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