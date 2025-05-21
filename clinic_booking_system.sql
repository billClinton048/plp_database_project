-- Dropping tables if they exist 

DROP TABLE IF EXISTS prescription, appointment, patient, doctor, specialization, treatment_medical, treatment, medication

-- Specialization Table
CREATE TABLE specialization (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Doctor Table
CREATE TABLE doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    specialization_id INT,
    FOREIGN KEY (specialization_id) REFERENCES specialization(specialization_id)
);

-- Patient Table
CREATE TABLE patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Appointment Table
CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

-- Medication Table
CREATE TABLE medication (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Treatment Table
CREATE TABLE treatment (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    diagnosis TEXT NOT NULL,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- Treatment_Medication Junction Table (Many-to-Many)
CREATE TABLE treatment_medication (
    treatment_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(100),
    PRIMARY KEY (treatment_id, medication_id),
    FOREIGN KEY (treatment_id) REFERENCES treatment(treatment_id),
    FOREIGN KEY (medication_id) REFERENCES medication(medication_id)
);

-- Prescription Table
CREATE TABLE prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id),
    FOREIGN KEY (medication_id) REFERENCES medication(medication_id)
);