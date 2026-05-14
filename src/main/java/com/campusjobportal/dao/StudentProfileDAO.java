package com.campusjobportal.dao;

import com.campusjobportal.model.StudentProfile;
import com.campusjobportal.util.DBConnection;
import java.sql.*;

public class StudentProfileDAO {
    
    // Initialize the database table if it doesn't exist
    static {
        createTableIfNotExists();
    }

    // Create or update student profile
    public boolean saveProfile(StudentProfile profile) {
        String checkQuery = "SELECT * FROM student_profiles WHERE user_id = ?";
        String insertQuery = "INSERT INTO student_profiles (user_id, location, date_of_birth, institution, degree, field_of_study, expected_graduation, gpa, skills, company_name, position, start_date, end_date, work_description, bio, cv_file_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String updateQuery = "UPDATE student_profiles SET location = ?, date_of_birth = ?, institution = ?, degree = ?, field_of_study = ?, expected_graduation = ?, gpa = ?, skills = ?, company_name = ?, position = ?, start_date = ?, end_date = ?, work_description = ?, bio = ?, cv_file_path = ?, updated_date = CURRENT_TIMESTAMP WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            // Check if profile exists
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setInt(1, profile.getUserId());
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Update existing profile
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setString(1, profile.getLocation());
                updateStmt.setDate(2, profile.getDateOfBirth());
                updateStmt.setString(3, profile.getInstitution());
                updateStmt.setString(4, profile.getDegree());
                updateStmt.setString(5, profile.getFieldOfStudy());
                updateStmt.setInt(6, profile.getExpectedGraduation());
                updateStmt.setDouble(7, profile.getGpa());
                updateStmt.setString(8, profile.getSkills());
                updateStmt.setString(9, profile.getCompanyName());
                updateStmt.setString(10, profile.getPosition());
                updateStmt.setDate(11, profile.getStartDate());
                updateStmt.setDate(12, profile.getEndDate());
                updateStmt.setString(13, profile.getWorkDescription());
                updateStmt.setString(14, profile.getBio());
                updateStmt.setString(15, profile.getCvFilePath());
                updateStmt.setInt(16, profile.getUserId());

                return updateStmt.executeUpdate() > 0;
            } else {
                // Insert new profile
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setInt(1, profile.getUserId());
                insertStmt.setString(2, profile.getLocation());
                insertStmt.setDate(3, profile.getDateOfBirth());
                insertStmt.setString(4, profile.getInstitution());
                insertStmt.setString(5, profile.getDegree());
                insertStmt.setString(6, profile.getFieldOfStudy());
                insertStmt.setInt(7, profile.getExpectedGraduation());
                insertStmt.setDouble(8, profile.getGpa());
                insertStmt.setString(9, profile.getSkills());
                insertStmt.setString(10, profile.getCompanyName());
                insertStmt.setString(11, profile.getPosition());
                insertStmt.setDate(12, profile.getStartDate());
                insertStmt.setDate(13, profile.getEndDate());
                insertStmt.setString(14, profile.getWorkDescription());
                insertStmt.setString(15, profile.getBio());
                insertStmt.setString(16, profile.getCvFilePath());

                return insertStmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get student profile by user ID
    public StudentProfile getProfileByUserId(int userId) {
        String query = "SELECT * FROM student_profiles WHERE user_id = ?";
        StudentProfile profile = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                profile = new StudentProfile();
                profile.setProfileId(rs.getInt("profile_id"));
                profile.setUserId(rs.getInt("user_id"));
                profile.setLocation(rs.getString("location"));
                profile.setDateOfBirth(rs.getDate("date_of_birth"));
                profile.setInstitution(rs.getString("institution"));
                profile.setDegree(rs.getString("degree"));
                profile.setFieldOfStudy(rs.getString("field_of_study"));
                profile.setExpectedGraduation(rs.getInt("expected_graduation"));
                profile.setGpa(rs.getDouble("gpa"));
                profile.setSkills(rs.getString("skills"));
                profile.setCompanyName(rs.getString("company_name"));
                profile.setPosition(rs.getString("position"));
                profile.setStartDate(rs.getDate("start_date"));
                profile.setEndDate(rs.getDate("end_date"));
                profile.setWorkDescription(rs.getString("work_description"));
                profile.setBio(rs.getString("bio"));
                profile.setCvFilePath(rs.getString("cv_file_path"));
                profile.setCreatedDate(rs.getString("created_date"));
                profile.setUpdatedDate(rs.getString("updated_date"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return profile;
    }

    // Delete student profile
    public boolean deleteProfile(int userId) {
        String query = "DELETE FROM student_profiles WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Auto-create the table if it doesn't exist
    private static void createTableIfNotExists() {
        String createTableQuery = "CREATE TABLE IF NOT EXISTS student_profiles (" +
                "profile_id INT PRIMARY KEY AUTO_INCREMENT," +
                "user_id INT NOT NULL UNIQUE," +
                "location VARCHAR(100)," +
                "date_of_birth DATE," +
                "institution VARCHAR(200)," +
                "degree VARCHAR(100)," +
                "field_of_study VARCHAR(100)," +
                "expected_graduation INT," +
                "gpa DECIMAL(3,2)," +
                "skills LONGTEXT," +
                "company_name VARCHAR(100)," +
                "position VARCHAR(100)," +
                "start_date DATE," +
                "end_date DATE," +
                "work_description LONGTEXT," +
                "bio LONGTEXT," +
                "cv_file_path VARCHAR(500)," +
                "created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                "updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP," +
                "FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE," +
                "INDEX idx_user_id (user_id)" +
                ")";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(createTableQuery);
            System.out.println("✓ Student profiles table created or already exists!");
        } catch (SQLException e) {
            System.err.println("✗ Error creating student_profiles table: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
