#!/bin/bash

# Script to insert data from courses.csv and students.csv into students database

PSQL="psql -X -U localhost -d students --no-align --tuples-only -c"

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

        # if not found

        # insert course

        # get new course_id

        # insert into majors_courses

    fi
done

# Now, you can query your database using the PSQL variable like this: $($PSQL "<query_here>"). Below the get major_id comment in your loop, create a MAJOR_ID variable. Set it equal to the result of a query that gets the major_id of the current MAJOR in the loop. Make sure to put your MAJOR variable in single quotes.

# You won't want to add the first line from the CSV file to the database since those are just titles. In your script, add an if condition at the top of your loop that checks if $MAJOR != major. Put all the existing code and comments in your loop in it's statements area so it only does any of it if it's not the first line.