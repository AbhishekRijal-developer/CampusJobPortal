# Student Profile Data Persistence - Implementation Guide

## Summary of Changes

I've created a complete solution to save and load student profile data. Now when students fill out their profile once, all their information will be saved to the database and automatically loaded when they visit the profile page again.

## Files Created

### 1. Database Migration Script
**File:** `profile_migration.sql`
- Creates `student_profiles` table to store detailed profile information
- Includes fields for: location, DOB, education, skills, work experience, bio

### 2. Model Class
**File:** `src/main/java/com/campusjobportal/model/StudentProfile.java`
- StudentProfile class with all profile fields
- Getters and setters for all properties

### 3. Data Access Layer
**File:** `src/main/java/com/campusjobportal/dao/StudentProfileDAO.java`
- Handles database operations (save, load, delete profiles)
- Automatically creates new profile or updates existing one

### 4. Servlet Controller
**File:** `src/main/java/com/campusjobportal/controller/StudentProfileServlet.java`
- GET: Loads existing profile data and forwards to JSP
- POST: Saves profile data from form submission
- Handles date parsing and validation

### 5. Updated JSP Page
**File:** `src/main/webapp/pages/student-profile.jsp`
- Pre-populates form fields with existing data
- Shows success/error messages
- Submits to StudentProfileServlet

## Implementation Steps

### Step 1: Run Database Migration
Execute the SQL script to create the `student_profiles` table:
```sql
-- Run profile_migration.sql against your campus_job_portal database
```

### Step 2: Compile the Java Files
The new Java classes will be compiled when you run the Maven build.

### Step 3: Update Navigation Links
In your student dashboard or navigation, change the profile link from:
```html
href="/CampusJobPortal/pages/student-profile.jsp"
```
To:
```html
href="/CampusJobPortal/StudentProfileServlet"
```

This ensures the profile data is loaded first before showing the page.

### Step 4: Restart Your Application
Rebuild and deploy your application to load the new changes.

## How It Works

1. **First Visit:** Student visits their profile page
   - GET request to StudentProfileServlet
   - Servlet checks if profile exists in database
   - If not, creates empty StudentProfile object
   - JSP displays empty form with placeholders

2. **Fill and Save:** Student fills the form and clicks "Save Profile"
   - POST request to StudentProfileServlet with form data
   - Servlet creates StudentProfile object from request parameters
   - StudentProfileDAO checks if profile exists:
     - If exists: Updates existing record
     - If not: Creates new record
   - Shows success message

3. **Next Visit:** Student returns to profile page
   - GET request to StudentProfileServlet
   - Servlet loads profile from database using user ID
   - JSP displays all previously saved data in form fields
   - Student can update and save again

## Database Schema

```sql
CREATE TABLE student_profiles (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    location VARCHAR(100),
    date_of_birth DATE,
    institution VARCHAR(200),
    degree VARCHAR(100),
    field_of_study VARCHAR(100),
    expected_graduation INT,
    gpa DECIMAL(3,2),
    skills LONGTEXT,
    company_name VARCHAR(100),
    position VARCHAR(100),
    start_date DATE,
    end_date DATE,
    work_description LONGTEXT,
    bio LONGTEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
```

## Testing Checklist

- [ ] Run profile_migration.sql to create the table
- [ ] Student visits profile page → shows empty form
- [ ] Fill profile form with data and click Save
- [ ] Verify success message appears
- [ ] Refresh page → verify all data is still there
- [ ] Update profile data and save again
- [ ] Verify updates are persisted
- [ ] Test with multiple students → verify data isolation

## Troubleshooting

If data is not loading:
1. Verify `student_profiles` table exists in database
2. Check that StudentProfileServlet is compiled and deployed
3. Verify user_id is correctly stored in session
4. Check database connection credentials in StudentProfileDAO
5. Review application logs for SQL errors

## Future Enhancements

- Add profile photo upload
- Add file upload for resume
- Add form validation messages
- Add auto-save functionality
- Add profile completion percentage indicator
