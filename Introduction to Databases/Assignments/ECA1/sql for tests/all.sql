-- TEST 1: LOADING DATA INTO THE TABLE `employee`
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('Candie', 'MacPake', 'cmacpake6@spiegel.de');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('Carling', 'Bockman', 'cbockman5@cam.ac.uk');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('Chrissy', 'Weatherup', 'cweatherup2@theguardian.com');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('Cloris', 'Edards', 'cedards4@springer.com');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('Dianne', 'Aickin', 'daickin9@domainmarket.com');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('Dougy', 'Snoxill', 'dsnoxill1@scribd.com');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('Dulciana', 'Cambell', 'dcambell8@i2i.jp');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('Jared', 'Melarkey', 'jmelarkey3@google.co.jp');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('Joice', 'Tomsen', 'jtomsen7@slideshare.net');
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('Juana', 'Gatesman', 'jgatesman0@chron.com');

SELECT * FROM `eca1`.`employee`;

-- TEST 2a: UPDATE FIRST_NAME `DOUGY` TO `DOUGLAS`, CREATED = NOW()
UPDATE `eca1`.`employee` SET `first_name`='Douglas', `created` = NOW() WHERE user_id = 'DOUGY.SNOXILL.1';
SELECT * FROM `eca1`.`employee` WHERE user_id = 'DOUGY.SNOXILL.1';

-- TEST 2b: ATTEMPT TO INSERT A TUPLE WITH DUPLICATE EMAIL SHOULD FAIL
-- TRYING TO INSERT JOHN WITH SAME EMAIL AS JUANA FAILS
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('John', 'Gatesman', 'jgatesman0@chron.com');
SELECT * FROM `eca1`.`employee`;

-- TEST 3: UPDATE DOUGLAS' user_id FAILS
UPDATE `eca1`.`employee` SET user_id='DOGE.SNOXILL.729' WHERE user_id='DOUGY.SNOXILL.1';
UPDATE `eca1`.`employee` SET user_id='DOGE.SNOXILL.729' WHERE first_name='Douglas' and last_name='Snoxill';
SELECT * FROM `eca1`.`employee`;

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