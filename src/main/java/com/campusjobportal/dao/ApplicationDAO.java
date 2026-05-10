package com.campusjobportal.dao;

import com.campusjobportal.model.Application;
import com.campusjobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ApplicationDAO {

    private static final Logger LOGGER = Logger.getLogger(ApplicationDAO.class.getName());

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

    public List<Application> findByStudentId(int studentId) {
        return getApplicationsByStudentId(studentId);
    }

    public Map<String, Application> getAllApplications() {
        Map<String, Application> applications = new HashMap<>();
        String query = "SELECT * FROM applications";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                Application app = new Application();
                app.setApplicationId(resultSet.getInt("application_id"));
                app.setJobId(resultSet.getInt("job_id"));
                app.setStudentId(resultSet.getInt("student_id"));
                app.setStatus(resultSet.getString("status"));
                app.setApplicationDate(resultSet.getString("application_date"));
                applications.put(String.valueOf(app.getApplicationId()), app);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all applications", e);
        }
        return applications;
    }

    public List<Application> getApplicationsByRecruiter(int recruiterId) {
        List<Application> applications = new ArrayList<>();
        String query = "SELECT a.* FROM applications a JOIN jobs j ON a.job_id = j.id WHERE j.recruiter_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, recruiterId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Application app = new Application();
                app.setApplicationId(resultSet.getInt("application_id"));
                app.setJobId(resultSet.getInt("job_id"));
                app.setStudentId(resultSet.getInt("student_id"));
                app.setStatus(resultSet.getString("status"));
                app.setApplicationDate(resultSet.getString("application_date"));
                applications.add(app);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting applications by recruiter: " + recruiterId, e);
        }
        return applications;
    }

    public Application getApplicationById(int applicationId) {
        String query = "SELECT * FROM applications WHERE application_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, applicationId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                Application app = new Application();
                app.setApplicationId(resultSet.getInt("application_id"));
                app.setJobId(resultSet.getInt("job_id"));
                app.setStudentId(resultSet.getInt("student_id"));
                app.setStatus(resultSet.getString("status"));
                app.setApplicationDate(resultSet.getString("application_date"));
                return app;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting application by id: " + applicationId, e);
        }
        return null;
    }

    public List<Application> findByRecruiterId(int recruiterId) {
        return getApplicationsByRecruiter(recruiterId);
    }

    public List<Application> findAll() {
        return new ArrayList<>(getAllApplications().values());
    }

    public int countAll() {
        return getAllApplications().size();
    }

    public Application findById(int applicationId) {
        return getApplicationById(applicationId);
    }

    public boolean updateStatus(int applicationId, String status) {
        String query = "UPDATE applications SET status = ? WHERE application_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, applicationId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating application status: " + applicationId, e);
            return false;
        }
    }
}
