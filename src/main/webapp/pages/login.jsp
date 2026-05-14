<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Campus Job Portal</title>

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Navbar CSS -->
    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">

    <!-- External CSS -->
    <link rel="stylesheet" href="/CampusJobPortal/css/login.css">
</head>

<body>
    <!-- NAVBAR -->
    <%@ include file="../includes/navbar.jsp" %>

    <!-- ANIMATED BACKGROUND -->
    <div class="background-glow">
        <div class="glow glow-1"></div>
        <div class="glow glow-2"></div>
        <div class="glow glow-3"></div>
    </div>

    <!-- MAIN CONTAINER -->
    <div class="login-container">

        <!-- LOGIN CARD -->
        <div class="login-card">

            <!-- HEADER -->
            <div class="login-header">
                <div class="logo-circle">
                    <i class="fas fa-sign-in-alt"></i>
                </div>
                <h1>Welcome Back</h1>
                <p>Sign in to your account</p>
            </div>

            <!-- ALERT MESSAGES -->
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                String successMessage = (String) request.getAttribute("successMessage");

                if (errorMessage != null) {
            %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= errorMessage %>
                </div>
            <% } %>

            <% if (successMessage != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <%= successMessage %>
                </div>
            <% } %>

            <!-- LOGIN FORM -->
            <form action="/CampusJobPortal/LoginServlet" method="POST" class="login-form" id="loginForm">

                <!-- EMAIL -->
                <div class="form-group">
                    <div class="input-wrapper">
                        <input type="email" id="email" name="email" required>
                        <label for="email">
                            <i class="fas fa-envelope"></i> Email Address
                        </label>
                        <div class="input-line"></div>
                    </div>
                </div>

                <!-- PASSWORD -->
                <div class="form-group">
                    <div class="input-wrapper">
                        <input type="password" id="password" name="password" required>
                        <label for="password">
                            <i class="fas fa-lock"></i> Password
                        </label>
                        <div class="input-line"></div>

                        <button type="button" class="toggle-password" onclick="togglePassword()">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <!-- OPTIONS -->
                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="rememberMe">
                        <span>Remember me</span>
                    </label>
                    <a href="#" class="forgot-link">Forgot password?</a>
                </div>

                <!-- BUTTON -->
                <button type="submit" class="btn-login" id="loginBtn">
                    <span class="btn-text">Sign In</span>
                    <i class="fas fa-arrow-right"></i>
                </button>

            </form>

            <!-- SIGNUP -->
            <div class="signup-section">
                <p>Don't have an account? <a href="register.jsp">Create one</a></p>
            </div>

            <!-- DIVIDER -->
            <div class="divider">
                <span>Or continue as</span>
            </div>

            <!-- QUICK LINKS -->
            <div class="quick-links">
                <a href="#" class="quick-link student">
                    <i class="fas fa-graduation-cap"></i>
                </a>
                <a href="#" class="quick-link recruiter">
                    <i class="fas fa-briefcase"></i>
                </a>
            </div>

        </div>

        <!-- SIDE INFO -->
        <div class="login-info">
            <div class="info-content">
                <h2>Your Gateway to Success</h2>
                <ul class="info-list">
                    <li><i class="fas fa-star"></i> Find your dream job</li>
                    <li><i class="fas fa-star"></i> Connect with top companies</li>
                    <li><i class="fas fa-star"></i> Build your network</li>
                    <li><i class="fas fa-star"></i> Secure your future</li>
                </ul>
            </div>
        </div>

    </div>

    <!-- FOOTER -->
    <footer class="footer">
        <p>&copy; 2026 Campus Job Portal. Secure & Fast.</p>
    </footer>

    <!-- SCRIPTS -->
    <script>

        function togglePassword() {
            const passwordInput = document.getElementById("password");
            const toggleBtn = document.querySelector(".toggle-password");

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                toggleBtn.innerHTML = '<i class="fas fa-eye-slash"></i>';
            } else {
                passwordInput.type = "password";
                toggleBtn.innerHTML = '<i class="fas fa-eye"></i>';
            }
        }

        // Input animation
        document.querySelectorAll(".input-wrapper input").forEach(input => {
            input.addEventListener("focus", function() {
                this.parentElement.classList.add("focused");
            });

            input.addEventListener("blur", function() {
                if (!this.value) {
                    this.parentElement.classList.remove("focused");
                }
            });
        });

        // Submit animation
        document.getElementById("loginForm").addEventListener("submit", function() {
            const btn = document.getElementById("loginBtn");
            btn.classList.add("loading");
            btn.querySelector(".btn-text").textContent = "Signing in...";
        });

    </script>

</body>
</html>