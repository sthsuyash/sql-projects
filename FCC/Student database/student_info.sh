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

