CREATE VIEW `StudentAll` AS
 (	
	SELECT S.UNI as `UNI`, P.last_name as `last_name`, P.first_name as `first_name`, P.email as `email`, P.department as `department`, S.year as `year`
    FROM 
    Student S
    JOIN 
    Person P
    ON S.UNI = P.UNI
 );