<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us - Campus Job Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/contact.css">
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
    <div class="contact-container">
        <div class="contact-content">
            <!-- HEADER -->
            <div class="contact-header">
                <h1><i class="fas fa-envelope"></i> Get In Touch</h1>
                <p>Have questions? We'd love to hear from you. Send us a message!</p>
            </div>

            <!-- CONTACT WRAPPER -->
            <div class="contact-wrapper">
                <!-- CONTACT INFO -->
                <div class="contact-info">
                    <div class="info-card">
                        <i class="fas fa-map-marker-alt"></i>
                        <h3>Address</h3>
                        <p>Itahari International College<br>Itahari, Sunsari<br>Nepal</p>
                    </div>

                    <div class="info-card">
                        <i class="fas fa-phone"></i>
                        <h3>Phone</h3>
                        <p>+977 (0) 25-525600<br>+977 (0) 25-525601</p>
                    </div>

                    <div class="info-card">
                        <i class="fas fa-envelope"></i>
                        <h3>Email</h3>
                        <p>support@campusjobportal.edu.np<br>info@campusjobportal.edu.np</p>
                    </div>

                    <div class="info-card">
                        <i class="fas fa-clock"></i>
                        <h3>Business Hours</h3>
                        <p>Monday - Friday: 9:00 AM - 5:00 PM<br>Saturday: 10:00 AM - 3:00 PM<br>Sunday: Closed</p>
                    </div>
                </div>

                <!-- CONTACT FORM -->
                <form action="contact-success.jsp" method="POST" class="contact-form" id="contactForm">
                    <div class="form-group">
                        <label for="name"><i class="fas fa-user"></i> Full Name</label>
                        <input type="text" id="name" name="name" required placeholder="Enter your full name">
                    </div>

                    <div class="form-group">
                        <label for="email"><i class="fas fa-envelope"></i> Email Address</label>
                        <input type="email" id="email" name="email" required placeholder="your.email@example.com">
                    </div>

                    <div class="form-group">
                        <label for="phone"><i class="fas fa-phone"></i> Phone Number</label>
                        <input type="tel" id="phone" name="phone" placeholder="Your phone number">
                    </div>

                    <div class="form-group">
                        <label for="subject"><i class="fas fa-heading"></i> Subject</label>
                        <input type="text" id="subject" name="subject" required placeholder="What is this about?">
                    </div>

                    <div class="form-group">
                        <label for="category"><i class="fas fa-list"></i> Category</label>
                        <select id="category" name="category">
                            <option value="general">General Inquiry</option>
                            <option value="technical">Technical Support</option>
                            <option value="account">Account Issue</option>
                            <option value="complaint">Complaint</option>
                            <option value="partnership">Partnership</option>
                            <option value="feedback">Feedback</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="message"><i class="fas fa-comments"></i> Message</label>
                        <textarea id="message" name="message" required placeholder="Tell us more about your inquiry..."></textarea>
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-paper-plane"></i> Send Message
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer class="footer">
        <p>&copy; 2026 Campus Job Portal. All rights reserved.</p>
    </footer>

    <script>
        // Form validation
        document.getElementById('contactForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return false;
            }
            
            // Optional: Add more validation as needed
        });
    </script>
</body>
</html>
