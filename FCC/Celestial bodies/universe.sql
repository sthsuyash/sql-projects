-- Building a celestial bodies database project --

-- For this project, log in to PostgreSQL with psql to create the database. 
-- Do that by entering psql -U <username> -d <db-name> in the terminal. 

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

-- The planet table should have at least 12 rows

INSERT INTO planet (name, description, has_water, no_of_moons, age_in_billions_of_years, distance_from_earth, star_id)
VALUES
('Earth', 'Earth is a terrestrial planet in our solar system that contains water, as well as an atmosphere that supports life.', TRUE, 1, 4.5, NULL, 1),
('Mercury', 'Mercury is a terrestrial planet in our solar system that has a thin atmosphere and is the closest planet to the Sun.', FALSE, 0, 4.5, NULL, 1),
('Venus', 'Venus is a terrestrial planet in our solar system that has a thick atmosphere that traps heat, making it the hottest planet in our solar system.', TRUE, 0, 4.5, 0.7, 1),
('Mars', 'Mars is a terrestrial planet in our solar system that is believed to have once contained water on its surface.', TRUE, 2, 4.6, 1.5, 1),
('Jupiter', 'Jupiter is a gas giant planet in our solar system that has a large number of moons, including four large moons known as the Galilean moons.', FALSE, 79, 4.5, 5.2, 1),
('Saturn', 'Saturn is a gas giant planet in our solar system that is known for its rings, which are made up of ice particles and rock. It has numerous moons, including the largest moon in our solar system, Titan.', FALSE, 82, 4.5, 9.5, 1),
('Uranus', 'Uranus is a gas giant planet in our solar system that is tilted on its side, causing it to have extreme seasonal variations.', FALSE, 27, 4.5, 19.2, 1),
('Neptune', 'Neptune is a gas giant planet in our solar system that is known for its blue coloration and high winds.', FALSE, 14, 4.5, 30.1, 1),
('Kepler-22b', 'Kepler-22b is an exoplanet located in the habitable zone of a star.', TRUE, NULL, NULL, 600, NULL),
('TRAPPIST-1d', 'TRAPPIST-1d is an exoplanet located in the habitable zone of the TRAPPIST-1 star.', NULL, NULL, NULL, 39, 5),
('Gliese 581d', 'Gliese 581d is an exoplanet located in the habitable zone of the Gliese 581 star', TRUE, NULL, NULL, 20.5, NULL),
('Kepler-186f', 'Kepler-186f is an exoplanet located in the habitable zone of the Kepler-186 star.', TRUE, NULL, NULL, 500, NULL);

-- The moon table should have at least 20 rows
INSERT INTO moon(name, description, age_in_billions_of_years, distance_from_earth, planet_id)
VALUES
('Moon', 'The Moon is the only natural satellite of Earth and the fifth largest moon in the Solar System.', 4.5, NULL, 1),
('Phobos', 'Phobos is the larger of the two natural satellites of Mars and is the only moon in the Solar System known to be captured by a planet.', 4.6, 9.4, 4),
('Deimos', 'Deimos is the smaller of the two natural satellites of Mars and is the only moon in the Solar System known to be captured by a planet.', 4.6, 23.4, 4),
('Io', 'Io is the innermost of the four Galilean moons of Jupiter and is the third largest moon in the Solar System.', 4.5, 421.8, 5),
('Europa', 'Europa is the second innermost of the four Galilean moons of Jupiter and is the sixth largest moon in the Solar System.', 4.5, 671.1, 5),
('Ganymede', 'Ganymede is the third innermost of the four Galilean moons of Jupiter and is the largest moon in the Solar System.', 4.5, 1070.4, 5),
('Callisto', 'Callisto is the outermost of the four Galilean moons of Jupiter and is the second largest moon in the Solar System.', 4.5, 1882.7, 5),
('Mimas', 'Mimas is the innermost of the four Galilean moons of Saturn and is the smallest moon in the Solar System.', 4.5, 185539, 6),
('Enceladus', 'Enceladus is the second innermost of the four Galilean moons of Saturn and is the sixth largest moon in the Solar System.', 4.5, 237948, 6),
('Tethys', 'Tethys is the third innermost of the four Galilean moons of Saturn and is the seventh largest moon in the Solar System.', 4.5, 294619, 6),
('Dione', 'Dione is the fourth innermost of the four Galilean moons of Saturn and is the eighth largest moon in the Solar System.', 4.5, 377396, 6),
('Rhea', 'Rhea is the fifth innermost of the four Galilean moons of Saturn and is the ninth largest moon in the Solar System.', 4.5, 527108, 6),
('Titan', 'Titan is the largest moon of Saturn and is the second largest moon in the Solar System.', 4.5, 1221870, 6),
('Iapetus', 'Iapetus is the outermost of the four Galilean moons of Saturn and is the 15th largest moon in the Solar System.', 4.5, 3560820, 6),
('Miranda', 'Miranda is the innermost of the four Galilean moons of Uranus and is the eighth largest moon in the Solar System.', 4.5, 129390, 7),
('Ariel', 'Ariel is the second innermost of the four Galilean moons of Uranus and is the ninth largest moon in the Solar System.', 4.5, 191020, 7),
('Umbriel', 'Umbriel is the third innermost of the four Galilean moons of Uranus and is the tenth largest moon in the Solar System.', 4.5, 266000, 7),
('Titania', 'Titania is the fourth innermost of the four Galilean moons of Uranus and is the 11th largest moon in the Solar System.', 4.5, 435910, 7),
('Oberon', 'Oberon is the outermost of the four Galilean moons of Uranus and is the 12th largest moon in the Solar System.', 4.5, 583520, 7),
('Triton', 'Triton is the largest moon of Neptune and is the 27th largest moon in the Solar System.', 4.5, 354759, 8);

-- comets

INSERT INTO comet (name, description, age_in_billions_of_years, star_id)
VALUES
('Halleys Comet', 'Halleys Comet is the most famous comet and has an orbit that brings it close to Earth roughly every 76 years. Estimated the same age as the solar system.', 4.6, 1),
('Comet Hale-Bopp' 'Comet Hale-Bopp was one of the brightest comets ever observed and was visible to the naked eye for a record-breaking 18 months in 1996 and 1997.', 4.5, 1),
('Comet Lovejoy', 'Comet Lovejoy was discovered in 2011 and became visible to the naked eye in 2013.', 4.5, 1)
