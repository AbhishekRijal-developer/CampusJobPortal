<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusjobportal.model.StudentProfile"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Campus Job Portal</title>
    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        .profile-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .profile-header {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .profile-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            text-align: center;
        }

        .profile-avatar {
            width: 200px;
            height: 200px;
            margin: 0 auto 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 80px;
            color: white;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }

        .profile-info h2 {
            color: #333;
            margin-bottom: 10px;
            font-size: 1.8rem;
        }

        .profile-info p {
            color: #666;
            margin: 5px 0;
            font-size: 0.95rem;
        }

        .profile-stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin: 20px 0;
        }

        .stat-item {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
        }

        .stat-number {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .stat-label {
            font-size: 0.85rem;
            opacity: 0.9;
        }

        .profile-sections {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .section-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: bold;
            margin-bottom: 20px;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: #667eea;
            font-size: 1.4rem;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 15px;
        }

        .form-row.full {
            grid-template-columns: 1fr;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 0.95rem;
        }

        input[type="text"],
        input[type="email"],
        input[type="date"],
        input[type="number"],
        input[type="file"],
        textarea,
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.95rem;
            font-family: Arial, sans-serif;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="date"]:focus,
        input[type="number"]:focus,
        input[type="file"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 8px rgba(102, 126, 234, 0.3);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 25px;
            justify-content: center;
        }

        .btn {
            padding: 12px 30px;
            font-size: 1rem;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.6);
        }

        .btn-secondary {
            background: #f0f0f0;
            color: #333;
            border: 2px solid #e0e0e0;
        }

        .btn-secondary:hover {
            background: #e0e0e0;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 10px;
            display: none;
            border-left: 4px solid;
        }

        .alert.success {
            background-color: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert.error {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .help-text {
            font-size: 0.85rem;
            color: #666;
            margin-top: 5px;
        }

        .cv-section {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-top: 15px;
        }

        .cv-upload-box {
            border: 2px dashed white;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .cv-upload-box:hover {
            background: rgba(255,255,255,0.1);
        }

        .cv-file-input {
            display: none;
        }

        .cv-status {
            margin-top: 10px;
            font-size: 0.9rem;
        }

        .cv-file-name {
            color: #fff;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .profile-header {
                grid-template-columns: 1fr;
            }

            .profile-sections {
                grid-template-columns: 1fr;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .btn-container {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/includes/navbar.jsp"%>
    <%
        com.campusjobportal.model.User currentUser =
            (com.campusjobportal.model.User) session.getAttribute("user");
        String fullName = session.getAttribute("userName") != null
            ? (String) session.getAttribute("userName")
            : (currentUser != null ? currentUser.getFullName() : "Student");
        String userEmail = currentUser != null && currentUser.getEmail() != null
            ? currentUser.getEmail()
            : "";
        StudentProfile profile = (StudentProfile) request.getAttribute("profile");
        int skillsCount = 0;
        if (profile != null && profile.getSkills() != null && !profile.getSkills().trim().isEmpty()) {
            skillsCount = profile.getSkills().split("\\s*,\\s*").length;
        }
        int jobsApplied = 0;
        Object appsObj = request.getAttribute("applications");
        if (appsObj instanceof java.util.List) {
            jobsApplied = ((java.util.List<?>) appsObj).size();
        }
    %>

    <div class="profile-container">
        <!-- Alert Messages -->
        <% 
            String message = (String) session.getAttribute("message");
            String error = (String) session.getAttribute("error");
            
            if (message != null) {
        %>
            <div class="alert success">
                <i class="fas fa-check-circle"></i> <%= message %>
            </div>
        <%
                session.removeAttribute("message");
            }
            
            if (error != null) {
        %>
            <div class="alert error">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
        <%
                session.removeAttribute("error");
            }
        %>

        <div class="profile-header">
            <!-- Profile Card -->
            <div class="profile-card">
                <div class="profile-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="profile-info">
                    <h2><%= fullName %></h2>
                    <p><strong><%= session.getAttribute("userType") != null ? session.getAttribute("userType") : "Student" %></strong></p>
                    <p><%= userEmail %></p>
                    <div class="profile-stats">
                        <div class="stat-item">
                            <div class="stat-number"><%= skillsCount %></div>
                            <div class="stat-label">Skills</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number"><%= jobsApplied %></div>
                            <div class="stat-label">Jobs Applied</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Info -->
            <div class="section-card">
                <div class="section-title">
                    <i class="fas fa-info-circle"></i> Quick Information
                </div>
                <form method="POST" action="/CampusJobPortal/StudentProfileServlet" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="location">Location</label>
                        <input type="text" id="location" name="location" placeholder="City, Country" 
                            value="<%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getLocation() != null ? ((StudentProfile)request.getAttribute("profile")).getLocation() : "" %>">
                    </div>

                    <div class="form-group">
                        <label for="bio">Bio</label>
                        <textarea id="bio" name="bio" placeholder="Tell us about yourself..."><%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getBio() != null ? ((StudentProfile)request.getAttribute("profile")).getBio() : "" %></textarea>
                    </div>

                    <!-- CV Upload Section -->
                    <div class="cv-section">
                        <h3 style="margin-top: 0;"><i class="fas fa-file-pdf"></i> Upload Your CV</h3>
                        <div class="cv-upload-box" onclick="document.getElementById('cvFile').click()">
                            <i class="fas fa-cloud-upload-alt" style="font-size: 2rem; margin-bottom: 10px; display: block;"></i>
                            <p>Click to upload your CV/Resume (PDF, DOC, DOCX)</p>
                            <small>Maximum file size: 5MB</small>
                            <input type="file" id="cvFile" name="cv" class="cv-file-input" accept=".pdf,.doc,.docx" onchange="updateCVName(this)">
                        </div>
                        <div class="cv-file-name" id="cvFileName"></div>
                    </div>

                    <div class="btn-container">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Profile
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Main Form Sections -->
        <div class="profile-sections">
            <!-- Education Section -->
            <div class="section-card">
                <div class="section-title">
                    <i class="fas fa-graduation-cap"></i> Education
                </div>
                <form method="POST" action="/CampusJobPortal/StudentProfileServlet" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="institution">Institution / University</label>
                        <input type="text" id="institution" name="institution" placeholder="e.g., ABC University" 
                            value="<%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getInstitution() != null ? ((StudentProfile)request.getAttribute("profile")).getInstitution() : "" %>">
                    </div>

                    <div class="form-group">
                        <label for="degree">Degree</label>
                        <input type="text" id="degree" name="degree" placeholder="e.g., Bachelor of Science" 
                            value="<%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getDegree() != null ? ((StudentProfile)request.getAttribute("profile")).getDegree() : "" %>">
                    </div>

                    <div class="form-group">
                        <label for="fieldOfStudy">Field of Study</label>
                        <input type="text" id="fieldOfStudy" name="fieldOfStudy" placeholder="e.g., Computer Science" 
                            value="<%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getFieldOfStudy() != null ? ((StudentProfile)request.getAttribute("profile")).getFieldOfStudy() : "" %>">
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="gpa">GPA</label>
                            <input type="number" id="gpa" name="gpa" placeholder="e.g., 3.75" step="0.01" min="0" max="4" 
                                value="<%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getGpa() > 0 ? ((StudentProfile)request.getAttribute("profile")).getGpa() : "" %>">
                        </div>
                        <div class="form-group">
                            <label for="graduationYear">Expected Graduation</label>
                            <input type="number" id="graduationYear" name="graduationYear" placeholder="e.g., 2025" min="2024" max="2040" 
                                value="<%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getExpectedGraduation() > 0 ? ((StudentProfile)request.getAttribute("profile")).getExpectedGraduation() : "" %>">
                        </div>
                    </div>

                    <div class="btn-container">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save
                        </button>
                    </div>
                </form>
            </div>

            <!-- Skills Section -->
            <div class="section-card">
                <div class="section-title">
                    <i class="fas fa-lightbulb"></i> Skills & Expertise
                </div>
                <form method="POST" action="/CampusJobPortal/StudentProfileServlet" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="skills">Skills</label>
                        <textarea id="skills" name="skills" placeholder="e.g., Java, Python, JavaScript (separate with commas or newlines)"><%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getSkills() != null ? ((StudentProfile)request.getAttribute("profile")).getSkills() : "" %></textarea>
                    </div>

                    <div class="btn-container">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Work Experience Section -->
        <div class="section-card" style="margin-top: 20px;">
            <div class="section-title">
                <i class="fas fa-briefcase"></i> Work Experience
            </div>
            <form method="POST" action="/CampusJobPortal/StudentProfileServlet" enctype="multipart/form-data">
                <div class="form-row">
                    <div class="form-group">
                        <label for="company">Company Name</label>
                        <input type="text" id="company" name="company" placeholder="e.g., Tech Corp Inc" 
                            value="<%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getCompanyName() != null ? ((StudentProfile)request.getAttribute("profile")).getCompanyName() : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="position">Position / Job Title</label>
                        <input type="text" id="position" name="position" placeholder="e.g., Junior Developer" 
                            value="<%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getPosition() != null ? ((StudentProfile)request.getAttribute("profile")).getPosition() : "" %>">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="startDate">Start Date</label>
                        <input type="date" id="startDate" name="startDate" 
                            value="<%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getStartDate() != null ? ((StudentProfile)request.getAttribute("profile")).getStartDate().toString() : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="endDate">End Date</label>
                        <input type="date" id="endDate" name="endDate" 
                            value="<%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getEndDate() != null ? ((StudentProfile)request.getAttribute("profile")).getEndDate().toString() : "" %>">
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">Job Description / Responsibilities</label>
                    <textarea id="description" name="description" placeholder="Describe your responsibilities and achievements..."><%= request.getAttribute("profile") != null && ((StudentProfile)request.getAttribute("profile")).getWorkDescription() != null ? ((StudentProfile)request.getAttribute("profile")).getWorkDescription() : "" %></textarea>
                </div>

                <div class="btn-container">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Save
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function updateCVName(input) {
            const fileName = input.files[0]?.name || '';
            const cvNameDiv = document.getElementById('cvFileName');
            if (fileName) {
                cvNameDiv.innerHTML = '<i class="fas fa-file-check"></i> Selected: ' + fileName;
            } else {
                cvNameDiv.innerHTML = '';
            }
        }

        // Auto-hide alerts after 5 seconds
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.display = 'none';
            }, 5000);
        });
    </script>
</body>
</html>
