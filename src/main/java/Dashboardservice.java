package com.campusjob.service;

import com.campusjob.dao.ApplicationDAO;
import com.campusjob.dao.JobDAO;
import com.campusjob.dao.UserDAO;
import com.campusjob.model.Job;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * DashboardService.java
 * Aggregates statistics and summary data for all three dashboard views:
 *  - Admin Dashboard
 *  - Recruiter Dashboard
 *  - Student Dashboard
 *
 * Each public method returns a simple Map<String, Object> so the
 * corresponding JSP can use JSTL EL expressions directly:
 *   ${stats.totalStudents}, ${stats.activeJobs}, etc.
 *
 * Author: Prabesh Adhikari
 * Project: Campus Job Portal System
 */
public class DashboardService {

    private final UserDAO        userDAO;
    private final JobDAO         jobDAO;
    private final ApplicationDAO applicationDAO;

    public DashboardService() {
        this.userDAO        = new UserDAO();
        this.jobDAO         = new JobDAO();
        this.applicationDAO = new ApplicationDAO();
    }

    // ================================================================
    // ADMIN DASHBOARD
    // ================================================================

    /**
     * Builds the complete stat block shown on the admin home panel.
     *
     * Keys returned:
     *   totalStudents      (int)  - all registered student accounts
     *   totalRecruiters    (int)  - all registered recruiter accounts
     *   pendingUsers       (int)  - accounts awaiting approval
     *   activeJobs         (int)  - currently ACTIVE job listings
     *   pendingJobs        (int)  - job posts awaiting admin review
     *   totalApplications  (int)  - platform-wide application count
     *   topJobs            (List<Job>) - top 5 most-applied-for jobs
     *   recentApplications (int)  - applications in the last 7 days
     *
     * @return Stats map for the admin JSP
     */
    public Map<String, Object> getAdminDashboardStats() {
        Map<String, Object> stats = new HashMap<>();

        try {
            stats.put("totalStudents",     userDAO.countByRole("STUDENT"));
            stats.put("totalRecruiters",   userDAO.countByRole("RECRUITER"));
            stats.put("pendingUsers",       userDAO.countByStatus("PENDING"));
            stats.put("activeJobs",         jobDAO.countByStatus("ACTIVE"));
            stats.put("pendingJobs",        jobDAO.countByStatus("PENDING"));
            stats.put("totalApplications",  applicationDAO.countAll());
            stats.put("recentApplications", applicationDAO.countRecentApplications(7));
            stats.put("topJobs",            jobDAO.findTopJobsByApplicationCount(5));
        } catch (SQLException e) {
            e.printStackTrace();
            // Populate zeros so the page still renders cleanly
            stats.put("totalStudents",     0);
            stats.put("totalRecruiters",   0);
            stats.put("pendingUsers",       0);
            stats.put("activeJobs",         0);
            stats.put("pendingJobs",        0);
            stats.put("totalApplications",  0);
            stats.put("recentApplications", 0);
            stats.put("topJobs",            new ArrayList<>());
            stats.put("error", "Could not load dashboard statistics. Please refresh.");
        }

        return stats;
    }

