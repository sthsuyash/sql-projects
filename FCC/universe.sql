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

INSERT INTO galaxy (name, description, no_of_stars_in_billions, age_in_billions_of_years, distance_from_earth_in_million_light_years, galaxy_types) 
VALUES 
('Milky Way Galaxy', 'Our galaxy', 200, 13.7, 0, 'Barred Spiral'),
('Andromeda Galaxy', 'The nearest galaxy to the Milky Way. Also known as Messier 31', 1000, 10, 2.5, 'Spiral'),
('Triangulum Galaxy', 'Also known as Messier 33', 50, 13, 3, 'Spiral'),
('Whirlpool Galaxy', 'Also known as Messier 51', 100, 13, 23, 'Spiral');
('Sombrero Galaxy', 'Also known as Messier 104', 800, 10, 28, 'Elliptical'),
('Large Magellanic Cloud Galaxy', 'Dwarf irregular shaped galaxy', 10, 13, 0.16, 'Irregular'),

-- stars 

INSERT INTO star (name, description, no_of_planets, age_in_billions_of_years, distance_from_earth_in_light_years, galaxy_id)
VALUES
('Sun', 'G-type main-sequence star.', 8, 4.6, NULL, 1),
('Proxima Centauri', 'Red dwarf star that is part of the Alpha Centauri system', 1, 4.85, 4.24, 1),
('Sirius', 'Binary star system consisting of a main-sequence star, Sirius A, and a white dwarf, Sirius B. It is located in the Canis Major constellation', NULL, 4.6, 8.6, 1),
('Kepler-90', 'F-type main-sequence star located in the Kepler-90 system, which is located in the Cygnus constellation.', 8, 2.7, 2545, 1)
('TRAPPIST-1', 'Ultra-cool red dwarf star located in the Aquarius constellation.', 7, 7.6, 39, 1),
('Tau Ceti', 'G-type main-sequence star located in the Cetus constellation.',4, 7.6, 11.9, 1);

