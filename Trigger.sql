create database Triger;

use Triger;

-- DROP TABLE IF EXISTS Apply;
-- DROP TABLE IF EXISTS Student;

-- Create Student table
CREATE TABLE Student (
    studentId INT PRIMARY KEY,
    name VARCHAR(50),
    gpa DECIMAL(3,2)
);

-- Create Apply table
CREATE TABLE Apply (
    applyId INT AUTO_INCREMENT PRIMARY KEY,
    studentId INT,
    hallId CHAR(2),
    hallName VARCHAR(20),
    applyDate DATETIME,
    FOREIGN KEY (studentId) REFERENCES Student(studentId)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Drop trigger if exists
DROP TRIGGER IF EXISTS after_student_insert;

DELIMITER $$

CREATE TRIGGER after_student_insert
AFTER INSERT ON Student
FOR EACH ROW
BEGIN
    DECLARE hallId CHAR(2);
    DECLARE hallName VARCHAR(20);

    -- Determine hall assignment based on GPA
    IF NEW.gpa > 3.9 THEN
        SET hallId = '01';
        SET hallName = 'BB';
    ELSEIF NEW.gpa > 3.7 THEN
        SET hallId = '02';
        SET hallName = 'ZR';
    ELSEIF NEW.gpa > 3.5 THEN
        SET hallId = '03';
        SET hallName = 'MB';
    ELSEIF NEW.gpa > 3.3 THEN
        SET hallId = '04';
        SET hallName = 'SJ';
    ELSEIF NEW.gpa > 3.1 THEN
        SET hallId = '05';
        SET hallName = 'FH';
    ELSE
        SET hallId = NULL;
        SET hallName = NULL;
    END IF;

    -- Insert into Apply table if hallId is not null
    IF hallId IS NOT NULL THEN
        INSERT INTO Apply (studentId, hallId, hallName, applyDate)
        VALUES (NEW.studentId, hallId, hallName, NOW());
    END IF;
END$$

DELIMITER ;

show triggers;

INSERT INTO Student (studentId, name, gpa)
VALUES 
(1, 'Sakib', 3.92), 
(2, 'Rafi', 3.68), 
(3, 'Rony', 3.35), 
(4, 'Imran', 3.15), 
(5, 'Hasan', 2.95);

SELECT * FROM Student;
SELECT * FROM Apply;
