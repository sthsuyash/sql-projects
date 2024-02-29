-- Create the database --
CREATE DATABASE hospital_management_system;

-- Creating user --
CREATE USER IF NOT EXISTS 'hms_user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON hospital_management.* TO 'hms_user'@'localhost';
FLUSH PRIVILEGES;

-- Use the created database --
USE hospital_management_system;

-- Creating schemas --
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(255),
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    contact_number VARCHAR(10)
);

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(255),
    specialization VARCHAR(100),
    contact_number VARCHAR(15)
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    FOREIGN KEY (patient_id)
        REFERENCES patients (patient_id)
        ON DELETE CASCADE,
    FOREIGN KEY (doctor_id)
        REFERENCES doctors (doctor_id)
        ON DELETE CASCADE
);

CREATE TABLE medical_records (
    record_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT,
    prescription TEXT,
    FOREIGN KEY (patient_id)
        REFERENCES patients (patient_id)
        ON DELETE CASCADE,
    FOREIGN KEY (doctor_id)
        REFERENCES doctors (doctor_id)
        ON DELETE CASCADE
);

-- Create operations --
INSERT INTO patients (patient_id, name, dob, gender, contact_number)
VALUES (1, 'Shan Subedi', '1990-05-15', 'Male', '9841984190'),
(2, 'Shanta Sharma', '1985-08-20', 'Female', '9841984167'),
(3, 'Hari Thapa', '1992-03-10', 'Male', '9841984196');

INSERT INTO doctors (doctor_id, name, specialization, contact_number)
VALUES (1, 'Dr. Shah', 'Cardiologist', '9841984111'),
(2, 'Dr. Sharma', 'Pediatrician', '9841984112'),
(3, 'Dr. Adhikari', 'Orthopedic Surgeon', '9841984123');

INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date)
VALUES (1, 1, 1, '2024-03-01 10:00:00'),
(2, 2, 2, '2024-03-02 11:30:00'),
(3, 3, 3, '2024-03-03 14:00:00');
       
INSERT INTO medical_records (record_id, patient_id, doctor_id, diagnosis, prescription)
VALUES (1, 1, 1, 'High blood pressure', 'Prescribe medication X'),
(2, 2, 2, 'Common cold', 'Rest and fluids'),
(3, 3, 3, 'Fractured arm', 'Prescribe pain medication');

-- Read operations --
SELECT * FROM patients;
SELECT * FROM doctors;
SELECT * FROM appointments;
SELECT * FROM medical_records;

-- Update operations --
UPDATE patients SET contact_number = '9841984198' WHERE patient_id = 1;
UPDATE doctors SET contact_number = '9841984199' WHERE doctor_id = 1;

-- Delete operations --
DELETE FROM patients WHERE patient_id = 1;
DELETE FROM doctors WHERE doctor_id = 1;

