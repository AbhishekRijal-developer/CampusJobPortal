@echo off
setlocal enabledelayedexpansion

REM Database credentials
set MYSQL_PATH="C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
set DB_USER=root
set DB_PASSWORD=1234
set DB_NAME=campus_job_portal

echo.
echo =========================================
echo Creating student_profiles table...
echo =========================================

REM Create the student_profiles table
%MYSQL_PATH% -u %DB_USER% -p%DB_PASSWORD% %DB_NAME% -e "CREATE TABLE IF NOT EXISTS student_profiles (profile_id INT PRIMARY KEY AUTO_INCREMENT,user_id INT NOT NULL UNIQUE,location VARCHAR(100),date_of_birth DATE,institution VARCHAR(200),degree VARCHAR(100),field_of_study VARCHAR(100),expected_graduation INT,gpa DECIMAL(3,2),skills LONGTEXT,company_name VARCHAR(100),position VARCHAR(100),start_date DATE,end_date DATE,work_description LONGTEXT,bio LONGTEXT,created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,INDEX idx_user_id (user_id));"

echo.
echo Checking if table was created...
%MYSQL_PATH% -u %DB_USER% -p%DB_PASSWORD% %DB_NAME% -e "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '%DB_NAME%' AND TABLE_NAME = 'student_profiles';"

echo.
echo =========================================
echo Student profiles table initialization complete!
echo =========================================
pause
