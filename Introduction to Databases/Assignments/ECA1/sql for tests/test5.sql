-- TEST 5: 
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('John', 'Smith', 'js1@statcounter.com');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('John', 'Smith', 'js2@statcounter.com');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('John', 'Smith', 'js3@statcounter.com');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('John', 'Smith', 'js4@statcounter.com');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('John', 'Smith', 'js5@statcounter.com');


DELETE FROM `eca1`.`employee` WHERE `email`='js2@statcounter.com';
DELETE FROM `eca1`.`employee` WHERE `email`='js4@statcounter.com';

INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('John', 'Smith', 'js@myemail.com');

SELECT * FROM `eca1`.`employee` WHERE `last_name`='Smith';