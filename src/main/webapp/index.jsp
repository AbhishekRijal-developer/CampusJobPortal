<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Job Portal - Home</title>
    <link rel="icon" href="/CampusJobPortal/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/home.css">
</head>
<body>
    <!-- NAVBAR -->
    <%@ include file="includes/navbar.jsp" %>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h2>Welcome to Campus Job Portal</h2>
            <p>Connect Students with Employers for Campus Placements</p>
            <% 
                if (session.getAttribute("userEmail") == null) {
            %>
                <div class="hero-buttons">
                    <a href="/CampusJobPortal/pages/register.jsp" class="btn btn-primary">Get Started</a>
                    <a href="/CampusJobPortal/pages/login.jsp" class="btn btn-secondary">Sign In</a>
                </div>
            <% 
                }
            %>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="container">
            <h2>Our Features</h2>
            <div class="feature-grid">
                <div class="feature-card">
                    <i class="fas fa-graduation-cap"></i>
                    <h3>For Students</h3>
                    <p>Browse job listings, apply to positions, track applications, and manage your profile</p>
                </div>
                <div class="feature-card">
                    <i class="fas fa-briefcase"></i>
                    <h3>For Recruiters</h3>
                    <p>Post job openings, review applications, manage candidate profiles, and track placements</p>
                </div>
                <div class="feature-card">
                    <i class="fas fa-user-tie"></i>
                    <h3>Easy to Use</h3>
                    <p>Simple and intuitive interface for seamless job searching and recruitment experience</p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta">
        <div class="container">
            <h2>Ready to Get Started?</h2>
            <p>Join thousands of students and recruiters on Campus Job Portal</p>
            <div class="cta-buttons">
                <a href="/CampusJobPortal/pages/register.jsp" class="btn btn-primary">Create Account</a>
                <a href="/CampusJobPortal/pages/login.jsp" class="btn btn-secondary">Sign In</a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2026 Campus Job Portal. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
