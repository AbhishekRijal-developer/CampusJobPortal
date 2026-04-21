<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us - Campus Job Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/about.css">
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
    <div class="about-container">
        <div class="about-content">
            <!-- HEADER -->
            <div class="about-header">
                <h1><i class="fas fa-building"></i> Campus Job Portal</h1>
                <p>Bridging the Gap Between Students and Employers</p>
            </div>

            <!-- MISSION SECTION -->
            <div class="about-section">
                <h2><i class="fas fa-bullseye"></i> Our Mission</h2>
                <p>
                    Campus Job Portal aims to revolutionize campus recruitment in Nepal by providing a secure, 
                    transparent, and efficient digital platform. We connect final-year students with premier companies 
                    visiting college campuses, particularly benefiting institutions outside Kathmandu that have limited 
                    exposure to corporate recruiters.
                </p>
                <p>
                    Our mission is to replace paper-based hiring processes with a modern, accessible system that 
                    empowers both students and employers to make informed decisions.
                </p>
            </div>

            <!-- VISION SECTION -->
            <div class="about-section">
                <h2><i class="fas fa-lightbulb"></i> Our Vision</h2>
                <p>
                    To become Nepal's leading digital recruitment platform for academic institutions, creating 
                    equal opportunities for all college students regardless of their geographic location or institutional 
                    resources. We envision a Nepal where campus hiring is transparent, efficient, and accessible to every 
                    student seeking their first job.
                </p>
            </div>

            <!-- KEY FEATURES SECTION -->
            <div class="about-section">
                <h2><i class="fas fa-star"></i> Key Features</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <i class="fas fa-lock"></i>
                        <h3>Secure & Encrypted</h3>
                        <p>SHA-256 password encryption and role-based access control protect all user data</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-user-check"></i>
                        <h3>Role-Based Access</h3>
                        <p>Distinct dashboards for Students, Recruiters, and Administrators</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-search"></i>
                        <h3>Advanced Search</h3>
                        <p>Filter jobs by title, company, location, category, and deadline</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-file-upload"></i>
                        <h3>CV Management</h3>
                        <p>Secure PDF upload and storage with controlled access</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-chart-bar"></i>
                        <h3>Real-Time Analytics</h3>
                        <p>Track application status and view comprehensive recruitment metrics</p>
                    </div>
                    <div class="feature-card">
                        <i class="fas fa-mobile-alt"></i>
                        <h3>Responsive Design</h3>
                        <p>Beautiful, accessible interface that works on all devices</p>
                    </div>
                </div>
            </div>

            <!-- WHO WE SERVE SECTION -->
            <div class="about-section">
                <h2><i class="fas fa-users"></i> Who We Serve</h2>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 20px;">
                    <div style="background: rgba(212, 175, 55, 0.1); padding: 20px; border-radius: 10px; border-left: 3px solid #d4af37;">
                        <h3 style="color: #d4af37; margin-bottom: 10px;"><i class="fas fa-graduation-cap"></i> Students</h3>
                        <p style="color: #cccccc;">Create profiles, upload CVs, search for jobs, and track application status in real-time</p>
                    </div>
                    <div style="background: rgba(212, 175, 55, 0.1); padding: 20px; border-radius: 10px; border-left: 3px solid #d4af37;">
                        <h3 style="color: #d4af37; margin-bottom: 10px;"><i class="fas fa-briefcase"></i> Recruiters</h3>
                        <p style="color: #cccccc;">Post jobs, manage applications, view candidate profiles, and access recruitment analytics</p>
                    </div>
                    <div style="background: rgba(212, 175, 55, 0.1); padding: 20px; border-radius: 10px; border-left: 3px solid #d4af37;">
                        <h3 style="color: #d4af37; margin-bottom: 10px;"><i class="fas fa-shield-alt"></i> Administrators</h3>
                        <p style="color: #cccccc;">Manage users, approve postings, monitor platform integrity, and generate reports</p>
                    </div>
                </div>
            </div>

            <!-- TECHNOLOGY SECTION -->
            <div class="about-section">
                <h2><i class="fas fa-code"></i> Technology Stack</h2>
                <p style="margin-bottom: 20px;">Built with modern, reliable technologies to ensure performance and security:</p>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px;">
                    <div style="background: rgba(212, 175, 55, 0.15); padding: 15px; border-radius: 8px; text-align: center;">
                        <p style="color: #d4af37; font-weight: bold; margin-bottom: 5px;">Backend</p>
                        <p style="color: #cccccc; margin: 0;">Java J2EE</p>
                    </div>
                    <div style="background: rgba(212, 175, 55, 0.15); padding: 15px; border-radius: 8px; text-align: center;">
                        <p style="color: #d4af37; font-weight: bold; margin-bottom: 5px;">Frontend</p>
                        <p style="color: #cccccc; margin: 0;">JSP, CSS3, JavaScript</p>
                    </div>
                    <div style="background: rgba(212, 175, 55, 0.15); padding: 15px; border-radius: 8px; text-align: center;">
                        <p style="color: #d4af37; font-weight: bold; margin-bottom: 5px;">Database</p>
                        <p style="color: #cccccc; margin: 0;">MySQL</p>
                    </div>
                    <div style="background: rgba(212, 175, 55, 0.15); padding: 15px; border-radius: 8px; text-align: center;">
                        <p style="color: #d4af37; font-weight: bold; margin-bottom: 5px;">Architecture</p>
                        <p style="color: #cccccc; margin: 0;">MVC Pattern</p>
                    </div>
                </div>
            </div>

            <!-- VALUES SECTION -->
            <div class="about-section">
                <h2><i class="fas fa-heart"></i> Our Values</h2>
                <p><strong style="color: #d4af37;">Transparency:</strong> All job postings are visible, and application statuses are trackable</p>
                <p><strong style="color: #d4af37;">Fairness:</strong> Unbiased processes with admin approval workflows prevent fraudulent postings</p>
                <p><strong style="color: #d4af37;">Security:</strong> Advanced encryption and role-based access control protect user data</p>
                <p><strong style="color: #d4af37;">Accessibility:</strong> Responsive design ensures equal access regardless of device or location</p>
                <p><strong style="color: #d4af37;">Innovation:</strong> Continuous improvements to modernize campus recruitment in Nepal</p>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer class="footer">
        <p>&copy; 2026 Campus Job Portal. All rights reserved.</p>
    </footer>
</body>
</html>
