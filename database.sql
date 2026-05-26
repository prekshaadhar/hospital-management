
DROP DATABASE IF EXISTS aarogya_hospital;

CREATE DATABASE aarogya_hospital;

USE aarogya_hospital;

CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    address VARCHAR(255),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    experience INT DEFAULT 0,
    contact VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Appointments (
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


CREATE TABLE HealthCheckups (
    checkup_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(100),
    phone VARCHAR(15),
    package VARCHAR(100),
    preferred_date DATE,
    preferred_time TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE ContactMessages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    subject VARCHAR(150),
    message TEXT,
    status ENUM('unread', 'read', 'replied') DEFAULT 'unread',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE DoctorAvailability (
    availability_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100),
    department VARCHAR(100),
    available_day VARCHAR(20),
    available_time_from TIME,
    available_time_to TIME
);


CREATE TABLE Billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);


INSERT INTO Patients
(name, email, phone, age, gender, address, message)
VALUES
('Ravi Kumar', 'ravi.kumar@example.com', '9876543210', 32, 'Male', 'New Delhi', 'Needs general consultation'),

('Anjali Sharma', 'anjali.sharma@example.com', '9876541230', 29, 'Female', 'Mumbai', 'Severe headache since 3 days'),

('Sunil Joshi', 'sunil.joshi@example.com', '9876501234', 45, 'Male', 'Bangalore', 'Follow-up for heart condition'),

('Meera Nair', 'meera.nair@example.com', '9876512345', 36, 'Female', 'Chennai', 'Migraine and balance issues'),

('Arvind Singh', 'arvind.singh@example.com', '9876523456', 59, 'Male', 'Hyderabad', 'Knee joint pain'),

('Tanya Sharma', 'tanya.sharma@example.com', '9876534567', 29, 'Female', 'Kolkata', 'General weakness and fatigue'),

('Harshit Patel', 'harshit.patel@example.com', '9876545678', 42, 'Male', 'Delhi', 'Routine full-body checkup'),

('Pooja Mehta', 'pooja.mehta@example.com', '9876556789', 30, 'Female', 'Pune', 'Pregnancy checkup and consultation'),

('Rohan Verma', 'rohan.verma@example.com', '9876567890', 4, 'Male', 'Jaipur', 'Regular child health checkup'),

('Aarav Sharma', 'aarav.sharma@example.com', '9876543210', 29, 'Male', 'Gurgaon', 'Routine consultation'),

('Priya Mehta', 'priya.mehta@example.com', '9898989898', 34, 'Female', 'Noida', 'Skin allergy issue'),

('Rahul Verma', 'rahul.verma@example.com', '9123456789', 40, 'Male', 'Lucknow', 'General fever and weakness');


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

('Dr. Aman Kapoor', 'Pediatrics', 'Neonatology', 6, 'aman.kapoor@aarogyahospital.com'),

('Dr. Sneha Rao', 'Cardiology', 'Cardiologist', 5, '9001234567 - sneha.rao@example.com'),

('Dr. Amit Desai', 'Dermatology', 'Dermatologist', 9, '9012345678 - amit.desai@example.com'),

('Dr. Neha Kapoor', 'Pediatrics', 'Pediatrician', 6, '9023456789 - neha.kapoor@example.com');


INSERT INTO Appointments
(patient_name, patient_email, patient_phone, department, doctor_name, appointment_date, appointment_time, message)
VALUES
('Ravi Kumar', 'ravi.kumar@example.com', '9876543210', 'General Medicine', 'Dr. Sneha Patil', '2025-04-11', '10:00:00', 'General consultation'),

('Anjali Sharma', 'anjali.sharma@example.com', '9876541230', 'Neurology', 'Dr. Arjun Rao', '2025-04-12', '11:30:00', 'Migraine issue'),

('Meera Nair', 'meera.nair@example.com', '9876512345', 'Neurology', 'Dr. Nidhi Varma', '2025-04-22', '11:30:00', 'Frequent headaches');


INSERT INTO HealthCheckups
(name, age, gender, email, phone, package, preferred_date, preferred_time)
VALUES
('Ravi Kumar', 32, 'Male', 'ravi.kumar@example.com', '9876543210', 'Basic Health Package', '2025-04-13', '09:30:00'),

('Anjali Sharma', 29, 'Female', 'anjali.sharma@example.com', '9876541230', 'Women Wellness Package', '2025-04-14', '11:00:00'),

('Vikas Reddy', 34, 'Male', 'vikas.reddy@gmail.com', '9876543210', 'Executive Package', '2025-04-20', '10:00:00');


INSERT INTO ContactMessages
(name, email, phone, subject, message, status)
VALUES
('Anita Rao', 'anita.rao@example.com', '9876001122', 'Appointment Query', 'I would like to reschedule my appointment.', 'unread'),

('Rakesh Yadav', 'rakesh.yadav@example.com', '9876003344', 'Doctor Availability', 'Is Dr. Karan Malhotra available on Saturday?', 'read'),

('Sneha Kapoor', 'sneha.kapoor@example.com', '9876005566', 'Health Checkup', 'Need information about your full-body checkup package.', 'unread'),

('Vikram Sinha', 'vikram.sinha@example.com', '9876007788', 'Feedback', 'Great experience with the hospital services!', 'replied');


INSERT INTO Admins
(username, password_hash, role)
VALUES
(
    'Dhriti&Prekshaa',
    SHA2('#dablu_bablu', 256),
    'admin'
);


INSERT INTO DoctorAvailability
(doctor_name, department, available_day, available_time_from, available_time_to)
VALUES
('Dr. Priya Mehta', 'Cardiology', 'Monday', '09:00:00', '01:00:00'),

('Dr. Arjun Rao', 'Neurology', 'Tuesday', '10:00:00', '03:00:00'),

('Dr. Sneha Patil', 'General Medicine', 'Wednesday', '08:00:00', '12:00:00');


INSERT INTO Billing
(patient_id, amount, status)
VALUES
(1, 2500.00, 'Paid'),
(2, 1800.00, 'Pending'),
(3, 3200.00, 'Paid');


SHOW TABLES;

SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Appointments;
SELECT * FROM HealthCheckups;
SELECT * FROM ContactMessages;
SELECT * FROM Admins;
SELECT * FROM DoctorAvailability;
SELECT * FROM Billing;