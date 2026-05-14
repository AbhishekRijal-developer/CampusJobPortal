package com.campusjob.service;

import com.campusjob.dao.ApplicationDAO;
import com.campusjob.dao.JobDAO;
import com.campusjob.model.Application;
import com.campusjob.model.Job;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * ApplicationService.java
 * Service layer managing all job-application business logic.
 *
 * Responsibilities:
 *  - Prevent duplicate applications by the same student
 *  - Ensure a job is open/active before allowing apply
 *  - Validate status transitions (Pending → Shortlisted → Rejected/Accepted)
 *  - Aggregate application data for dashboards
 *
 * Author: Prabesh Adhikari
 * Project: Campus Job Portal System
 */
public class ApplicationService {

    private final ApplicationDAO applicationDAO;
    private final JobDAO         jobDAO;

    public ApplicationService() {
        this.applicationDAO = new ApplicationDAO();
        this.jobDAO         = new JobDAO();
    }

    // ----------------------------------------------------------------
    // APPLY
    // ----------------------------------------------------------------

    /**
     * Submits a student's application for a specific job.
     *
     * Steps:
     *  1. Verify the job exists and is ACTIVE.
     *  2. Check the deadline has not passed.
     *  3. Ensure the student has not already applied.
     *  4. Persist the application with PENDING status.
     *
     * @param studentId Student's user ID
     * @param jobId     Target job ID
     * @param coverNote Optional cover note / message from the student
     * @return          Error message, or null on success
     */
    public String applyForJob(int studentId, int jobId, String coverNote) {
        try {
            // --- 1. Job must exist and be active ---
            Job job = jobDAO.findById(jobId);
            if (job == null) {
                return "The job you are trying to apply for does not exist.";
            }
            if (!"ACTIVE".equalsIgnoreCase(job.getStatus())) {
                return "This job posting is no longer accepting applications.";
            }

            // --- 2. Deadline check ---
            if (job.getDeadline() != null && job.getDeadline().isBefore(LocalDate.now())) {
                return "The application deadline for this job has passed.";
            }

            // --- 3. Duplicate application check ---
            boolean alreadyApplied = applicationDAO.existsByStudentAndJob(studentId, jobId);
            if (alreadyApplied) {
                return "You have already applied for this job.";
            }

            // --- 4. Persist ---
            Application application = new Application();
            application.setStudentId(studentId);
            application.setJobId(jobId);
            application.setStatus("PENDING");
            application.setAppliedDate(LocalDate.now());
            application.setCoverNote(coverNote != null ? coverNote.trim() : "");

            applicationDAO.insertApplication(application);
            return null; // success

        } catch (SQLException e) {
            e.printStackTrace();
            return "A database error occurred while submitting your application. Please try again.";
        }
    }

    // ----------------------------------------------------------------
    // READ — Student perspective
    // ----------------------------------------------------------------

