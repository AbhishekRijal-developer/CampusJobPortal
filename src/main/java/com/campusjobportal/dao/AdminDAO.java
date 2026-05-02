package com.campusjobportal.dao;

import com.campusjobportal.model.Application;
import com.campusjobportal.model.User;
import com.campusjobportal.model.Job;
import com.campusjobportal.model.Complaint;
import com.campusjobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDAO {

    public Map<String, Integer> getDashboardStats() {
        Map<String, Integer> stats = new HashMap<>();
        String queries[] = {
            "SELECT COUNT(*) as count FROM users WHERE user_type = 'STUDENT'",
            "SELECT COUNT(*) as count FROM users WHERE user_type = 'RECRUITER'",
            "SELECT COUNT(*) as count FROM jobs WHERE approval_status = 'APPROVED'",
            "SELECT COUNT(*) as count FROM applications",
            "SELECT COUNT(*) as count FROM users WHERE approval_status = 'PENDING' AND user_type = 'RECRUITER'",
            "SELECT COUNT(*) as count FROM jobs WHERE approval_status = 'PENDING'"
        };
        String keys[] = {"totalStudents", "totalRecruiters", "activeJobs", "totalApplications", "pendingRecruiters", "pendingJobs"};

        try (Connection conn = DBConnection.getConnection()) {
            for (int i = 0; i < queries.length; i++) {
                try (PreparedStatement stmt = conn.prepareStatement(queries[i]);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        stats.put(keys[i], rs.getInt("count"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users ORDER BY created_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setUserType(rs.getString("user_type"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setCompanyName(rs.getString("company_name"));
                user.setActive(rs.getBoolean("is_active"));
                user.setApprovalStatus(rs.getString("approval_status"));
                user.setCreatedDate(rs.getString("created_date"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean updateUserStatus(int userId, boolean isActive, String approvalStatus) {
        String query = "UPDATE users SET is_active = ?, approval_status = ? WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setBoolean(1, isActive);
            stmt.setString(2, approvalStatus);
            stmt.setInt(3, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Job> getAllJobs() {
        List<Job> jobs = new ArrayList<>();
        String query = "SELECT j.*, u.company_name FROM jobs j JOIN users u ON j.recruiter_id = u.user_id ORDER BY j.posted_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("job_id"));
                job.setTitle(rs.getString("job_title"));
                job.setDescription(rs.getString("job_description"));
                job.setLocation(rs.getString("location"));
                job.setCategory(rs.getString("employment_type"));
                job.setDeadline(rs.getString("deadline"));
                job.setRecruiterId(rs.getInt("recruiter_id"));
                job.setApprovalStatus(rs.getString("approval_status"));
                jobs.add(job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return jobs;
    }

    public boolean updateJobStatus(int jobId, String approvalStatus) {
        String query = "UPDATE jobs SET approval_status = ? WHERE job_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, approvalStatus);
            stmt.setInt(2, jobId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Complaint> getAllComplaints() {
        List<Complaint> complaints = new ArrayList<>();
        String query = "SELECT c.*, u.first_name, u.last_name FROM complaints c JOIN users u ON c.user_id = u.user_id ORDER BY c.created_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaint_id"));
                complaint.setUserId(rs.getInt("user_id"));
                complaint.setUserName(rs.getString("first_name") + " " + rs.getString("last_name"));
                complaint.setSubject(rs.getString("subject"));
                complaint.setDescription(rs.getString("description"));
                complaint.setAdminResponse(rs.getString("admin_response"));
                complaint.setStatus(rs.getString("status"));
                complaint.setCreatedDate(rs.getTimestamp("created_date"));
                complaints.add(complaint);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return complaints;
    }

    public boolean resolveComplaint(int complaintId, String response) {
        String query = "UPDATE complaints SET status = 'RESOLVED', admin_response = ? WHERE complaint_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, response);
            stmt.setInt(2, complaintId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Application> getAllApplications() {
        List<Application> applications = new ArrayList<>();
        String query = "SELECT a.application_id, a.job_id, a.student_id, a.status, a.application_date, " +
                       "j.job_title, u.first_name, u.last_name, r.company_name " +
                       "FROM applications a " +
                       "JOIN jobs j ON a.job_id = j.job_id " +
                       "JOIN users u ON a.student_id = u.user_id " +
                       "JOIN users r ON j.recruiter_id = r.user_id " +
                       "ORDER BY a.application_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setJobId(rs.getInt("job_id"));
                app.setStudentId(rs.getInt("student_id"));
                app.setStatus(rs.getString("status"));
                app.setApplicationDate(rs.getTimestamp("application_date").toString());
                app.setJobTitle(rs.getString("job_title"));
                app.setStudentName(rs.getString("first_name") + " " + rs.getString("last_name"));
                app.setRecruiterName(rs.getString("company_name"));
                applications.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applications;
    }

    public void logAction(int adminId, String action, String targetType, int targetId, String details) {
        String query = "INSERT INTO audit_logs (admin_id, action, target_type, target_id, details) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, adminId);
            stmt.setString(2, action);
            stmt.setString(3, targetType);
            stmt.setInt(4, targetId);
            stmt.setString(5, details);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
