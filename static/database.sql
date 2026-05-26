-- =========================================================
-- AAROGYA HOSPITAL MANAGEMENT SYSTEM DATABASE
-- =========================================================

CREATE DATABASE IF NOT EXISTS aarogya_hospital;
USE aarogya_hospital;

-- =========================================================
-- 1. PATIENTS TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    address VARCHAR(255),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- 2. DOCTORS TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    experience INT DEFAULT 0,
    contact VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- 3. APPOINTMENTS TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    patient_email VARCHAR(100),
    patient_phone VARCHAR(15),
    department VARCHAR(100),
    doctor_name VARCHAR(100),
    appointment_date DATE,
    appointment_time TIME,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- 4. HEALTH CHECKUPS TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS HealthCheckups (
    checkup_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15),
    email VARCHAR(100),
    package VARCHAR(100),
    preferred_date DATE,
    preferred_time TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- 5. CONTACT MESSAGES TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS ContactMessages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    subject VARCHAR(100),
    message TEXT,
    status ENUM('unread', 'read', 'replied') DEFAULT 'unread',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- 6. ADMINS TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS Admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- 7. DOCTOR AVAILABILITY TABLE
-- =========================================================

CREATE TABLE IF NOT EXISTS DoctorAvailability (
    availability_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100),
    department VARCHAR(100),
    available_day VARCHAR(20),
    available_time_from TIME,
    available_time_to TIME
);

-- =========================================================
-- SAMPLE DATA
-- =========================================================

-- ======================
-- INSERT PATIENTS
-- ======================

INSERT INTO Patients
(name, email, phone, age, gender, address, message)
VALUES
('Ravi Kumar', 'ravi.kumar@example.com', '9876543210', 32, 'Male', 'Bangalore', 'Needs general consultation'),

('Anjali Sharma', 'anjali.sharma@example.com', '9876541230', 29, 'Female', 'Mumbai', 'Severe headache since 3 days'),

('Sunil Joshi', 'sunil.joshi@example.com', '9876501234', 45, 'Male', 'Delhi', 'Heart follow-up consultation');

-- ======================
-- INSERT DOCTORS
-- ======================

INSERT INTO Doctors
(name, department, specialization, experience, contact)
VALUES
('Dr. Priya Mehta', 'Cardiology', 'Interventional Cardiology', 10, 'priya.mehta@aarogyahospital.com'),

('Dr. Arjun Rao', 'Neurology', 'Pediatric Neurology', 12, 'arjun.rao@aarogyahospital.com'),

('Dr. Sneha Patil', 'General Medicine', 'Internal Medicine', 8, 'sneha.patil@aarogyahospital.com'),

('Dr. Karan Malhotra', 'Cardiology', 'Heart Failure Management', 15, 'karan.malhotra@aarogyahospital.com'),

('Dr. Nidhi Varma', 'Neurology', 'Epilepsy and Seizure Disorders', 7, 'nidhi.varma@aarogyahospital.com'),

('Dr. Rajeev Menon', 'Orthopedics', 'Joint Replacement Surgery', 20, 'rajeev.menon@aarogyahospital.com'),

('Dr. Anuja Desai', 'General Medicine', 'Chronic Disease Management', 11, 'anuja.desai@aarogyahospital.com'),

('Dr. Meenal Khosla', 'Diagnostics', 'Radiology & Imaging', 9, 'meenal.khosla@aarogyahospital.com'),

('Dr. Ruchi Bansal', 'Gynecology & Obstetrics', 'Prenatal & Postnatal Care', 13, 'ruchi.bansal@aarogyahospital.com'),

('Dr. Aman Kapoor', 'Pediatrics', 'Neonatology', 6, 'aman.kapoor@aarogyahospital.com');

-- ======================
-- INSERT APPOINTMENTS
-- ======================

INSERT INTO Appointments
(patient_name, patient_email, patient_phone, department, doctor_name, appointment_date, appointment_time, message)
VALUES
('Ravi Kumar', 'ravi.kumar@example.com', '9876543210', 'General Medicine', 'Dr. Sneha Patil', '2025-04-11', '10:00:00', 'General consultation'),

('Anjali Sharma', 'anjali.sharma@example.com', '9876541230', 'Neurology', 'Dr. Arjun Rao', '2025-04-12', '11:30:00', 'Migraine issue');

-- ======================
-- INSERT HEALTH CHECKUPS
-- ======================

INSERT INTO HealthCheckups
(name, age, gender, phone, email, package, preferred_date, preferred_time)
VALUES
('Ravi Kumar', 32, 'Male', '9876543210', 'ravi.kumar@example.com', 'Basic Health Package', '2025-04-13', '09:30:00'),

('Anjali Sharma', 29, 'Female', '9876541230', 'anjali.sharma@example.com', 'Women Wellness Package', '2025-04-14', '11:00:00');

-- ======================
-- INSERT CONTACT MESSAGES
-- ======================

INSERT INTO ContactMessages
(name, email, phone, subject, message, status)
VALUES
('Anita Rao', 'anita.rao@example.com', '9876001122', 'Appointment Query', 'I would like to reschedule my appointment.', 'unread'),

('Rakesh Yadav', 'rakesh.yadav@example.com', '9876003344', 'Doctor Availability', 'Is Dr. Karan Malhotra available on Saturday?', 'read');

-- ======================
-- INSERT ADMIN
-- Password = #dablu_bablu
-- SHA256 HASH USED
-- ======================

INSERT INTO Admins
(username, password_hash, role)
VALUES
(
    'Dhriti&Prekshaa',
    '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
    'admin'
);

-- ======================
-- INSERT DOCTOR AVAILABILITY
-- ======================

INSERT INTO DoctorAvailability
(doctor_name, department, available_day, available_time_from, available_time_to)
VALUES
('Dr. Priya Mehta', 'Cardiology', 'Monday', '09:00:00', '01:00:00'),

('Dr. Arjun Rao', 'Neurology', 'Tuesday', '10:00:00', '03:00:00'),

('Dr. Sneha Patil', 'General Medicine', 'Wednesday', '08:00:00', '12:00:00');

-- =========================================================
-- VERIFY TABLES
-- =========================================================

SHOW TABLES;

SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Appointments;
SELECT * FROM HealthCheckups;
SELECT * FROM ContactMessages;
SELECT * FROM Admins;
SELECT * FROM DoctorAvailability;