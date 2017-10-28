CREATE PROCEDURE `updateFaculty` (IN UNI varchar(12), IN last_name varchar(45), IN first_name varchar(45), IN email varchar(45), IN department varchar(32), IN pay_grade INT, IN title varchar(20))
BEGIN
	DECLARE record_exists BOOL;
    SET record_exists = EXISTS(SELECT * FROM Person P WHERE P.UNI = UNI);
    
    IF NOT record_exists THEN
		SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'UNI NOT FOUND!';
	ELSE
		UPDATE Person P SET P.last_name = last_name, P.first_name = first_name, P.email = email, P.department = department WHERE P.UNI = UNI;
        UPDATE Faculty F SET F.pay_grade = pay_grade, F.title = title WHERE F.UNI = UNI;    
	END IF;
END