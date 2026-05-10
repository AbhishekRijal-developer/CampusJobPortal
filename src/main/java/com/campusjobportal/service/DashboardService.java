package com.campusjobportal.service;

import com.campusjobportal.dao.ApplicationDAO;
import com.campusjobportal.dao.JobDAO;
import com.campusjobportal.dao.UserDAO;
import com.campusjobportal.model.Application;
import com.campusjobportal.model.Job;

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

        stats.put("totalStudents",     userDAO.findByRole("STUDENT").size());
        stats.put("totalRecruiters",   userDAO.findByRole("RECRUITER").size());
        stats.put("pendingUsers",       userDAO.findByStatus("PENDING").size());
        stats.put("activeJobs",         jobDAO.getActiveJobs().size());
        stats.put("pendingJobs",        jobDAO.getAllJobs().stream().filter(job -> "PENDING".equals(job.getApprovalStatus())).count());
        stats.put("totalApplications",  applicationDAO.getAllApplications().size());
        stats.put("recentApplications", applicationDAO.getAllApplications().values().stream().filter(app -> {
            try {
                java.time.LocalDate appDate = java.time.LocalDate.parse(app.getApplicationDate());
                return appDate.isAfter(java.time.LocalDate.now().minusDays(7));
            } catch (Exception e) {
                return false;
            }
        }).count());
        stats.put("topJobs",            jobDAO.getAllJobs().subList(0, Math.min(5, jobDAO.getAllJobs().size()))); // TODO: implement proper top jobs

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
        List<Application> allApps = new ArrayList<>(applicationDAO.getAllApplications().values());
        for (String status : statuses) {
            int count = (int) allApps.stream()
                    .filter(app -> status.equalsIgnoreCase(app.getStatus()))
                    .count();
            breakdown.put(status, count);
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
        List<Job> allJobs = jobDAO.getAllJobsForAdmin();
        Map<String, Integer> categoryCount = new HashMap<>();
        for (Job job : allJobs) {
            String category = job.getCategory() != null ? job.getCategory() : "Other";
            categoryCount.put(category, categoryCount.getOrDefault(category, 0) + 1);
        }
        return categoryCount;
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

        List<Job> recruiterJobs = jobDAO.getJobsByRecruiter(recruiterId);
        int totalJobs = recruiterJobs.size();
        int activeJobs = (int) recruiterJobs.stream()
                .filter(job -> "ACTIVE".equals(job.getApprovalStatus()))
                .count();
        int pendingJobs = (int) recruiterJobs.stream()
                .filter(job -> "PENDING".equals(job.getApprovalStatus()))
                .count();

        // Count applications for recruiter's jobs
        int totalApps = 0;
        int shortlisted = 0;
        for (Job job : recruiterJobs) {
            List<Application> jobApps = applicationDAO.getApplicantsByJob(job.getId());
            totalApps += jobApps.size();
            shortlisted += (int) jobApps.stream()
                    .filter(app -> "SHORTLISTED".equals(app.getStatus()))
                    .count();
        }

        List<Job> recentJobs = recruiterJobs.stream()
                .sorted((j1, j2) -> Integer.compare(j2.getId(), j1.getId())) // Assuming higher ID = more recent
                .limit(5)
                .toList();

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
        List<Job> recruiterJobs = jobDAO.getJobsByRecruiter(recruiterId);
        Map<String, Integer> jobAppCounts = new HashMap<>();
        for (Job job : recruiterJobs) {
            List<Application> apps = applicationDAO.getApplicantsByJob(job.getId());
            jobAppCounts.put(job.getTitle(), apps.size());
        }
        return jobAppCounts;
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

        List<Application> studentApps = applicationDAO.getApplicationsByStudentId(studentId);
        stats.put("totalApplications", studentApps.size());
        stats.put("pendingCount",       (int) studentApps.stream().filter(app -> "PENDING".equals(app.getStatus())).count());
        stats.put("shortlistedCount",   (int) studentApps.stream().filter(app -> "SHORTLISTED".equals(app.getStatus())).count());
        stats.put("acceptedCount",      (int) studentApps.stream().filter(app -> "ACCEPTED".equals(app.getStatus())).count());
        stats.put("rejectedCount",      (int) studentApps.stream().filter(app -> "REJECTED".equals(app.getStatus())).count());
        stats.put("activeJobCount",     jobDAO.getActiveJobs().size());
        stats.put("wishlistCount",      wishlistSize);

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
        return jobDAO.findTopJobsByApplicationCount(limit);
    }
}
