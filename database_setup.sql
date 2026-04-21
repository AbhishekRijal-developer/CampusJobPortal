-- Campus Job Portal Database Initialization Script
-- Create and initialize the database with required tables

CREATE DATABASE IF NOT EXISTS campus_job_portal;
USE campus_job_portal;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS applications;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS users;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_type ENUM('STUDENT', 'RECRUITER', 'ADMIN') NOT NULL,
    phone_number VARCHAR(20),
    company_name VARCHAR(100),
    resume_path VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_user_type (user_type)
);

-- Jobs Table
CREATE TABLE jobs (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    recruiter_id INT NOT NULL,
    job_title VARCHAR(200) NOT NULL,
    job_description LONGTEXT NOT NULL,
    location VARCHAR(100) NOT NULL,
    employment_type VARCHAR(50) NOT NULL,
    salary_range VARCHAR(100),
    qualifications LONGTEXT,
    skills LONGTEXT,
    deadline DATE NOT NULL,
    applications_count INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    posted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (recruiter_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_recruiter_id (recruiter_id),
    INDEX idx_is_active (is_active),
    INDEX idx_posted_date (posted_date)
);

-- Applications Table
CREATE TABLE applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT NOT NULL,
    student_id INT NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED', 'WITHDRAWN') DEFAULT 'PENDING',
    cover_letter LONGTEXT,
    resume_path VARCHAR(255),
    application_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_job_id (job_id),
    INDEX idx_student_id (student_id),
    INDEX idx_status (status),
    INDEX idx_application_date (application_date),
    UNIQUE KEY unique_application (job_id, student_id)
);

-- Sample test data (optional)
-- Insert test users
INSERT INTO users (first_name, last_name, email, password, user_type, phone_number, is_active) VALUES
('John', 'Doe', 'john.doe@email.com', 'password123', 'STUDENT', '1234567890', TRUE),
('Jane', 'Smith', 'jane.smith@email.com', 'password123', 'RECRUITER', '9876543210', TRUE),
('Admin', 'User', 'admin@email.com', 'admin123', 'ADMIN', '5555555555', TRUE);

-- Insert sample jobs
INSERT INTO jobs (recruiter_id, job_title, job_description, location, employment_type, salary_range, qualifications, skills, deadline, is_active) VALUES
(2, 'Software Developer', 'We are looking for a talented software developer to join our team.', 'New York', 'FULL_TIME', '$60,000 - $80,000', 'B.Tech in Computer Science', 'Java, Python, SQL', '2024-06-30', TRUE),
(2, 'Data Analyst', 'Analyze and interpret complex data sets.', 'San Francisco', 'FULL_TIME', '$50,000 - $70,000', 'Bachelor in Statistics or related field', 'SQL, Python, Tableau', '2024-07-15', TRUE);

-- Show status
SELECT 'Database initialization completed successfully!' AS status;
SELECT COUNT(*) as total_users FROM users;
SELECT COUNT(*) as total_jobs FROM jobs;applications
