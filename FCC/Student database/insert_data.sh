#!/bin/bash

# Script to insert data from courses.csv and students.csv into students database

PSQL="psql -X -U localhost -d students --no-align --tuples-only -c" # PSQL variable to run queries

# Truncate tables at the start
echo $($PSQL "TRUNCATE students, majors, courses, majors_courses")

cat courses.csv | while IFS="," read MAJOR COURSE; 
do
    if [[ $MAJOR != major ]] # check if the first line is not the title
    then
        # get major_id
        MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
        # echo $MAJOR_ID # for testing

        # if not found
        if [[ -z $MAJOR_ID ]] # if MAJOR_ID is empty, i.e. -z is used to check if the variable is empty
        then
            # insert major
            INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO majors (major) VALUES ('$MAJOR')")
            # echo $INSERT_MAJOR_RESULT # for testing

            # check if insert was successful
            if [[ $INSERT_MAJOR_RESULT == "INSERT 0 1" ]]
            then
                echo Inserted into majors, $MAJOR
            fi

            # get new major_id
            MAJOR_ID=$($PSQL("SELECT major_id FROM majors WHERE major='$MAJOR'"))

        fi

        # get course_id
        COURSE_ID=$($PSQL "SELECT course_id from courses WHERE course='$COURSE'")
        # if not found
        if [[ -z $COURSE_ID ]]
        then
            # insert course
            INSERT_COURSE_RESULT=$($PSQL "INSERT INTO courses(course) VALUES('$COURSE')")

            if [[ $INSERT_COURSE_RESULT == "INSERT 0 1" ]]
            then
              echo Inserted into courses, $COURSE
            fi
            # get new course_id
            COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
        fi

        # insert into majors_courses
        INSERT_MAJORS_COURSES_RESULT=$($PSQL "INSERT INTO majors_courses(major_id, course_id) VALUES ($MAJOR_ID, $COURSE_ID)")

        if [[ $INSERT_MAJORS_COURSES_RESULT == "INSERT 0 1" ]]
        then
          echo Inserted into majors_courses, $MAJOR : $COURSE
        fi
    fi
done

# now for students table

cat students.csv | while IFS="," read FIRST LAST MAJOR GPA;
do
      if [[ $FIRST != first_name ]]
  then
    # get major_id
    MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major_id='$MAJOR'")
    
    # if not found
    if [[ -z $MAJOR_ID ]] # if MAJOR_ID is empty, i.e. -z is used to check if the variable is empty
    then
      # set to null
      MAJOR_ID=null
    fi
    # echo $MAJOR_ID # for testing

    # insert student
    INSERT_STUDENT_RESULT=$($PSQL "INSERT INTO students(first_name, last_name, major_id, gpa) VALUES('$FIRST', '$LAST', $MAJOR_ID, $GPA)")

    if [[ $INSERT_STUDENT_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into students, $FIRST $LAST
    fi
  fi
done
