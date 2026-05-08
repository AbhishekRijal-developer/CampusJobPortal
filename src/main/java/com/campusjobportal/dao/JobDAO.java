package com.campusjobportal.dao;

import com.campusjobportal.model.Job;
import com.campusjobportal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    /**
     * Inserting a new job into database (Recruiter posts job)
     * @param job Job object containing job details
     * @return true if insert successful, false otherwise
     */
    public boolean insertJob(Job job) {
        String query = "INSERT INTO jobs (title, description, location, category, deadline, recruiter_id, created_date) " +
                "VALUES (?, ?, ?, ?, ?, ?, NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, job.getTitle());
            ps.setString(2, job.getDescription());
            ps.setString(3, job.getLocation());
            ps.setString(4, job.getCategory());
            ps.setDate(5, Date.valueOf(job.getDeadline()));
            ps.setInt(6, job.getRecruiterId());

            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieve all jobs posted by a specific recruiter
     * @param recruiterId ID of recruiter
     * @return List of Job objects
     */
    public List<Job> getJobsByRecruiter(int recruiterId) {
        List<Job> jobList = new ArrayList<>();
        String query = "SELECT * FROM jobs WHERE recruiter_id = ? ORDER BY created_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setDescription(rs.getString("description"));
                job.setLocation(rs.getString("location"));
                job.setCategory(rs.getString("category"));
                job.setDeadline(rs.getString("deadline"));
                job.setRecruiterId(rs.getInt("recruiter_id"));

                jobList.add(job);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jobList;
    }

    /**
     * Get job details by job ID
     * @param jobId Job ID
     * @return Job object if found, null otherwise
     */
    public Job getJobById(int jobId) {
        String query = "SELECT * FROM jobs WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setDescription(rs.getString("description"));
                job.setLocation(rs.getString("location"));
                job.setCategory(rs.getString("category"));
                job.setDeadline(rs.getString("deadline"));
                job.setRecruiterId(rs.getInt("recruiter_id"));

                return job;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Update job details (Recruiter edits job)
     * @param job Job object with updated details
     * @return true if update successful, false otherwise
     */
    public boolean updateJob(Job job) {
        String query = "UPDATE jobs SET title=?, description=?, location=?, category=?, deadline=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, job.getTitle());
            ps.setString(2, job.getDescription());
            ps.setString(3, job.getLocation());
            ps.setString(4, job.getCategory());
            ps.setDate(5, Date.valueOf(job.getDeadline()));
            ps.setInt(6, job.getId());

            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete a job by ID
     * @param jobId Job ID
     * @return true if delete successful, false otherwise
     */
    public boolean deleteJob(int jobId) {
        String query = "DELETE FROM jobs WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, jobId);
            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Count total jobs posted by recruiter (for dashboard analytics)
     * @param recruiterId Recruiter ID
     * @return total job count
     */
    public int getTotalJobsByRecruiter(int recruiterId) {
        String query = "SELECT COUNT(*) FROM jobs WHERE recruiter_id = ?";
        int count = 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    /**
     * Get all jobs for admin management view
     * @return List of all Job objects
     */
    public List<Job> getAllJobsForAdmin() {
        List<Job> jobList = new ArrayList<>();
        String query = "SELECT * FROM jobs ORDER BY created_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setDescription(rs.getString("description"));
                job.setLocation(rs.getString("location"));
                job.setCategory(rs.getString("category"));
                job.setDeadline(rs.getString("deadline"));
                job.setRecruiterId(rs.getInt("recruiter_id"));
                jobList.add(job);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jobList;
    }

    /**
     * Deactivate a job posting
     * @param jobId Job ID
     * @return true if deactivation successful, false otherwise
     */
    public boolean deactivateJob(int jobId) {
        String query = "UPDATE jobs SET status = 'INACTIVE' WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, jobId);
            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}