<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Account - Campus Job Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/register.css">
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
    <div class="register-container">
        <!-- REGISTER CARD -->
        <div class="register-card">
            <!-- HEADER WITH LOGO -->
            <div class="register-header">
                <div class="logo-circle">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h1>Create Account</h1>
                <p>Join our community and start your journey</p>
            </div>

            <!-- ALERT MESSAGES -->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= errorMessage %>
                </div>
            <% } %>

            <!-- REGISTRATION FORM -->
            <form action="/CampusJobPortal/RegisterServlet" method="POST" class="register-form" id="registerForm">

                <!-- NAME ROW -->
                <div class="form-row">
                    <div class="form-group">
                        <div class="input-wrapper">
                            <input type="text" name="firstName" id="firstName" required>
                            <label for="firstName">
                                <i class="fas fa-user"></i> First Name
                            </label>
                            <div class="input-line"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-wrapper">
                            <input type="text" name="lastName" id="lastName" required>
                            <label for="lastName">
                                <i class="fas fa-user"></i> Last Name
                            </label>
                            <div class="input-line"></div>
                        </div>
                    </div>
                </div>

                <!-- EMAIL -->
                <div class="form-group">
                    <div class="input-wrapper">
                        <input type="email" name="email" id="email" required>
                        <label for="email">
                            <i class="fas fa-envelope"></i> Email Address
                        </label>
                        <div class="input-line"></div>
                    </div>
                </div>

                <!-- ROLE SELECTION -->
                <div class="form-group">
                    <label class="role-label">
                        <i class="fas fa-shield-alt"></i> Select Your Role
                    </label>
                    <div class="role-selector">
                        <input type="radio" name="userType" value="STUDENT" id="student" required onchange="toggleCompany()">
                        <label for="student" class="role-option">
                            <i class="fas fa-graduation-cap"></i>
                            <span>Student</span>
                        </label>

                        <input type="radio" name="userType" value="RECRUITER" id="recruiter" onchange="toggleCompany()">
                        <label for="recruiter" class="role-option">
                            <i class="fas fa-briefcase"></i>
                            <span>Recruiter</span>
                        </label>
                    </div>
                </div>

                <!-- COMPANY FIELD -->
                <div class="form-group" id="companyField" style="display:none;">
                    <div class="input-wrapper">
                        <input type="text" name="companyName" id="companyName">
                        <label for="companyName">
                            <i class="fas fa-building"></i> Company Name
                        </label>
                        <div class="input-line"></div>
                    </div>
                </div>

                <!-- PHONE -->
                <div class="form-group">
                    <div class="input-wrapper">
                        <input type="tel" name="phoneNumber" id="phone" required>
                        <label for="phone">
                            <i class="fas fa-phone"></i> Phone Number
                        </label>
                        <div class="input-line"></div>
                    </div>
                </div>

                <!-- PASSWORD -->
                <div class="form-group">
                    <div class="input-wrapper">
                        <input type="password" name="password" id="password" required>
                        <label for="password">
                            <i class="fas fa-lock"></i> Password
                        </label>
                        <div class="input-line"></div>
                        <button type="button" class="toggle-password" onclick="togglePassword('password')">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="password-strength">
                        <div class="strength-bar">
                            <span class="strength-fill" id="strengthBar"></span>
                        </div>
                        <span class="strength-text" id="strengthText">Weak</span>
                    </div>
                </div>

                <!-- CONFIRM PASSWORD -->
                <div class="form-group">
                    <div class="input-wrapper">
                        <input type="password" name="confirmPassword" id="confirmPassword" required>
                        <label for="confirmPassword">
                            <i class="fas fa-lock"></i> Confirm Password
                        </label>
                        <div class="input-line"></div>
                        <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword')">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <!-- SUBMIT BUTTON -->
                <button type="submit" class="btn-register" id="submitBtn">
                    <span class="btn-text">Create Account</span>
                    <i class="fas fa-arrow-right"></i>
                </button>

            </form>

            <!-- LOGIN LINK -->
            <div class="form-footer">
                <p>Already have an account? <a href="login.jsp">Sign in here</a></p>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer class="footer">
        <p>&copy; 2026 Campus Job Portal. All rights reserved.</p>
    </footer>

    <!-- SCRIPTS -->
    <script>
        // Toggle company field for recruiters
        function toggleCompany() {
            const recruiter = document.getElementById("recruiter").checked;
            const companyField = document.getElementById("companyField");
            companyField.style.display = recruiter ? "block" : "none";
            if (!recruiter) {
                document.getElementById("companyName").value = "";
            }
        }

        // Toggle password visibility
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const btn = event.target.closest('.toggle-password');
            
            if (field.type === "password") {
                field.type = "text";
                btn.innerHTML = '<i class="fas fa-eye-slash"></i>';
            } else {
                field.type = "password";
                btn.innerHTML = '<i class="fas fa-eye"></i>';
            }
        }

        // Password strength indicator
        document.getElementById("password").addEventListener("input", function() {
            const val = this.value;
            let strength = 0;
            
            if (val.length >= 8) strength++;
            if (val.length >= 12) strength++;
            if (/[a-z]/.test(val) && /[A-Z]/.test(val)) strength++;
            if (/[0-9]/.test(val)) strength++;
            if (/[^A-Za-z0-9]/.test(val)) strength++;

            const bar = document.getElementById("strengthBar");
            const text = document.getElementById("strengthText");
            
            bar.style.width = (strength * 20) + "%";
            
            const strengths = ["Weak", "Fair", "Good", "Strong", "Very Strong", "Excellent"];
            const colors = ["#e74c3c", "#f39c12", "#f1c40f", "#2ecc71", "#27ae60", "#1abc9c"];
            
            text.textContent = strengths[strength] || "Weak";
            bar.style.background = colors[strength] || "#e74c3c";
        });

        // Form submission with validation
        document.getElementById("registerForm").addEventListener("submit", function(e) {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const submitBtn = document.getElementById("submitBtn");

            if (password !== confirmPassword) {
                e.preventDefault();
                showError("Passwords do not match!");
                return;
            }

            if (password.length < 8) {
                e.preventDefault();
                showError("Password must be at least 8 characters long!");
                return;
            }

            submitBtn.classList.add("loading");
            submitBtn.querySelector(".btn-text").textContent = "Creating Account...";
            submitBtn.disabled = true;
        });

        // Error notification
        function showError(message) {
            const alert = document.createElement("div");
            alert.className = "alert alert-error";
            alert.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;
            
            const registerCard = document.querySelector(".register-card");
            registerCard.insertBefore(alert, registerCard.firstChild.nextSibling.nextSibling);
            
            setTimeout(() => alert.remove(), 4000);
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
    </script>

</body>
</html>