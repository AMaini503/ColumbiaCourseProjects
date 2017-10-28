CREATE PROCEDURE `insertStudent` (IN last_name varchar(45), IN first_name varchar(45), IN email varchar(45), IN department varchar(32), IN year INT)
BEGIN
	DECLARE UNI VARCHAR(12);
    SET UNI = generate_uni_for_person(last_name, first_name);
    INSERT INTO Person VALUES(UNI, last_name, first_name, email,department);
    INSERT INTO Student VALUES(UNI, year);
END