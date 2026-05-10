package com.campusjobportal.model;

public class Job {
    private int id;
    private String title;
    private String description;
    private String location;
    private String category;
    private String deadline;
    private int recruiterId;
    private String approvalStatus; // PENDING, APPROVED, REJECTED
    private double salaryMin;
    private double salaryMax;

    //Default Constructor
    public Job() {
    }

    //Constructor with parameters
    public Job(int id, String title, String description, String location, String category, String deadline, int recruiterId) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.location = location;
        this.category = category;
        this.deadline = deadline;
        this.recruiterId = recruiterId;
    }

    public int getId() {return id;}

    public void setId(int id) {this.id = id;}

    public String getTitle() {return title;}

    public void setTitle(String title) {this.title = title;}

    public String getDescription() {return description;}

    public void setDescription(String description) {this.description = description;}

    public String getLocation() {return location;}

    public void setLocation(String location) {this.location = location;}

    public String getCategory() {return category;}

    public void setCategory(String category) {this.category = category;}

    public String getDeadline() {return deadline;}

    public void setDeadline(String deadline) {this.deadline = deadline;}

    public int getRecruiterId() {return recruiterId;}

    public void setRecruiterId(int recruiterId) {this.recruiterId = recruiterId;}

    public String getApprovalStatus() {return approvalStatus;}

    public void setApprovalStatus(String approvalStatus) {this.approvalStatus = approvalStatus;}

    public double getSalaryMin() {return salaryMin;}

    public void setSalaryMin(double salaryMin) {this.salaryMin = salaryMin;}

    public double getSalaryMax() {return salaryMax;}

    public void setSalaryMax(double salaryMax) {this.salaryMax = salaryMax;}

    public int getJobId() {return id;}

    public void setStatus(String status) {this.approvalStatus = status;}
}
