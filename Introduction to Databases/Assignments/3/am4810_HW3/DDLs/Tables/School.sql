CREATE TABLE `School` (
  `sid` varchar(12) NOT NULL,
  `sname` varchar(45) NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE KEY `sname_UNIQUE` (`sname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;