    /**
     * Returns application-count breakdown by status for the admin
     * analytics chart (used by Chart.js or a simple table).
     *
     * Keys: PENDING, SHORTLISTED, ACCEPTED, REJECTED  → each an int
     *
     * @return Status-count map
     */
    public Map<String, Integer> getApplicationStatusBreakdown() {
        Map<String, Integer> breakdown = new HashMap<>();
        String[] statuses = {"PENDING", "SHORTLISTED", "ACCEPTED", "REJECTED"};
        try {
            for (String s : statuses) {
                breakdown.put(s, applicationDAO.countByStatus(s));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            for (String s : statuses) breakdown.put(s, 0);
        }
        return breakdown;
    }

    /**
     * Returns job-count breakdown by category for the admin report.
     *
     * Example keys: "IT", "Finance", "Engineering", ...
     *
     * @return Category-count map
     */
    public Map<String, Integer> getJobCountByCategory() {
        try {
            return jobDAO.countJobsByCategory();
        } catch (SQLException e) {
            e.printStackTrace();
            return new HashMap<>();
        }
    }

    // ================================================================
    // RECRUITER DASHBOARD
    // ================================================================

    /**
     * Builds stats for the logged-in recruiter's dashboard panel.
     *
     * Keys returned:
     *   totalJobsPosted    (int)  - all jobs posted by this recruiter
     *   activeJobs         (int)  - their currently active listings
     *   pendingJobs        (int)  - their listings awaiting approval
     *   totalApplications  (int)  - total applications across all their jobs
     *   shortlistCount     (int)  - applications they have shortlisted
     *   recentJobs         (List<Job>) - their 5 most recently posted jobs
     *   applicationRate    (double) - shortlisted / total * 100 (%)
     *
     * @param recruiterId Logged-in recruiter's user ID
     * @return            Stats map for the recruiter JSP
     */
    public Map<String, Object> getRecruiterDashboardStats(int recruiterId) {
        Map<String, Object> stats = new HashMap<>();

        try {
            int totalJobs        = jobDAO.countByRecruiterId(recruiterId);
            int activeJobs       = jobDAO.countByRecruiterAndStatus(recruiterId, "ACTIVE");
            int pendingJobs      = jobDAO.countByRecruiterAndStatus(recruiterId, "PENDING");
            int totalApps        = applicationDAO.countByRecruiterId(recruiterId);
            int shortlisted      = applicationDAO.countByRecruiterAndStatus(recruiterId, "SHORTLISTED");
            List<Job> recentJobs = jobDAO.findRecentByRecruiterId(recruiterId, 5);

            double appRate = (totalApps > 0)
                    ? Math.round((shortlisted * 100.0 / totalApps) * 10.0) / 10.0
                    : 0.0;

            stats.put("totalJobsPosted",   totalJobs);
            stats.put("activeJobs",         activeJobs);
            stats.put("pendingJobs",        pendingJobs);
            stats.put("totalApplications",  totalApps);
            stats.put("shortlistCount",     shortlisted);
            stats.put("applicationRate",    appRate);
            stats.put("recentJobs",         recentJobs);

        } catch (SQLException e) {
            e.printStackTrace();
            stats.put("totalJobsPosted",   0);
            stats.put("activeJobs",         0);
            stats.put("pendingJobs",        0);
            stats.put("totalApplications",  0);
            stats.put("shortlistCount",     0);
            stats.put("applicationRate",    0.0);
            stats.put("recentJobs",         new ArrayList<>());
            stats.put("error", "Could not load your dashboard. Please refresh.");
        }

        return stats;
    }

    /**
     * Returns per-job application counts for the recruiter's analytics section.
     * Map key = job title (String), value = application count (int).
     *
     * @param recruiterId Recruiter's user ID
     * @return            Job-title → application-count map (top 10 jobs)
     */
    public Map<String, Integer> getApplicationsPerJobForRecruiter(int recruiterId) {
        try {
            return applicationDAO.countPerJobByRecruiterId(recruiterId);
        } catch (SQLException e) {
            e.printStackTrace();
            return new HashMap<>();
        }
    }

    // ================================================================
    // STUDENT DASHBOARD
    // ================================================================

    /**
     * Builds stats for the logged-in student's portal home.
     *
     * Keys returned:
     *   totalApplications  (int)  - how many jobs the student has applied to
     *   pendingCount       (int)  - applications still pending
     *   shortlistedCount   (int)  - applications the student is shortlisted for
     *   acceptedCount      (int)  - accepted offers
     *   rejectedCount      (int)  - rejected applications
     *   activeJobCount     (int)  - total active jobs currently on the platform
     *   wishlistCount      (int)  - items in the student's session wishlist
     *
     * @param studentId   Logged-in student's user ID
     * @param wishlistSize Number of items in the session-based wishlist
     * @return            Stats map for the student JSP
     */
    public Map<String, Object> getStudentDashboardStats(int studentId, int wishlistSize) {
        Map<String, Object> stats = new HashMap<>();

        try {
            stats.put("totalApplications", applicationDAO.countByStudentId(studentId));
            stats.put("pendingCount",       applicationDAO.countByStudentAndStatus(studentId, "PENDING"));
            stats.put("shortlistedCount",   applicationDAO.countByStudentAndStatus(studentId, "SHORTLISTED"));
            stats.put("acceptedCount",      applicationDAO.countByStudentAndStatus(studentId, "ACCEPTED"));
            stats.put("rejectedCount",      applicationDAO.countByStudentAndStatus(studentId, "REJECTED"));
            stats.put("activeJobCount",     jobDAO.countByStatus("ACTIVE"));
            stats.put("wishlistCount",      wishlistSize);

        } catch (SQLException e) {
            e.printStackTrace();
            stats.put("totalApplications", 0);
            stats.put("pendingCount",       0);
            stats.put("shortlistedCount",   0);
            stats.put("acceptedCount",      0);
            stats.put("rejectedCount",      0);
            stats.put("activeJobCount",     0);
            stats.put("wishlistCount",      wishlistSize);
            stats.put("error", "Could not load your dashboard. Please refresh.");
        }

        return stats;
    }

    /**
     * Returns the top N most-applied-for jobs system-wide —
     * used on the student portal's "Trending Jobs" section.
     *
     * @param limit Maximum number of jobs to return
     * @return      List of Job objects ordered by application count desc
     */
    public List<Job> getTrendingJobs(int limit) {
        try {
            return jobDAO.findTopJobsByApplicationCount(limit);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}
