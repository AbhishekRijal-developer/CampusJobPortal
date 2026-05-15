# BLACK-BOX TESTING CHECKLIST
## Campus Job Portal System

### **PAGE COVERAGE ANALYSIS**

#### ✅ PUBLIC PAGES (No Login Required)
- [ ] **index.jsp** - Home/Landing page
- [ ] **home.jsp** - Main dashboard
- [ ] **login.jsp** - Authentication page
- [ ] **register.jsp** - User registration
- [ ] **about.jsp** - About page
- [ ] **contact.jsp** - Contact form
- [ ] **contact-success.jsp** - Confirmation page
- [ ] **error.jsp** - Error handling

#### ✅ STUDENT PAGES (Login Required)
- [ ] **student-dashboard.jsp** - Main student interface
- [ ] **browse-jobs.jsp** - Job listing with search/filter
- [ ] **job-detail.jsp** - Individual job details
- [ ] **student-profile.jsp** - Profile creation/edit
- [ ] **my-applications.jsp** - Application tracking
- [ ] **manage-job.jsp** - Student job management

#### ✅ RECRUITER PAGES (Login Required)
- [ ] **recruiter-dashboard.jsp** - Recruiter main interface
- [ ] **post-job.jsp** - Job posting form
- [ ] **edit-job.jsp** - Edit job listings
- [ ] **view-applicants.jsp** - View applications
- [ ] **company-profile.jsp** - Company info management

#### ✅ ADMIN PAGES (Admin Only)
- [ ] **admin/admin-dashboard.jsp** - Admin home
- [ ] **admin/admin-manage-users.jsp** - User management
- [ ] **admin/admin-jobs.jsp** - Job moderation
- [ ] **admin/admin-approve-jobs.jsp** - Job approval
- [ ] **admin/admin-applications.jsp** - System-wide applications
- [ ] **admin/admin-complaints.jsp** - Complaint handling
- [ ] **admin/admin-content.jsp** - Content management (About/Contact)
- [ ] **admin/admin-reports.jsp** - Analytics/Reports
- [ ] **admin/admin-users.jsp** - User list

---

### **FUNCTIONAL TESTING MATRIX**

#### 1. AUTHENTICATION & AUTHORIZATION
- [ ] Login with valid credentials redirects to dashboard
- [ ] Login with invalid credentials shows error message
- [ ] Logout clears session and redirects to home
- [ ] Unauthorized access to `/admin/*` redirects to login
- [ ] Password encryption working (SHA-256)
- [ ] Session timeout after 30 minutes
- [ ] Registration form validates input

#### 2. STUDENT WORKFLOW
- [ ] Student can register with all required fields
- [ ] Student can login after registration
- [ ] Student can view and edit profile
- [ ] Student can upload CV (PDF format)
- [ ] Student can search jobs by keyword
- [ ] Student can filter jobs by category/location/deadline
- [ ] Student can view job details
- [ ] Student can apply for jobs
- [ ] Student can view application status (Pending/Shortlisted/Rejected)
- [ ] Student can view applied jobs in my-applications

#### 3. RECRUITER WORKFLOW
- [ ] Recruiter can register with company details
- [ ] Recruiter can login after approval by admin
- [ ] Recruiter can edit company profile
- [ ] Recruiter can post new jobs
- [ ] Recruiter can edit own job listings
- [ ] Recruiter can deactivate/delete jobs
- [ ] Recruiter can view all applicants for a job
- [ ] Recruiter can view student profiles and CVs
- [ ] Recruiter can update application status
- [ ] Recruiter dashboard shows analytics

#### 4. ADMIN WORKFLOW
- [ ] Admin can login with encrypted password
- [ ] Admin can view all users (students/recruiters)
- [ ] Admin can approve/suspend users
- [ ] Admin can delete users
- [ ] Admin can view all job postings
- [ ] Admin can approve/reject job postings
- [ ] Admin can view all applications system-wide
- [ ] Admin can receive and respond to complaints
- [ ] Admin can edit About/Contact page content
- [ ] Admin can generate reports with statistics

#### 5. DATA VALIDATION
- [ ] Email format validation on registration
- [ ] Password strength requirements enforced
- [ ] Required fields cannot be empty
- [ ] File upload accepts PDF only
- [ ] File size limits enforced (5MB max)
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS protection on output

#### 6. ERROR HANDLING
- [ ] 404 error displays custom error page
- [ ] 500 error displays custom error page
- [ ] No stack traces exposed to users
- [ ] Database errors handled gracefully
- [ ] File upload errors show clear messages

#### 7. UI/UX RESPONSIVENESS
- [ ] All pages display correctly on desktop
- [ ] Navbar responsive and functional
- [ ] Forms styled consistently
- [ ] CSS animations smooth
- [ ] No external framework dependencies (Bootstrap/Tailwind)
- [ ] Navigation links work correctly
- [ ] Session attributes display correctly (username, user type)

---

### **TEST EXECUTION STEPS**

1. **Setup Database**
   - Ensure MySQL is running
   - Verify connection: `localhost:3306/campus_job_portal`
   - User: `root`, Password: `1234`

2. **Start Application**
   - Run: `mvn tomcat7:run`
   - Wait for: "BUILD SUCCESS" message
   - Access: `http://localhost:8080/CampusJobPortal`

3. **Test Public Pages First**
   - Home page loads without errors
   - Navigation menu functional

4. **Test Registration & Login**
   - Create student account
   - Create recruiter account
   - Test login/logout cycle

5. **Test Each Role Workflow**
   - Follow steps in respective workflow section above

6. **Test Error Scenarios**
   - Invalid login attempts
   - Unauthorized access attempts
   - Missing required fields
   - Invalid file uploads

---

### **KNOWN ISSUES TO CHECK**
- [ ] ValidationUtil.isNullOrEmpty() - still has TODO
- [ ] MIME type validation for CV uploads
- [ ] Media queries on all CSS files

---

**Status**: Ready for execution
**Date**: May 14, 2026
**Tester**: Black-Box Testing Verification
