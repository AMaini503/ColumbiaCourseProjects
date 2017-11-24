-- TEST 2b: ATTEMPT TO INSERT A TUPLE WITH DUPLICATE EMAIL SHOULD FAIL
-- TRYING TO INSERT JOHN WITH SAME EMAIL AS JUANA FAILS
INSERT INTO `eca1`.`employee` (`first_name`, `last_name`, `email`) VALUES ('John', 'Gatesman', 'jgatesman0@chron.com');
SELECT * FROM `eca1`.`employee`;