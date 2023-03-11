-- All the info from the CSV files will go into a single database. Create a new database named students.
CREATE DATABASE students;

-- The CSV files have a bunch of students with info about them, and some courses and majors. You will have four tables. One for the students and their info, one for each major, another for each course, and a final one for showing what courses are included in each major. First, create the students table.
CREATE TABLE students();

-- The second table will be for each unique major that appears in the data. Create a table named majors.
CREATE TABLE majors();

-- The third table is for each unique course in the data. Create another table named courses.
CREATE TABLE courses();

-- The final table will be a junction table for the majors and courses. Create it with the name majors_courses.
CREATE TABLE majors_courses();

-- Onto the columns. The students.csv file has four fields, you will make a column for each of those as well as an ID column. Add a column to your students table named student_id. Give it a type of SERIAL so it automatically increments and make it a PRIMARY KEY
ALTER TABLE students ADD COLUMN student_id SERIAL PRIMARY KEY;

-- The first column in students.csv is first_name. Add a column to the students table with that name. Make it a type of VARCHAR(50) and give it the NOT NULL constraint.
ALTER TABLE students ADD COLUMN first_name VARCHAR(50) NOT NULL;

-- The next column in the data is last_name. Add it to the students table. Give it the same data type and max-length as first_name and make sure it has the NOT NULL constraint.
ALTER TABLE students ADD COLUMN last_name VARCHAR(50) NOT NULL;


-- The next column is for the major. 
-- Since you will have each major in another table this column will be a foreign key that references it. 
-- Create a column in the students table named major_id, give it a data type of INT for now. You will come back and set the foreign key later.
ALTER TABLE students ADD COLUMN major_id INT;


-- Create the last column, gpa. The data in the CSV shows that they are decimals with a length of 2 and 1 number is to the right of the decimal. So give it a data type of NUMERIC(2,1).
ALTER TABLE students ADD COLUMN gpa NUMERIC(2,1);


-- The foreign key is still missing. Let's fill in the majors table next. Add a major_id column to it. Make it a type of SERIAL and the PRIMARY KEY for this table.
ALTER TABLE majors ADD COLUMN major_id SERIAL PRIMARY KEY;


-- This table will only have one other column for the name of the major. Add a column to it named major. Make it a VARCHAR with a max-length of 50 and give it the NOT NULL constraint.
ALTER TABLE majors ADD COLUMN major VARCHAR(50) NOT NULL;


-- This table looks good. Now, set the major_id column from the students table as a foreign key that references the major_id column from the majors table. Here's an example of how to do that: ALTER TABLE <table_name> ADD FOREIGN KEY(<column_name>) REFERENCES <referenced_table_name>
ALTER TABLE students ADD FOREIGN KEY(major_id) REFERENCES majors(major_id);

-- Next, is the courses table. Add a course_id column to it. Give it a type of SERIAL and make it the primary key.
ALTER TABLE courses ADD COLUMN course_id SERIAL PRIMARY KEY;

-- Add a course column to the courses table that's a type of VARCHAR. The course names are a little longer, so give them a max-length of 100. Also, make sure it can't accept null values.
ALTER TABLE courses ADD COLUMN course VARCHAR(100) NOT NULL;


-- One more table to go. The majors_courses junction table will have two columns, each referencing the primary key from two related table. First, add a major_id column to it. Just give it a type of INT for now.
ALTER TABLE majors_courses ADD COLUMN major_id INT;


-- Set the major_id column you just created as a foreign key that references the major_id column from the majors table.
ALTER TABLE majors_courses ADD FOREIGN KEY(major_id) REFERENCES majors(major_id);


-- Next, add a course_id column to the same table. Just give it a type of INT again for now.
ALTER TABLE majors_courses ADD COLUMN course_id INT;



-- Set your new course_id column as a foreign key that references the other course_id column.
ALTER TABLE majors_courses ADD FOREIGN KEY(course_id) REFERENCES courses(course_id);

-- There's one thing missing. This table doesn't have a primary key. The data from courses.csv will go in this table. A single major will be in it multiple times, and same with a course. So neither of them can be a primary key. But there will never be a row with the same two values as another row. So the two columns together, are unique. You can create a composite primary key that uses more than one column as a unique pair like this: ALTER TABLE <table_name> ADD PRIMARY KEY(<column_name>, <column_name>); Add a composite primary key to the table using the two columns.
ALTER TABLE majors_courses ADD PRIMARY KEY(major_id, course_id);

-- Next, you can start adding some info. Since the students table needs a major_id, you can add a major first. View the details of the majors table to see what info it expects.
\d majors


-- It only needs the name of a major. The ID will be added automatically. Add the first major from the courses.csv file into the majors table. It's a VARCHAR, so make sure to put the value in single quotes
INSERT INTO majors (major) VALUES ('Database Administration');


-- Use SELECT to view all the data in the majors table to make sure it got inserted correctly.
SELECT * FROM majors;


-- Next, insert the first course from courses.csv into the courses table.
INSERT INTO courses (course) VALUES ('Data Structures and Algorithms');



-- View all data from courses to see if the data was inserted correctly.
SELECT * FROM courses;

-- Next, you can add a row into the junction table. View the details of it to see what it expects.
\d majors_courses


-- It wants a major_id and course_id. Add a row to majors_courses for the first entry in courses.csv.
INSERT INTO majors_courses VALUES (1, 1);

-- View all data
SELECT * FROM majors_courses;


-- Looks like the row got added. View the details of the students table to remind yourself what it expects so you can add the first student to the database.
\d students


-- The output shows what the table needs. Insert the first person from students.csv into the students table.
INSERT INTO students (first_name, last_name, major_id, gpa) VALUES ('Rhea', 'Kellems', 1, 2.5);


-- Looks like it worked. View all the data in the students table to make sure.
SELECT * FROM students;


-- Okay, you added a row into each table. It might be wise to review the data and the database structure. Adding the rest of the info one at a time would be tedious. You are going to make a script to do it for you. I recommend "splitting" the terminal for this part. You can do that by clicking the "hamburger" menu at the top left of the window, going to the "Terminal" menu, and clicking "Split Terminal". Once you've done that, use the touch command to create a file named insert_data.sh in your project folder.

-- You should have two terminals open. One connected to PostgreSQL, and one for entering terminal commands. In the one for terminal commands, use the chmod command with the +x flag to give you new script executable permissions.
chmod +x insert_data.sh

-- First, you should add all the info from the courses.csv file since you need the major_id for inserting the student info. cat is a terminal command for printing the contents of a file. Here's an example: cat <filename>. Below the comment you added, use it to print courses.csv.


-- It helps to plan out what you want to happen. For each loop, you will want to add the major to the database if it isn't in there yet. Same for the course. Then add a row to the majors_courses table. Add these single line comments in your loop in this order: get major_id, if not found, insert major, get new major_id, get course_id, if not found, insert course, get new course_id, insert into majors_courses.
