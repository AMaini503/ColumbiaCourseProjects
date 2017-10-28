CREATE VIEW `FacultyAll` AS
 (	
	SELECT F.UNI as `UNI`, P.last_name as `last_name`, P.first_name as `first_name`, P.email as `email`, P.department as `department`, F.pay_grade as `pay_grade`, F.title as `title`
    FROM
    Faculty F
    JOIN 
    Person P
    ON F.UNI = P.UNI
 );