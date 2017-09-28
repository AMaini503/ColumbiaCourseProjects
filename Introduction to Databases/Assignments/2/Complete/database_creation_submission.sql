CREATE TABLE  `Student` (
  `StudentID` VARCHAR(50) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `EmailID` VARCHAR(45) NOT NULL,
  `Gender` CHAR(1) NOT NULL,
  `DOB` DATE NOT NULL,
  PRIMARY KEY (`StudentID`, `FirstName`, `LastName`))
ENGINE = InnoDB;



CREATE TABLE  `Faculty` (
  `FacultyID` VARCHAR(50) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `EmailID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`FacultyID`, `FirstName`, `LastName`))
ENGINE = InnoDB;


CREATE TABLE  `Department` (
  `ID` INT(8) NOT NULL,
  `Name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`, `Name`))
ENGINE = InnoDB;


CREATE TABLE  `Course` (
  `CourseID` VARCHAR(20) NOT NULL,
  `FullName` VARCHAR(50) NOT NULL,
  `CourseCode` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`CourseID`, `FullName`))
ENGINE = InnoDB;


CREATE TABLE  `Prerequisite` (
  `CourseID` VARCHAR(20) NOT NULL,
  `CourseName` VARCHAR(50) NOT NULL,
  `PrereqCourseID` VARCHAR(45) NOT NULL,
  `PrereqCourseName` VARCHAR(50) NOT NULL,
  INDEX `fk_Prerequisite_idx_1` (`PrereqCourseID` ASC, `PrereqCourseName` ASC),
  INDEX `fk_Prerequisite_idx_2` (`CourseID` ASC, `CourseName` ASC),
  PRIMARY KEY (`CourseID`, `CourseName`, `PrereqCourseID`, `PrereqCourseName`),
  CONSTRAINT `fk_Prerequisite_1`
    FOREIGN KEY (`CourseID` , `CourseName`)
    REFERENCES `Course` (`CourseID` , `FullName`),
  CONSTRAINT `fk_Prerequisite_2`
    FOREIGN KEY (`PrereqCourseID` , `PrereqCourseName`)
    REFERENCES `Course` (`CourseID` , `FullName`)
    )
ENGINE = InnoDB;


CREATE TABLE  `Sections` (
  `CourseID` VARCHAR(20) NOT NULL,
  `CourseName` VARCHAR(50) NOT NULL,
  `SectionNumber` INT(5) NOT NULL,
  `FacultyID` VARCHAR(50) NOT NULL,
  `InstructorFName` VARCHAR(45) NOT NULL,
  `InstructorLName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CourseID`, `CourseName`, `SectionNumber`, `FacultyID`, `InstructorFName`, `InstructorLName`),
  INDEX `fk_Sections_idx_1` (`FacultyID` ASC, `InstructorFName` ASC, `InstructorLName` ASC),
  INDEX `fk_Section_idx_2` (`CourseID` ASC, `CourseName` ASC),
  CONSTRAINT `fk_Sections_1`
    FOREIGN KEY (`CourseID` , `CourseName`)
    REFERENCES `Course` (`CourseID` , `FullName`)
    ,
  CONSTRAINT `fk_Sections_2`
    FOREIGN KEY (`FacultyID` , `InstructorFName` , `InstructorLName`)
    REFERENCES `Faculty` (`FacultyID` , `FirstName` , `LastName`)
    )
ENGINE = InnoDB;


CREATE TABLE  `Has_enrolled_in` (
  `StudentID` VARCHAR(50) NOT NULL,
  `StudentFName` VARCHAR(45) NOT NULL,
  `StudentLName` VARCHAR(45) NOT NULL,
  `CourseID` VARCHAR(20) NOT NULL,
  `CourseName` VARCHAR(50) NOT NULL,
  `SectionNumber` INT(5) NOT NULL,
  PRIMARY KEY (`StudentID`, `CourseID`, `SectionNumber`, `StudentFName`, `StudentLName`, `CourseName`),
  INDEX `fk_has_enrolled_in_idx_1` (`CourseID` ASC, `CourseName` ASC, `SectionNumber` ASC),
  INDEX `fk_has_enrolled_in_idx_2` (`StudentID` ASC, `StudentFName` ASC, `StudentLName` ASC),
  CONSTRAINT `fk_has_enrolled_in_1`
    FOREIGN KEY (`StudentID` , `StudentFName` , `StudentLName`)
    REFERENCES `Student` (`StudentID` , `FirstName` , `LastName`)
   ,
  CONSTRAINT `fk_has_enrolled_in_2`
    FOREIGN KEY (`CourseID` , `CourseName` , `SectionNumber`)
    REFERENCES `Sections` (`CourseID` , `CourseName` , `SectionNumber`)
    )
ENGINE = InnoDB;


CREATE TABLE  `Has_completed` (
  `StudentID` VARCHAR(50) NOT NULL,
  `StudentFName` VARCHAR(45) NOT NULL,
  `StudentLName` VARCHAR(45) NOT NULL,
  `CourseID` VARCHAR(20) NOT NULL,
  `CourseName` VARCHAR(50) NOT NULL,
  `SectionNumber` INT(5) NOT NULL,
  `Grade` CHAR(1) NOT NULL,
  PRIMARY KEY (`StudentID`, `StudentFName`, `StudentLName`, `CourseID`, `CourseName`, `SectionNumber`),
  INDEX `fk_Has_completed_idx_2` (`StudentID` ASC, `StudentFName` ASC, `StudentLName` ASC),
  INDEX `fk_Has_completed_idx_1` (`CourseID` ASC, `CourseName` ASC, `SectionNumber` ASC),
  CONSTRAINT `fk_has_completed_1`
    FOREIGN KEY (`StudentID` , `StudentFName` , `StudentLName`)
    REFERENCES `Student` (`StudentID` , `FirstName` , `LastName`)
   ,
  CONSTRAINT `fk_has_completed_2`
    FOREIGN KEY (`CourseID` , `CourseName` , `SectionNumber`)
    REFERENCES `Sections` (`CourseID` , `CourseName` , `SectionNumber`)
   )
ENGINE = InnoDB;


CREATE TABLE  `Serves_in` (
  `DeptID` INT(8) NOT NULL,
  `DeptName` VARCHAR(45) NOT NULL,
  `FacultyID` VARCHAR(50) NOT NULL,
  `FacultyFName` VARCHAR(45) NOT NULL,
  `FacultyLName` VARCHAR(45) NOT NULL,
  `Designation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeptID`, `DeptName`, `FacultyID`, `FacultyFName`, `FacultyLName`, `Designation`),
  INDEX `fk_Serves_in_idx_1` (`FacultyID` ASC, `FacultyFName` ASC, `FacultyLName` ASC),
  INDEX `fk_Serves_in_idx_2` (`DeptID` ASC, `DeptName` ASC),
  CONSTRAINT `fk_Serves_in_1`
    FOREIGN KEY (`FacultyID` , `FacultyFName` , `FacultyLName`)
    REFERENCES `Faculty` (`FacultyID` , `FirstName` , `LastName`)
    ,
  CONSTRAINT `fk_Serves_in_2`
    FOREIGN KEY (`DeptID` , `DeptName`)
    REFERENCES `Department` (`ID` , `Name`)
    )
ENGINE = InnoDB;

CREATE TABLE  `Offered_by` (
  `DeptID` INT(8) NOT NULL,
  `DeptName` VARCHAR(20) NOT NULL,
  `CourseID` VARCHAR(20) NOT NULL,
  `CourseName` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`DeptID`, `DeptName`, `CourseID`, `CourseName`),
  INDEX `fk_Offered_by_idx_1` (`DeptID` ASC, `DeptName` ASC),
  INDEX `fk_Offered_by_idx_2` (`CourseID` ASC, `CourseName` ASC),
  CONSTRAINT `fk_Offered_by_1`
    FOREIGN KEY (`CourseID` , `CourseName`)
    REFERENCES `Course` (`CourseID` , `FullName`)
    ,
  CONSTRAINT `fk_Offered_by_2`
    FOREIGN KEY (`DeptID` , `DeptName`)
    REFERENCES `Department` (`ID` , `Name`)
    )
ENGINE = InnoDB;


CREATE TABLE  `Headed_by` (
  `DeptID` INT(8) NOT NULL,
  `DeptName` VARCHAR(20) NOT NULL,
  `FacultyID` VARCHAR(50) NOT NULL,
  `FacultyFName` VARCHAR(45) NOT NULL,
  `FacultyLName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeptID`, `DeptName`, `FacultyID`, `FacultyFName`, `FacultyLName`),
  INDEX `fk_Headed_by_idx_1` (`FacultyID` ASC, `FacultyFName` ASC, `FacultyLName` ASC),
  INDEX `fk_Headed_by_idx_2` (`DeptID` ASC, `DeptName` ASC),
  CONSTRAINT `fk_Headed_by_1`
    FOREIGN KEY (`DeptID` , `DeptName`)
    REFERENCES `Department` (`ID` , `Name`)
    ,
  CONSTRAINT `fk_Headed_by_2`
    FOREIGN KEY (`FacultyID` , `FacultyFName` , `FacultyLName`)
    REFERENCES `Faculty` (`FacultyID` , `FirstName` , `LastName`)
)
ENGINE = InnoDB;


