<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Job Details - Campus Job Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/job-detail.css">
</head>

<body>
    <!-- NAVBAR -->
    <%@ include file="../includes/navbar.jsp" %>

    <!-- ANIMATED BACKGROUND -->
    <div class="about-background-glow">
        <div class="about-glow about-glow-1"></div>
        <div class="about-glow about-glow-2"></div>
    </div>

    <!-- MAIN CONTAINER -->
    <div class="job-detail-container">
        <div class="job-detail-content">
            <!-- JOB HEADER -->
            <div class="job-header">
                <div class="job-title">Senior Java Developer</div>
                <div class="job-company"><i class="fas fa-building"></i> Tech Solutions Nepal</div>
                
                <div class="job-meta">
                    <div class="meta-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>Kathmandu, Nepal</span>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-briefcase"></i>
                        <span>Full-Time</span>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-calendar"></i>
                        <span>Posted: April 18, 2026</span>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-hourglass-end"></i>
                        <span>Deadline: May 18, 2026</span>
                    </div>
                </div>
            </div>

            <!-- JOB BODY -->
            <div class="job-body">
                <!-- MAIN DETAILS -->
                <div class="job-details">
                    <!-- ABOUT THE JOB -->
                    <div class="job-section">
                        <h2><i class="fas fa-info-circle"></i> About the Job</h2>
                        <p>
                            We are looking for an experienced Senior Java Developer to join our growing team at Tech Solutions Nepal. 
                            You will work on challenging projects, mentor junior developers, and contribute to our mission of delivering 
                            high-quality software solutions to clients across various industries.
                        </p>
                        <p>
                            This is an excellent opportunity to advance your career with a company that values innovation, teamwork, 
                            and continuous learning. You will have the chance to work with cutting-edge technologies and a talented team 
                            of professionals.
                        </p>
                    </div>

                    <!-- RESPONSIBILITIES -->
                    <div class="job-section">
                        <h2><i class="fas fa-tasks"></i> Key Responsibilities</h2>
                        <ul>
                            <li>Design and develop robust Java applications using modern frameworks</li>
                            <li>Collaborate with cross-functional teams to understand requirements and deliver solutions</li>
                            <li>Write clean, maintainable code following best practices and design patterns</li>
                            <li>Conduct code reviews and provide constructive feedback to team members</li>
                            <li>Mentor junior developers and contribute to team growth</li>
                            <li>Participate in system architecture design and technical discussions</li>
                            <li>Troubleshoot issues and provide technical support when needed</li>
                            <li>Stay updated with industry trends and new technologies</li>
                        </ul>
                    </div>

                    <!-- REQUIREMENTS -->
                    <div class="job-section">
                        <h2><i class="fas fa-graduation-cap"></i> Requirements</h2>
                        <ul>
                            <li>Bachelor's degree in Computer Science or related field</li>
                            <li>5+ years of professional experience in Java development</li>
                            <li>Strong knowledge of object-oriented programming and design patterns</li>
                            <li>Experience with Spring Boot, Hibernate, and RESTful APIs</li>
                            <li>Proficiency in SQL and database design</li>
                            <li>Experience with version control systems (Git)</li>
                            <li>Excellent problem-solving and analytical skills</li>
                            <li>Strong communication and teamwork abilities</li>
                            <li>Experience with cloud platforms (AWS, Azure) is a plus</li>
                        </ul>
                    </div>

                    <!-- BENEFITS -->
                    <div class="job-section">
                        <h2><i class="fas fa-gift"></i> Benefits & Perks</h2>
                        <ul>
                            <li>Competitive salary package</li>
                            <li>Health and wellness benefits</li>
                            <li>Professional development opportunities</li>
                            <li>Flexible working hours</li>
                            <li>Annual performance bonus</li>
                            <li>Paid time off and holidays</li>
                            <li>Team building activities and events</li>
                            <li>Modern office workspace with great work environment</li>
                        </ul>
                    </div>

                    <!-- ABOUT COMPANY -->
                    <div class="job-section">
                        <h2><i class="fas fa-building"></i> About the Company</h2>
                        <p>
                            Tech Solutions Nepal is a leading software development company headquartered in Kathmandu, Nepal. 
                            With over 100+ employees, we specialize in building custom software solutions for businesses ranging from 
                            startups to enterprises. Our portfolio includes successful projects across various domains including e-commerce, 
                            healthcare, finance, and education.
                        </p>
                        <p>
                            We are committed to fostering a culture of innovation, excellence, and continuous improvement. Our team consists 
                            of talented professionals from diverse backgrounds who are passionate about delivering exceptional results.
                        </p>
                    </div>

                    <!-- HOW TO APPLY -->
                    <div class="job-section">
                        <h2><i class="fas fa-check-square"></i> How to Apply</h2>
                        <p>
                            Interested candidates should submit their updated CV/Resume along with a cover letter outlining their 
                            relevant experience and why they are interested in this position. Applications will be reviewed on a rolling 
                            basis, and shortlisted candidates will be contacted for interviews.
                        </p>
                    </div>
                </div>

                <!-- SIDEBAR -->
                <div class="job-sidebar">
                    <!-- SALARY CARD -->
                    <div class="job-card">
                        <h3><i class="fas fa-money-bill-wave"></i> Salary</h3>
                        <div class="salary-display">₨ 80,000 - ₨ 120,000</div>
                        <div class="salary-period">Per Month</div>
                    </div>

                    <!-- STATUS CARD -->
                    <div class="job-card">
                        <h3><i class="fas fa-briefcase"></i> Job Status</h3>
                        <div class="job-status">
                            <i class="fas fa-check-circle"></i> Active
                        </div>
                    </div>

                    <!-- QUICK INFO CARD -->
                    <div class="job-card">
                        <h3><i class="fas fa-list"></i> Job Details</h3>
                        <p style="margin-bottom: 10px;"><strong style="color: #d4af37;">Experience Level:</strong> <span style="color: #cccccc;">Senior</span></p>
                        <p style="margin-bottom: 10px;"><strong style="color: #d4af37;">Job Type:</strong> <span style="color: #cccccc;">Full-Time</span></p>
                        <p style="margin-bottom: 10px;"><strong style="color: #d4af37;">Category:</strong> <span style="color: #cccccc;">IT/Software</span></p>
                        <p style="margin-bottom: 10px;"><strong style="color: #d4af37;">Industry:</strong> <span style="color: #cccccc;">Technology</span></p>
                    </div>

                    <!-- APPLICATIONS -->
                    <div class="job-card">
                        <h3><i class="fas fa-users"></i> Applications</h3>
                        <p style="color: #cccccc;">Total Applications: <strong style="color: #d4af37;">45</strong></p>
                    </div>

                    <!-- ACTION BUTTONS -->
                    <button class="btn-apply" onclick="handleApply()">
                        <i class="fas fa-paper-plane"></i> Apply Now
                    </button>

                    <button class="btn-bookmark" onclick="handleBookmark()">
                        <i class="fas fa-bookmark"></i> Bookmark Job
                    </button>

                    <!-- REPORT BUTTON -->
                    <button class="btn-bookmark" style="background: rgba(220, 53, 69, 0.1); color: #dc3545; border-color: #dc3545; margin-top: 10px;" onclick="handleReport()">
                        <i class="fas fa-flag"></i> Report Job
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer class="footer">
        <p>&copy; 2026 Campus Job Portal. All rights reserved.</p>
    </footer>

    <script>
        function handleApply() {
            // Check if user is logged in
            const userType = '<%= session.getAttribute("userType") != null ? session.getAttribute("userType") : "" %>';
            
            if (!userType) {
                alert('Please log in to apply for jobs');
                window.location.href = '/CampusJobPortal/pages/login.jsp';
            } else if (userType === 'STUDENT') {
                alert('Application submitted! The recruiter will review your profile and CV.');
                // Redirect to applications page
                // window.location.href = 'student-applications.jsp';
            } else {
                alert('Only students can apply for jobs');
            }
        }

        function handleBookmark() {
            const userType = '<%= session.getAttribute("userType") != null ? session.getAttribute("userType") : "" %>';
            
            if (!userType) {
                alert('Please log in to bookmark jobs');
                window.location.href = '/CampusJobPortal/pages/login.jsp';
            } else {
                alert('Job bookmarked! You can view it in your wishlist.');
            }
        }

        function handleReport() {
            const userType = '<%= session.getAttribute("userType") != null ? session.getAttribute("userType") : "" %>';
            
            if (!userType) {
                alert('Please log in to report jobs');
                window.location.href = '/CampusJobPortal/pages/login.jsp';
            } else {
                alert('Thank you for reporting. Our team will review this job posting.');
            }
        }
    </script>
</body>
</html>
