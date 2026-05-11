package com.campusjobportal.model;

import java.io.Serializable;

public class Application implements Serializable {
    private static final long serialVersionUID = 1L;

    private int applicationId;
    private int jobId;
    private int studentId;
    private String status;
    private String applicationDate;
    
    // Joint fields of Admin view
    private String jobTitle;
    private String studentName;
    private String recruiterName;

    public Application() {}

    public Application(int applicationId, int jobId, int studentId, String status) {
        this.applicationId = applicationId;
        this.jobId = jobId;
        this.studentId = studentId;
        this.status = status;
    }

    public int getApplicationId() { return applicationId; }
    public void setApplicationId(int applicationId) { this.applicationId = applicationId; }

    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getApplicationDate() { return applicationDate; }
    public void setApplicationDate(String applicationDate) { this.applicationDate = applicationDate; }

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getRecruiterName() { return recruiterName; }
    public void setRecruiterName(String recruiterName) { this.recruiterName = recruiterName; }
}
