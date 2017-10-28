CREATE DEFINER = CURRENT_USER TRIGGER `hw3`.`section_taught_by_BEFORE_INSERT` BEFORE INSERT ON `section_taught_by` FOR EACH ROW
BEGIN
	DECLARE this_year INT;
    DECLARE this_semester VARCHAR(10);
	DECLARE num_sections_taught INT;
    
    SET this_year = (SELECT year FROM sections WHERE NEW.call_no = sections.call_no);
    SET this_semester = (SELECT semester FROM sections WHERE NEW.call_no = sections.call_no);
    
    SET num_sections_taught = 
    (
		SELECT COUNT(*) 
        FROM 
        (	
			SELECT s.call_no
            FROM sections s
            JOIN 
            section_taught_by stb
            ON s.call_no = stb.call_no
            WHERE
            stb.UNI = NEW.UNI
            AND
            s.year = this_year
            AND
            s.semester = this_semester
		) as T
	);
    IF num_sections_taught  = 3 THEN
		SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'A faculty is not allowed to instruct for more than 3 sections';
    END IF;
END