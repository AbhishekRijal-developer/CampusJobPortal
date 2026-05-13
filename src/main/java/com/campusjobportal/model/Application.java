package com.campusjobportal.model;

import java.io.Serializable;
import java.util.Objects;

/**
 * Represents a job application in the Campus Job Portal system.
 * Contains information about student applications to job postings.
 */
public class Application implements Serializable {
    private static final long serialVersionUID = 1L;

    /** Unique identifier for the application */
    private int applicationId;
    /** Foreign key reference to the job posting */
    private int jobId;
    /** Foreign key reference to the student */
    private int studentId;
    /** Current status of the application (e.g., PENDING, APPROVED, REJECTED) */
    private String status;
    /** Date when the application was submitted */
    private String applicationDate;
    
    // Joint fields of Admin view
    /** Title of the job being applied for */
    private String jobTitle;
    /** Name of the student who applied */
    private String studentName;
    /** Name of the recruiter who posted the job */
    private String recruiterName;

    /**
     * Default constructor.
     */
    public Application() {}

    /**
     * Constructor with basic application details.
     *
     * @param applicationId the application ID
     * @param jobId the job ID
     * @param studentId the student ID
     * @param status the application status
     */
    public Application(int applicationId, int jobId, int studentId, String status) {
        this.applicationId = applicationId;
        this.jobId = jobId;
        this.studentId = studentId;
        this.status = status;
    }

    /**
     * Gets the application ID.
     *
     * @return the application ID
     */
    public int getApplicationId() { return applicationId; }

    /**
     * Sets the application ID.
     *
     * @param applicationId the application ID to set
     */
    public void setApplicationId(int applicationId) { this.applicationId = applicationId; }

    /**
     * Gets the job ID.
     *
     * @return the job ID
     */
    public int getJobId() { return jobId; }

    /**
     * Sets the job ID.
     *
     * @param jobId the job ID to set
     */
    public void setJobId(int jobId) { this.jobId = jobId; }

    /**
     * Gets the student ID.
     *
     * @return the student ID
     */
    public int getStudentId() { return studentId; }

    /**
     * Sets the student ID.
     *
     * @param studentId the student ID to set
     */
    public void setStudentId(int studentId) { this.studentId = studentId; }

    /**
     * Gets the application status.
     *
     * @return the application status
     */
    public String getStatus() { return status; }

    /**
     * Sets the application status.
     *
     * @param status the status to set
     */
    public void setStatus(String status) { this.status = status; }

    /**
     * Gets the application date.
     *
     * @return the application date
     */
    public String getApplicationDate() { return applicationDate; }

    /**
     * Sets the application date.
     *
     * @param applicationDate the application date to set
     */
    public void setApplicationDate(String applicationDate) { this.applicationDate = applicationDate; }

    /**
     * Gets the job title.
     *
     * @return the job title
     */
    public String getJobTitle() { return jobTitle; }

    /**
     * Sets the job title.
     *
     * @param jobTitle the job title to set
     */
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    /**
     * Gets the student name.
     *
     * @return the student name
     */
    public String getStudentName() { return studentName; }

    /**
     * Sets the student name.
     *
     * @param studentName the student name to set
     */
    public void setStudentName(String studentName) { this.studentName = studentName; }

    /**
     * Gets the recruiter name.
     *
     * @return the recruiter name
     */
    public String getRecruiterName() { return recruiterName; }

    /**
     * Sets the recruiter name.
     *
     * @param recruiterName the recruiter name to set
     */
    public void setRecruiterName(String recruiterName) { this.recruiterName = recruiterName; }

    /**
     * Returns a string representation of the Application.
     *
     * @return a string representation
     */
    @Override
    public String toString() {
        return "Application{" +
                "applicationId=" + applicationId +
                ", jobId=" + jobId +
                ", studentId=" + studentId +
                ", status='" + status + '\'' +
                ", applicationDate='" + applicationDate + '\'' +
                ", jobTitle='" + jobTitle + '\'' +
                ", studentName='" + studentName + '\'' +
                ", recruiterName='" + recruiterName + '\'' +
                '}';
    }

    /**
     * Checks equality based on applicationId and jobId.
     *
     * @param o the object to compare
     * @return true if equal, false otherwise
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Application that = (Application) o;
        return applicationId == that.applicationId &&
                jobId == that.jobId;
    }

    /**
     * Generates a hash code based on applicationId and jobId.
     *
     * @return the hash code
     */
    @Override
    public int hashCode() {
        return Objects.hash(applicationId, jobId);
    }
}
