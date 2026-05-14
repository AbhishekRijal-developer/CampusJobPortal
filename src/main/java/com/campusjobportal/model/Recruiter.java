package com.campusjobportal.model;

public class Recruiter {
    private int id;
    private String companyName;
    private String email;
    private String password;
    private String description;


    public Recruiter(int id, String companyName, String email, String password, String description) {
        this.id = id;
        this.companyName = companyName;
        this.email = email;
        this.password = password;
        this.description = description;
    }

    public int getId() {return id;}

    public void setId(int id) {this.id = id;}

    public String getCompanyName() {return companyName;}

    public void setCompanyName(String companyName) {this.companyName = companyName;}

    public String getEmail() {return email;}

    public void setEmail(String email) {this.email = email;}

    public String getPassword() {return password;}

    public void setPassword(String password) {this.password = password;}

    public String getDescription() {return description;}

    public void setDescription(String description) {this.description = description;}
}
