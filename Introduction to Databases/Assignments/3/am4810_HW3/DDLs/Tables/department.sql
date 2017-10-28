CREATE TABLE `department` (
  `code` char(4) NOT NULL,
  `dname` varchar(32) NOT NULL,
  `sname` varchar(45) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `dname_UNIQUE` (`dname`),
  KEY `fk_department_sname_idx` (`sname`),
  CONSTRAINT `fk_department_sname` FOREIGN KEY (`sname`) REFERENCES `School` (`sname`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;