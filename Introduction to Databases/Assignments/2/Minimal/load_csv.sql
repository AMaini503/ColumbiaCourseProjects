USE mydb;

DELETE FROM Student;
LOAD DATA LOCAL INFILE "/home/aayush/ColumbiaCourseProjects/Introduction to Databases/Assignments/2/Student.csv" INTO TABLE Student FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;

DELETE FROM Course;
LOAD DATA LOCAL INFILE "/home/aayush/ColumbiaCourseProjects/Introduction to Databases/Assignments/2/Course.csv" INTO TABLE Course FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;

DELETE FROM Department;
LOAD DATA LOCAL INFILE "/home/aayush/ColumbiaCourseProjects/Introduction to Databases/Assignments/2/Department.csv" INTO TABLE Department FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;

DELETE FROM Faculty;
LOAD DATA LOCAL INFILE "/home/aayush/ColumbiaCourseProjects/Introduction to Databases/Assignments/2/Faculty.csv" INTO TABLE Faculty FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
