

-- Create the database
CREATE DATABASE dbms;

-- use the database
USE dbms;

-- Task 1

-- Create the following table:
-- Student(sid, sname, level, age, sex)
-- Instructor(iid, lname, age, sex)
-- Course(cid, cname, credits_hours)
-- Enroll_by(sid, cid)
-- Taught_by(iid, cid)
CREATE TABLE student(
    sid integer PRIMARY KEY,
    sname varchar(15),
    level varchar(15),
    age integer,
    sex varchar(8)
);

CREATE TABLE instructor(
    iid integer PRIMARY KEY,
    iname varchar(15),
    age integer,
    sex varchar(8)
);

CREATE TABLE course(
    cid integer PRIMARY KEY,
    cname varchar(15),
    credit_hours integer
);

CREATE TABLE enrolled_by(
    sid integer NOT NULL,
    cid integer NOT NULL,
    FOREIGN KEY(sid) REFERENCES student(sid),
    FOREIGN KEY(cid) REFERENCES course(cid)
);

CREATE TABLE taught_by(
    iid integer,
    cid integer,
    FOREIGN KEY(iid) REFERENCES instructor(iid),
    FOREIGN KEY(cid) REFERENCES course(cid)
);
-- end of task 1

-- Task 2

-- Insert the datas in the tables
INSERT INTO student
VALUES
    (101, 'Harendra', 'undergraduate', 22, 'Male'),
    (102, 'Ramesh', 'undergraduate', 21, 'Male'),
    (103, 'Nirab', 'graduate', 25, 'Male'),
    (104, 'Pratibha', 'undergraduate', 20, 'Female'),
    (105, 'Samrita', 'graduate', 24, 'Female'),
    (106, 'Astha', 'undergraduate', 22, 'Female'),
    (107, 'Rabindra', 'graduate', 28, 'Male'),
    (108, 'Abin', 'graduate', 26, 'Male'),
    (201, 'Bharat', 'postgraduate', 30, 'Male'),
    (202, 'Sohan', 'postgraduate', 32, 'Male');

INSERT INTO instructor
VALUES (202, 'Sohan', 32, 'male');

INSERT INTO course
VALUES (406, 'UML', 1);

-- Data are not directly entered in relationship tables so we have to insert each record.
INSERT INTO taught_by
VALUES (202, 406);

INSERT INTO enrolled_by
VALUES (202, 406);
-- end of task 2

-- Task 3
-- Write the SQL statement for the following Queries

-- 1. Print Or Display or Find all the records of the student.
SELECT * FROM student;

-- 2. Print Or Display or Find all the records of the instructor.
SELECT * FROM instructor;

-- 3. Print Or Display or Find all the records of the course.
SELECT * FROM course;

-- 4. Find the name and level of the female student over the age 22.
SELECT sname, level
FROM student
WHERE age > 22;

-- 5. Find the name of the instructor whose age is less than 28.
SELECT iname
FROM instructor
WHERE age < 28;

-- 6. Find id, name, level and age of student by increasing age by 1.
SELECT sid, sname, level, age + 1 AS age
FROM student;

-- 7. List the name of the instructors whose age is greater than 30.
SELECT iname
FROM instructor
WHERE age > 30;

-- 8. Find the name of the student who study SAD using natural join.
SELECT sname
FROM student NATURAL
JOIN enrolled_by NATURAL
JOIN course
WHERE cname = 'SAD';

-- 9. Find the Name and age of those student whose age is greater than 25 and sex is male.
SELECT sname, age
FROM student
WHERE age > 25 AND SEX = 'Male';

-- 10. Increase 50% credit_hours to all courses.
UPDATE course
SET credit_hours=credit_hours * 1.5;

-- 11. Display the name of those students whose level is unknown.
SELECT sname
FROM student
WHERE level IS NULL;

-- 12. List the students who are not enrolled in any course.
SELECT * FROM student
NATURAL JOIN enrolled_by
NATURAL JOIN course 
WHERE cid IS NULL;

-- 13. List all the course names of 3 credit hours.
SELECT cname
FROM course
WHERE credit_hours = 3;

-- 14. Update the level of student Nirab with Postgraduate.
UPDATE student
SET level = 'postgraduate'
WHERE sname = 'Nirab';

-- 15.  Delete the instructor Sweta from the instructor relation.
DELETE FROM instructor
WHERE iname = 'Sweta';

