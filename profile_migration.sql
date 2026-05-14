-- Student Profile Migration Script
-- Add detailed profile table for students

CREATE TABLE IF NOT EXISTS student_profiles (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    location VARCHAR(100),
    date_of_birth DATE,
    institution VARCHAR(200),
    degree VARCHAR(100),
    field_of_study VARCHAR(100),
    expected_graduation INT,
    gpa DECIMAL(3,2),
    skills LONGTEXT,
    company_name VARCHAR(100),
    position VARCHAR(100),
    start_date DATE,
    end_date DATE,
    work_description LONGTEXT,
    bio LONGTEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
);

-- Show status
SELECT 'Student profiles table created successfully!' AS status;
