package com.campusjobportal.dao;

import com.campusjobportal.model.Application;
import com.campusjobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    /**
     * Get all applications submitted by a student
     * @param studentId Student ID
     * @return List of Application objects
     */
    public List<Application> getApplicationsByStudentId(int studentId) {
        List<Application> applications = new ArrayList<>();
        String query = "SELECT a.*, j.job_title, u.company_name FROM applications a " +
                       "JOIN jobs j ON a.job_id = j.job_id " +
                       "JOIN users u ON j.recruiter_id = u.user_id " +
                       "WHERE a.student_id = ? ORDER BY a.application_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setJobId(rs.getInt("job_id"));
                app.setStudentId(rs.getInt("student_id"));
                app.setStatus(rs.getString("status"));
                app.setApplicationDate(rs.getString("application_date"));
                app.setJobTitle(rs.getString("job_title"));
                app.setRecruiterName(rs.getString("company_name"));
                applications.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return applications;
    }

    /**
     * Get all applicants for a specific job
     * @param jobId Job ID
     * @return List of Application objects with applicant details
     */
    public List<Application> getApplicantsByJob(int jobId) {
        List<Application> applicants = new ArrayList<>();
        String query = "SELECT a.*, u.first_name, u.last_name, u.email, u.phone_number FROM applications a " +
                       "JOIN users u ON a.student_id = u.user_id " +
                       "WHERE a.job_id = ? ORDER BY a.application_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, jobId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setJobId(rs.getInt("job_id"));
                app.setStudentId(rs.getInt("student_id"));
                app.setStatus(rs.getString("status"));
                app.setApplicationDate(rs.getString("application_date"));
                app.setStudentName(rs.getString("first_name") + " " + rs.getString("last_name"));
                applicants.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return applicants;
    }

    /**
     * Insert a new application
     * @param application Application object
     * @return true if insertion successful, false otherwise
     */
    public boolean insertApplication(Application application) {
        String query = "INSERT INTO applications (job_id, student_id, status, application_date) " +
                       "VALUES (?, ?, ?, NOW())";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, application.getJobId());
            stmt.setInt(2, application.getStudentId());
            stmt.setString(3, application.getStatus() != null ? application.getStatus() : "PENDING");
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update application status
     * @param applicationId Application ID
     * @param status New status
     * @return true if update successful, false otherwise
     */
    public boolean updateApplicationStatus(int applicationId, String status) {
        String query = "UPDATE applications SET status = ? WHERE application_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, applicationId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete an application
     * @param applicationId Application ID
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteApplication(int applicationId) {
        String query = "DELETE FROM applications WHERE application_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, applicationId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
