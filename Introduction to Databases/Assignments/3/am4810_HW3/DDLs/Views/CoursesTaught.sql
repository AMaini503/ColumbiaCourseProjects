CREATE VIEW `CoursesTaught` AS
(
	SELECT stb.UNI,s.course_id,s.year,s.semester FROM
    section_taught_by stb
    JOIN 
    sections s
    ON s.call_no = stb.call_no
)