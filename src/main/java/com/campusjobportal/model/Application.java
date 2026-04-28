package com.campusjobportal.model;

public class Application {
    private int id;
    private int jobId;
    private int studentId;
    private String status;

    public Application(int id, int jobId, int studentId, String status) {
        this.id = id;
        this.jobId = jobId;
        this.studentId = studentId;
        this.status = status;
    }

    public int getId() {return id;}

    public void setId(int id) {this.id = id;}

    public int getJobId() {return jobId;}

    public void setJobId(int jobId) {this.jobId = jobId;}

    public int getStudentId() {return studentId;}

    public void setStudentId(int studentId) {this.studentId = studentId;}

    public String getStatus() {return status;}

    public void setStatus(String status) {this.status = status;}
}
