#!/bin/bash

# Info about my computer science students from students database

# chmod +x student_info.sh => run this to give execute permission to the script

echo -e "\n~~ My Computer Science Students ~~\n"

# PSQL variable to run queries
PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

echo -e "\nFirst name, last name, and GPA of students with a 4.0 GPA:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE gpa = 4.0")"

echo -e "\nAll course names whose first letter is before 'D' in the alphabet:"
echo "$($PSQL "SELECT course FROM courses WHERE course < 'D'")"

echo -e "\nFirst name, last name, and GPA of students whose last name begins with an 'R' or after and have a GPA greater than 3.8 or less than 2.0:" 
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE last_name >= 'R' and (gpa > 3.8 or gpa < 2.0)")"