    /**
     * Returns all applications submitted by a specific student.
     *
     * @param studentId Student's user ID
     * @return          List of applications with job details joined
     */
    public List<Application> getApplicationsByStudent(int studentId) {
        if (studentId <= 0) return new ArrayList<>();
        try {
            return applicationDAO.findByStudentId(studentId);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Returns how many jobs this student has applied to.
     *
     * @param studentId Student's user ID
     * @return          Count of applications
     */
    public int countApplicationsByStudent(int studentId) {
        try {
            return applicationDAO.countByStudentId(studentId);
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // ----------------------------------------------------------------
    // READ — Recruiter perspective
    // ----------------------------------------------------------------

    /**
     * Returns all applications received for a specific job posting.
     *
     * @param jobId Job's primary key
     * @return      List of applications with student profile data joined
     */
    public List<Application> getApplicationsByJob(int jobId) {
        if (jobId <= 0) return new ArrayList<>();
        try {
            return applicationDAO.findByJobId(jobId);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Returns all applications across all jobs posted by a recruiter.
     *
     * @param recruiterId Recruiter's user ID
     * @return            List of applications for all their job listings
     */
    public List<Application> getApplicationsByRecruiter(int recruiterId) {
        if (recruiterId <= 0) return new ArrayList<>();
        try {
            return applicationDAO.findByRecruiterId(recruiterId);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // ----------------------------------------------------------------
    // READ — Admin perspective
    // ----------------------------------------------------------------

    /**
     * Returns every application in the system (admin only).
     *
     * @return Full application list with student and job details
     */
    public List<Application> getAllApplications() {
        try {
            return applicationDAO.findAll();
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Returns total application count across the whole platform.
     *
     * @return Platform-wide application count
     */
    public int getTotalApplicationCount() {
        try {
            return applicationDAO.countAll();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // ----------------------------------------------------------------
    // STATUS UPDATE (Recruiter action)
    // ----------------------------------------------------------------

    /**
     * Updates the status of a single application.
     * Only the recruiter who owns the job may change application status.
     *
     * Valid transitions:
     *   PENDING → SHORTLISTED
     *   PENDING → REJECTED
     *   SHORTLISTED → ACCEPTED
     *   SHORTLISTED → REJECTED
     *
     * @param applicationId  Application to update
     * @param newStatus      One of: SHORTLISTED, ACCEPTED, REJECTED
     * @param recruiterId    Recruiter performing the action
     * @return               Error message, or null on success
     */
    public String updateApplicationStatus(int applicationId, String newStatus, int recruiterId) {
        // Validate the requested status value
        if (!isValidStatus(newStatus)) {
            return "Invalid status value: " + newStatus;
        }

        try {
            Application app = applicationDAO.findById(applicationId);
            if (app == null) return "Application not found.";

            // Confirm the recruiter owns the job this application is for
            Job job = jobDAO.findById(app.getJobId());
            if (job == null || job.getRecruiterId() != recruiterId) {
                return "You do not have permission to update this application.";
            }

            // Validate status transition
            String currentStatus = app.getStatus();
            if (!isValidTransition(currentStatus, newStatus)) {
                return "Cannot change status from " + currentStatus + " to " + newStatus + ".";
            }

            applicationDAO.updateStatus(applicationId, newStatus);
            return null;

        } catch (SQLException e) {
            e.printStackTrace();
            return "A database error occurred while updating the application status.";
        }
    }

    // ----------------------------------------------------------------
    // WITHDRAW (Student action)
    // ----------------------------------------------------------------

    /**
     * Allows a student to withdraw their own pending application.
     * Applications that are already shortlisted or accepted cannot be withdrawn.
     *
     * @param applicationId Application to withdraw
     * @param studentId     Student performing the withdrawal
     * @return              Error message, or null on success
     */
    public String withdrawApplication(int applicationId, int studentId) {
        try {
            Application app = applicationDAO.findById(applicationId);
            if (app == null) return "Application not found.";
            if (app.getStudentId() != studentId) {
                return "You do not have permission to withdraw this application.";
            }
            if (!"PENDING".equalsIgnoreCase(app.getStatus())) {
                return "Only pending applications can be withdrawn.";
            }

            applicationDAO.deleteApplication(applicationId);
            return null;

        } catch (SQLException e) {
            e.printStackTrace();
            return "A database error occurred while withdrawing your application.";
        }
    }

    // ----------------------------------------------------------------
    // PRIVATE HELPERS
    // ----------------------------------------------------------------

    /**
     * Validates that newStatus is one of the accepted values.
     */
    private boolean isValidStatus(String status) {
        return status != null &&
                (status.equals("PENDING")
                        || status.equals("SHORTLISTED")
                        || status.equals("ACCEPTED")
                        || status.equals("REJECTED"));
    }

    /**
     * Enforces allowed status transitions.
     * Returns true if moving from currentStatus → newStatus is permitted.
     */
    private boolean isValidTransition(String current, String next) {
        switch (current.toUpperCase()) {
            case "PENDING":
                return next.equals("SHORTLISTED") || next.equals("REJECTED");
            case "SHORTLISTED":
                return next.equals("ACCEPTED") || next.equals("REJECTED");
            default:
                // ACCEPTED and REJECTED are terminal states
                return false;
        }
    }
}