-- 16. Find id, name of all instructors whose course of 3 credit hours.
SELECT iid, iname
FROM instructor
NATURAL JOIN taught_by
NATURAL JOIN course
WHERE credit_hours = 3;

-- 17. Find id and name of all instructors in the order of sex and then in descending order of age.
SELECT iid, iname
FROM instructor
ORDER BY sex, age DESC;

-- 18. Find id and name of all undergraduate students in ascending order of name.
SELECT sid, sname
FROM student
WHERE level = 'undergraduate'
ORDER BY sname;

-- 19. Find record of all courses taught by instructor 302.
SELECT cid, cname
FROM course
NATURAL JOIN taught_by
WHERE iid = 302;

-- 20. Find id and name of students who enrolled in course csc-403.
SELECT sid, sname
FROM student
NATURAL JOIN enrolled_by
NATURAL JOIN course
WHERE cid = 'csc-403';

-- 21. Find id, name, level of all students whose age is greater than at least one student.
SELECT sid, sname, level
FROM student
WHERE age > (SELECT MIN(age) FROM student);

-- 22. Find average age of all undergraduate students.
SELECT AVG(age)
FROM student
WHERE level = 'undergraduate';

-- 23. Find average age for all levels of students.
SELECT level, AVG(age)
FROM student
GROUP BY level;

-- 24. Display the name of instructor with maximum age.
SELECT iname
FROM instructor
WHERE age = (SELECT MAX(age) FROM instructor);

-- 25. Find number of courses taught by each male instructors.
SELECT iid, iname, COUNT(cid)
FROM instructor
NATURAL JOIN taught_by
NATURAL JOIN course
WHERE sex = 'Male';

-- 26. Find average age for all levels of student that have average age more than 20.
SELECT level, AVG(age)
FROM student
GROUP BY level
HAVING AVG(age) > 20;

-- 27. Add new column 'addresses' to student table.
ALTER TABLE student
ADD addresses varchar(30);

-- 28. Remove column 'addresses' from student table.
ALTER TABLE student
DROP COLUMN addresses;

-- 29. Modify student relation by changing data type of sname to varchar(30);
ALTER TABLE student
MODIFY sname varchar(30);

-- 30. Create view that contains id, name, level of those students whose age is greater than 24.
CREATE VIEW student_view AS
SELECT sid, sname, level
FROM student
WHERE age > 24;

-- 31. Remove the view table just created.
DROP VIEW student_view;


-- Assignment 3:

-- 1. Find ID and name of all females who are instructor or student. Also identify the difference between union and union all.
SELECT iid as id, iname as Name
FROM instructor
WHERE sex='Female'
UNION
SELECT sid, sname FROM student
WHERE sex='Female'

 Union -> It combines two or more result sets into a single result set. It removes duplicate rows from the result set.
 Union All -> It combines two or more result sets into a single result set. It does not remove duplicate rows from the result set.

-- 2. Find ID,name, and age of all persons who are instructors as well as student.
SELECT iid as id, iname as Name, average
FROM instructor
EXCEPT 
SELECT sid, sname, age FROM student;

-- 3. Find ID,name and age of all persons who are instructors but not student.
SELECT iid, iname, age
FROM instructor
WHERE age > ALL (SELECT age FROM student);

-- 4. Find the average age for all levels of students.
SELECT level, AVG(age)
FROM student
GROUP BY level
HAVING AVG(age)>22;

-- 5. Find average age for all levels of students that have average age more than 22.
SELECT AVG(avg)
FROM students

-- 6. Select the name of instructor who teaches computer science, and whose names are neither raja nor ram.
SELECT iname 
FROM instructor
INNER JOIN taught_by ON instructor.iid=taught_by.iid
INNER JOIN course ON taught_by.cid=course.cid
WHERE cname='Computer Science' AND iname NOT IN ('Raja', 'Ram');

-- 7. Find id, name and age of all instructor whose age is greater than age of all students.
SELECT iid, iname, age
FROM instructor
WHERE age > ALL (SELECT age FROM student);

-- 8. Increase credit hour of courses by 5 whose credit hour is more than 3 otherwise increase credit hour by 1.
SELECT name
FROM instructor INNER JOIN taught_by ON instructor.iid=taught_by.iid
INNER JOIN course ON taught_by.cid=course.cid
WHERE credit_hours>3
UPDATE course
SET credit_hours=credit_hours+5
WHERE credit_hours>3
UPDATE course
SET credit_hours=credit_hours+1
WHERE credit_hours<=3;