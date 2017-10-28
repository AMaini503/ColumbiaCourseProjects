CREATE PROCEDURE `insertFaculty` (IN last_name varchar(45), IN first_name varchar(45), IN email varchar(45), IN department varchar(32), IN pay_grade INT, IN title varchar(20))
BEGIN
	DECLARE UNI varchar(45);
    SET UNI = generate_uni_for_person(last_name, first_name);
    INSERT INTO Person VALUES(UNI, last_name, first_name, email, department);
    INSERT INTO Faculty VALUES(UNI, pay_grade, title);
END