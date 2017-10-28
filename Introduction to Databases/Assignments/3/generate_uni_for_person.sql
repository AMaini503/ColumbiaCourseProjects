CREATE FUNCTION `generate_uni_for_person` (last_name VARCHAR(45), first_name VARCHAR(45))
RETURNS VARCHAR(12)
BEGIN
	DECLARE fn CHAR(2);
    DECLARE ln CHAR(2);
	DECLARE pattern CHAR(5);
    DECLARE old_uni_count INT;
    DECLARE UNI varchar(12);
    
    SET fn = UPPER(SUBSTR(last_name, 1, 2));
    SET ln = UPPER(SUBSTR(first_name, 1, 2)); 
    SET pattern = CONCAT(fn, ln);
SELECT 
    COUNT(*)
INTO old_uni_count FROM
    Person
WHERE
    Person.UNI LIKE CONCAT(pattern, '%');
    SET UNI = CONCAT(pattern, "-", old_uni_count + 1); 
    
RETURN UNI;
END
