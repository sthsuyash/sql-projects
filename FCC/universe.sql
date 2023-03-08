-- Building a celestial bodies database project --

-- For this project, log in to PostgreSQL with psql to create the database. 
-- Do that by entering psql -U <username> --d <db-name> in the terminal. 

-- All the tests below must pass to complete the project.

-- Here's some ideas for other column and table names: description, has_life, is_spherical, age_in_millions_of_years, planet_types, galaxy_types, distance_from_earth.

-- Tasks:

-- Create a database named universe
CREATE DATABASE universe;

-- Connect to your database with \c universe. Then, you should add tables named galaxy, star, planet, and moon
-- \ c universe;   -- \c is the command to connect to a database


-- Each table should have a primary key
-- Each primary key should automatically increment
-- Each table should have a name column
-- INT data type for at least two columns that are not a primary or foreign key
-- NUMERIC data type at least once
-- TEXT data type at least once
-- BOOLEAN data type on at least two columns

-- Creation of tables

CREATE TABLE galaxy(
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    no_of_stars_in_billions INT,
    age_in_billions_of_years NUMERIC,
    distance_from_earth_in_million_light_years INT,
    galaxy_types VARCHAR(50)
);

CREATE TABLE star(
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    no_of_planets INT,
    age_in_billions_of_years NUMERIC,
    distance_from_earth_in_light_years INT,
    galaxy_id INT,
    FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
);

CREATE TABLE planet(
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    has_water BOOLEAN,
    no_of_moons INT,
    age_in_billions_of_years NUMERIC,
    distance_from_earth INT,
    star_id INT,
    FOREIGN KEY (star_id) REFERENCES star(star_id)
);

CREATE TABLE moon(
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    age_in_billions_of_years NUMERIC,
    distance_from_earth INT,
    planet_id INT,
    FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
);

CREATE TABLE comet(
    comet_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    age_in_billions_of_years NUMERIC,
    star_id REFERENCES star(star_id)
);

-- Each "star" should have a foreign key that references one of the rows in galaxy
-- Each "planet" should have a foreign key that references one of the rows in star
-- Each "moon" should have a foreign key that references one of the rows in planet
-- Your database should have at least five tables
-- Each table should have at least three rows
-- The galaxy, star, planet, and moon tables should each have at least five columns
-- At least two columns per table should not accept NULL values
-- At least one column from each table should be required to be UNIQUE
-- All columns named name should be of type VARCHAR
-- Each primary key column should follow the naming convention table_name_id. For example, the moon table should have a primary key column named moon_id
-- Each foreign key column should have the same name as the column it is referencing
-- Each table should have at least three columns

-- The galaxy and star tables should each have at least six rows
