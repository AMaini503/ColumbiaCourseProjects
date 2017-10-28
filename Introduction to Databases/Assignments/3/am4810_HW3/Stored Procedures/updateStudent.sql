CREATE PROCEDURE `updateStudent` (IN UNI varchar(12), IN last_name varchar(45), IN first_name varchar(45), IN email varchar(45), IN department varchar(32), IN year INT)
BEGIN
	DECLARE record_exist BOOL;
    SET record_exist = EXISTS(SELECT * FROM Person P WHERE P.UNI = UNI);
    
    IF NOT record_exist THEN
		SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'UNI NOT FOUND!';
	ELSE
		UPDATE Person P SET P.last_name = last_name, P.first_name = first_name, P.email = email, P.department = department WHERE P.UNI = UNI;
        UPDATE Student S SET S.year = year WHERE S.UNI = UNI;    
	END IF;
END