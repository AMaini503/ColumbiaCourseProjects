CREATE DEFINER = CURRENT_USER TRIGGER `hw3`.`course_participant_BEFORE_INSERT` BEFORE INSERT ON `course_participant` FOR EACH ROW
BEGIN
	
    
    DECLARE current_enrollment INT;
    DECLARE enrollment_l INT;
    
    
    DECLARE cid VARCHAR(12);
    DECLARE num_unsatisfied_prereqs INT;
    DECLARE unsatisfied_prereqs VARCHAR(100);
    DECLARE year_of_section INT;
    DECLARE semester_of_section VARCHAR(10);
    
    -- check if there is space on the section for another student
    
    SET enrollment_l = (SELECT enrollment_limit FROM sections WHERE call_no = NEW.section_call_no);
    SET current_enrollment = (SELECT COUNT(*) FROM course_participant WHERE section_call_no = NEW.section_call_no);
    
    IF current_enrollment = enrollment_l THEN
		SIGNAL SQLSTATE '04000' SET MESSAGE_TEXT='Section is full';
    END IF;
    
    -- check if the student has completed the pre-reqs
	-- get course id for the section    
    SET cid = (SELECT course_id FROM sections WHERE call_no = NEW.section_call_no);
	SET year_of_section = (SELECT year FROM sections WHERE call_no = NEW.section_call_no);
    SET semester_of_section = (SELECT semester FROM sections WHERE call_no = NEW.section_call_no);
    -- get all the prereqs for the course, the student is trying to subscribe for
    -- SELECT prereq_id FROM course_prereqs WHERE course_id = cid;
    
    -- get all the courses this student has taken in the past. Past is year < 2017 or year = 2017 and semester = 'Spring' because current semester is Fall
    -- SELECT DISTINCT T.course_id FROM (SELECT course_id FROM course_participant cp JOIN sections s ON cp.section_call_no = s.call_no WHERE s.year < 2017 OR (s.year = 2017 AND s.semester = 'Spring')) as T;
    
    IF semester_of_section = 'Spring' THEN
		SET num_unsatisfied_prereqs = (SELECT COUNT(p.prereq_id) FROM 
		(SELECT prereq_id  FROM course_prereqs WHERE course_id = cid) AS p
		WHERE p.prereq_id NOT IN 
		(SELECT DISTINCT T.course_id FROM (SELECT course_id FROM course_participant cp JOIN sections s ON cp.section_call_no = s.call_no WHERE cp.UNI = NEW.UNI and s.year < year_of_section) as T));
		

	   IF  num_unsatisfied_prereqs <> 0 THEN
		SELECT GROUP_CONCAT(p.prereq_id) INTO unsatisfied_prereqs FROM 
		(SELECT prereq_id  FROM course_prereqs WHERE course_id = cid) AS p
		WHERE p.prereq_id NOT IN 
		(SELECT DISTINCT T.course_id FROM (SELECT course_id FROM course_participant cp JOIN sections s ON cp.section_call_no = s.call_no WHERE cp.UNI = NEW.UNI and s.year < year_of_section) as T);
		
		
		SELECT concat('Pre-Reqs not satisfied: ', unsatisfied_prereqs) INTO unsatisfied_prereqs;
		SIGNAL SQLSTATE '03000' SET MESSAGE_TEXT = unsatisfied_prereqs; 
		
	   END IF;
	ELSEIF semester_of_section = 'Fall' THEN
		SET num_unsatisfied_prereqs = 
        (
			SELECT COUNT(p.prereq_id) FROM 
			(
				SELECT prereq_id  FROM course_prereqs WHERE course_id = cid
			) AS p
			WHERE p.prereq_id NOT IN 
			(
					SELECT DISTINCT T.course_id 
					FROM 
					(
						SELECT course_id 
							FROM 
							course_participant cp 
							JOIN 
							sections s 
							ON cp.section_call_no = s.call_no 
							WHERE 
							cp.UNI = NEW.UNI 
							AND 
							(
								s.year < year_of_section 
								OR 
								(
									s.year = year_of_section AND s.semester = 'Spring'
								)
							)
					) as T
			)
        );
		

	   IF  num_unsatisfied_prereqs <> 0 THEN
			SELECT GROUP_CONCAT(p.prereq_id) INTO unsatisfied_prereqs FROM 
			(SELECT prereq_id  FROM course_prereqs WHERE course_id = cid) AS p
			WHERE p.prereq_id NOT IN 
			(
				SELECT DISTINCT T.course_id 
				FROM 
				(
					SELECT course_id 
					FROM 
					course_participant cp 
					JOIN 
					sections s 
					ON cp.section_call_no = s.call_no 
					WHERE 
					cp.UNI = NEW.UNI 
					AND 
					(
						s.year < year_of_section 
						OR 
						(
							s.year = year_of_section AND s.semester = 'Spring'
						)
					)
				) as T
			);
			
			
			SELECT concat('Pre-Reqs not satisfied: ', unsatisfied_prereqs) INTO unsatisfied_prereqs;
			SIGNAL SQLSTATE '03000' SET MESSAGE_TEXT = unsatisfied_prereqs;
			END IF;
	END IF;
    
   
   
END