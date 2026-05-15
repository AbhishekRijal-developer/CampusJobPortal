package com.campusjobportal.service;

import com.campusjobportal.dao.JobDAO;
import com.campusjobportal.model.Job;
import com.campusjobportal.util.ValidationUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * Service layer for all job-related business logic.

 */
public class JobService {

    private final JobDAO jobDAO;

    public JobService() {
        this.jobDAO = new JobDAO();
    }

    // ----------------------------------------------------------------
    // CREATE
    // ----------------------------------------------------------------

    /**
     * Creates a new job posting after full validation.
     *
     * @param job  Job object populated from the recruiter form
     * @return     Error message string, or null if successful
     */
    public String createJob(Job job) {
        // --- Validate required fields ---
        String validationError = validateJobFields(job);
        if (validationError != null) {
            return validationError;
        }

        // --- Business rule: deadline must be in the future ---
        if (job.getDeadline() != null && !job.getDeadline().isEmpty()) {
            try {
                java.time.LocalDate deadline = java.time.LocalDate.parse(job.getDeadline());
                if (deadline.isBefore(java.time.LocalDate.now())) {
                    return "Application deadline must be a future date.";
                }
            } catch (Exception e) {
                return "Invalid deadline format.";
            }
        }

        // --- Business rule: salary range sanity check ---
        if (job.getSalaryMin() > 0 && job.getSalaryMax() > 0
                && job.getSalaryMin() > job.getSalaryMax()) {
            return "Minimum salary cannot be greater than maximum salary.";
        }

        // --- Set default status: pending admin approval ---
        job.setApprovalStatus("PENDING");

        boolean success = jobDAO.insertJob(job);
        if (success) {
            return null; // success
        } else {
            return "Failed to create job posting. Please try again.";
        }
    }

    // ----------------------------------------------------------------
    // READ
    // ----------------------------------------------------------------

    /**
     * Retrieves a single job by its ID.
     *
     * @param jobId  Primary key of the job
     * @return       Job object, or null if not found
     */
    public Job getJobById(int jobId) {
        if (jobId <= 0) return null;
        return jobDAO.getJobById(jobId);
    }

    /**
     * Returns all APPROVED/ACTIVE jobs visible to students.
     *
     * @return List of active jobs (never null, may be empty)
     */
    public List<Job> getAllActiveJobs() {
        return jobDAO.getActiveJobs();
    }

    /**
     * Returns all jobs posted by a specific recruiter company.
     *
     * @param recruiterId  The recruiter's user ID
     * @return             List of jobs belonging to this recruiter
     */
    public List<Job> getJobsByRecruiter(int recruiterId) {
        if (recruiterId <= 0) return new ArrayList<>();
        return jobDAO.getJobsByRecruiter(recruiterId);
    }

    /**
     * Returns all jobs for the admin panel (all statuses).
     *
     * @return Full list of jobs across all statuses
     */
    public List<Job> getAllJobsForAdmin() {
        return jobDAO.getAllJobs();
    }

    // ----------------------------------------------------------------
    // UPDATE
    // ----------------------------------------------------------------

    /**
     * Updates an existing job posting.
     * Only the recruiter who owns the job may update it.
     *
     * @param job         Updated Job object
     * @param requesterId Logged-in recruiter's user ID
     * @return            Error message, or null if successful
     */
    public String updateJob(Job job, int requesterId) {
        // Validate fields
        String validationError = validateJobFields(job);
        if (validationError != null) return validationError;

        // Ownership check
        Job existing = jobDAO.findById(job.getJobId());
        if (existing == null) {
            return "Job not found.";
        }
        if (existing.getRecruiterId() != requesterId) {
            return "You do not have permission to edit this job posting.";
        }

        // After edit, revert to PENDING so admin re-approves
        job.setStatus("PENDING");
        jobDAO.updateJob(job);
        return null;
    }

    /**
     * Admin approves a job posting — sets status to ACTIVE.
     *
     * @param jobId Job to approve
     * @return      Error message, or null if successful
     */
    public String approveJob(int jobId) {
        return changeJobStatus(jobId, "ACTIVE");
    }

    /**
     * Admin rejects a job posting — sets status to REJECTED.
     *
     * @param jobId Job to reject
     * @return      Error message, or null if successful
     */
    public String rejectJob(int jobId) {
        return changeJobStatus(jobId, "REJECTED");
    }

    /**
     * Recruiter deactivates their own job listing.
     *
     * @param jobId       Job to deactivate
     * @param requesterId Recruiter performing the action
     * @return            Error message, or null if successful
     */
    public String deactivateJob(int jobId, int requesterId) {
        Job existing = jobDAO.findById(jobId);
        if (existing == null) return "Job not found.";
        if (existing.getRecruiterId() != requesterId) {
            return "You do not have permission to deactivate this job.";
        }
        jobDAO.updateJobStatus(jobId, "INACTIVE");
        return null;
    }

    // ----------------------------------------------------------------
    // DELETE
    // ----------------------------------------------------------------

    /**
     * Deletes a job posting.
     * Only the owner recruiter or an admin (recruiterId = 0) may delete.
     *
     * @param jobId       Job to delete
     * @param requesterId Requester's user ID (0 = admin bypass)
     * @return            Error message, or null if successful
     */
    public String deleteJob(int jobId, int requesterId) {
        Job existing = jobDAO.findById(jobId);
        if (existing == null) return "Job not found.";

        boolean isAdmin = (requesterId == 0);
        if (!isAdmin && existing.getRecruiterId() != requesterId) {
            return "You do not have permission to delete this job.";
        }

        jobDAO.deleteJob(jobId);
        return null;
    }

    // ----------------------------------------------------------------
    // PRIVATE HELPERS
    // ----------------------------------------------------------------

    /**
     * Central field-level validation for job objects.
     *
     * @param job Job to validate
     * @return    First validation error found, or null if all pass
     */
    private String validateJobFields(Job job) {
        if (ValidationUtil.isNullOrEmpty(job.getTitle())) {
            return "Job title is required.";
        }
        if (job.getTitle().length() > 150) {
            return "Job title must not exceed 150 characters.";
        }
        if (ValidationUtil.isNullOrEmpty(job.getDescription())) {
            return "Job description is required.";
        }
        if (ValidationUtil.isNullOrEmpty(job.getLocation())) {
            return "Job location is required.";
        }
        if (ValidationUtil.isNullOrEmpty(job.getCategory())) {
            return "Job category is required.";
        }
        if (job.getDeadline() == null) {
            return "Application deadline is required.";
        }
        return null;
    }

    /**
     * Generic status-change helper (used by approve/reject).
     */
    private String changeJobStatus(int jobId, String newStatus) {
        Job existing = jobDAO.findById(jobId);
        if (existing == null) return "Job not found.";
        jobDAO.updateJobStatus(jobId, newStatus);
        return null;
    }
}
