CREATE VIEW `CoursesTaken` AS
(
		SELECT cp.UNI, s.course_id, s.year, s.semester
        FROM
        course_participant cp
        JOIN 
        sections s
        ON s.call_no = cp.section_call_no
)