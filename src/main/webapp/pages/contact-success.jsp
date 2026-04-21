<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Message Sent - Campus Job Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/contact-success.css">
</head>

<body>
    <!-- NAVBAR -->
    <%@ include file="../includes/navbar.jsp" %>

    <!-- ANIMATED BACKGROUND -->
    <div class="contact-background-glow">
        <div class="about-glow about-glow-1"></div>
        <div class="about-glow about-glow-2"></div>
    </div>

    <!-- MAIN CONTAINER -->
    <div class="success-container">
        <div class="success-card">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            
            <h1>Thank You!</h1>
            
            <p>Your message has been successfully sent. Our support team will review your inquiry and get back to you as soon as possible.</p>
            
            <p style="font-size: 0.9rem; color: #999; margin-bottom: 30px;">
                Expected response time: Within 24-48 hours
            </p>
            
            <a href="../index.jsp" class="btn-back-home">
                <i class="fas fa-home"></i> Back to Home
            </a>

            <div style="margin-top: 30px; padding-top: 20px; border-top: 1px solid rgba(212, 175, 55, 0.2); text-align: center;">
                <p style="color: #cccccc; font-size: 0.9rem; margin-bottom: 10px;">While you wait, you can:</p>
                <div style="display: flex; gap: 15px; justify-content: center; flex-wrap: wrap;">
                    <a href="about.jsp" style="color: #d4af37; text-decoration: none; font-size: 0.95rem;">Learn More About Us</a>
                    <span style="color: #666;">|</span>
                    <a href="../index.jsp" style="color: #d4af37; text-decoration: none; font-size: 0.95rem;">Explore Jobs</a>
                    <span style="color: #666;">|</span>
                    <a href="../pages/login.jsp" style="color: #d4af37; text-decoration: none; font-size: 0.95rem;">Sign In</a>
                </div>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer class="footer">
        <p>&copy; 2026 Campus Job Portal. All rights reserved.</p>
    </footer>
</body>
</html>
