<!-- NAVBAR WITH ROLE-BASED AUTHENTICATION -->
<nav class="navbar">
    <div class="navbar-content">
        <!-- LOGO -->
        <a href="/CampusJobPortal/" class="navbar-logo">
            <i class="fas fa-briefcase"></i>
            <div class="navbar-logo-text">
                <span>CampusJob</span>
                <span>Portal</span>
            </div>
        </a>

        <!-- HAMBURGER TOGGLE (Mobile) -->
        <button class="navbar-toggle" id="navbarToggle">
            <i class="fas fa-bars"></i>
        </button>

        <!-- NAVIGATION LINKS -->
        <ul class="nav-links" id="navLinks">
            <!-- GUEST NAVIGATION -->
            <li class="nav-item">
                <a href="/CampusJobPortal/" class="nav-link">
                    <i class="fas fa-home"></i> Home
                </a>
            </li>

            <li class="nav-item">
                <a href="/CampusJobPortal/pages/about.jsp" class="nav-link">
                    <i class="fas fa-info-circle"></i> About
                </a>
            </li>

            <li class="nav-item">
                <a href="/CampusJobPortal/pages/contact.jsp" class="nav-link">
                    <i class="fas fa-envelope"></i> Contact
                </a>
            </li>

            <!-- STUDENT NAVIGATION -->
            <% if ("student".equals(session.getAttribute("userRole"))) { %>
            <li class="nav-item">
                <a href="job-list.jsp" class="nav-link">
                    <i class="fas fa-briefcase"></i> Browse Jobs
                </a>
            </li>
            <li class="nav-item">
                <a href="applications.jsp" class="nav-link">
                    <i class="fas fa-file-alt"></i> My Applications
                </a>
            </li>
            <li class="nav-item">
                <a href="student-dashboard.jsp" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <% } %>

            <!-- RECRUITER NAVIGATION -->
            <% if ("recruiter".equals(session.getAttribute("userRole"))) { %>
            <li class="nav-item">
                <a href="post-job.jsp" class="nav-link">
                    <i class="fas fa-plus"></i> Post Job
                </a>
            </li>
            <li class="nav-item">
                <a href="recruiter-dashboard.jsp" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li class="nav-item dropdown">
                <a href="#" class="nav-link">
                    <i class="fas fa-cogs"></i> Manage <i class="fas fa-chevron-down"></i>
                </a>
                <div class="dropdown-content">
                    <a href="job-list.jsp" class="dropdown-item">
                        <i class="fas fa-list"></i> My Jobs
                    </a>
                    <a href="applications.jsp" class="dropdown-item">
                        <i class="fas fa-users"></i> Applications
                    </a>
                </div>
            </li>
            <% } %>

            <!-- ADMIN NAVIGATION -->
            <% if ("admin".equals(session.getAttribute("userRole"))) { %>
            <li class="nav-item">
                <a href="admin-dashboard.jsp" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li class="nav-item dropdown">
                <a href="#" class="nav-link">
                    <i class="fas fa-users"></i> Users <i class="fas fa-chevron-down"></i>
                </a>
                <div class="dropdown-content">
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-user-tie"></i> Manage Users
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-user-check"></i> Verify Accounts
                    </a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a href="#" class="nav-link">
                    <i class="fas fa-chart-bar"></i> Reports <i class="fas fa-chevron-down"></i>
                </a>
                <div class="dropdown-content">
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-chart-line"></i> Job Stats
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-chart-pie"></i> User Analytics
                    </a>
                </div>
            </li>
            <% } %>
        </ul>

        <!-- USER SECTION / AUTH BUTTONS -->
        <div class="navbar-user">
            <% String userEmail = (String) session.getAttribute("userEmail");
               String userRole = (String) session.getAttribute("userRole");
               if (userEmail != null) { %>
                <!-- LOGGED IN USER -->
                <div class="user-info">
                    <div class="user-avatar">
                        <%= userEmail.charAt(0) %>
                    </div>
                    <div class="user-details">
                        <span class="user-name"><%= userEmail.split("@")[0] %></span>
                        <span class="user-role"><%= userRole != null ? userRole : "User" %></span>
                    </div>
                </div>
                <form action="/CampusJobPortal/LogoutServlet" method="POST" style="display:inline;">
                    <button type="submit" class="btn-logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            <% } else { %>
                <!-- NOT LOGGED IN -->
                <div class="navbar-auth">
                    <a href="/CampusJobPortal/pages/login.jsp" class="btn-login-nav">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                    <a href="/CampusJobPortal/pages/register.jsp" class="btn-register-nav">
                        <i class="fas fa-user-plus"></i> Register
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</nav>

<!-- NAVBAR SCRIPTS -->
<script>
    // Mobile menu toggle
    const navbarToggle = document.getElementById('navbarToggle');
    const navLinks = document.getElementById('navLinks');

    if (navbarToggle) {
        navbarToggle.addEventListener('click', function() {
            navLinks.classList.toggle('active');
        });
    }

    // Close menu when link is clicked
    const navItems = document.querySelectorAll('.nav-link');
    navItems.forEach(item => {
        item.addEventListener('click', function() {
            navLinks.classList.remove('active');
        });
    });

    // Dropdown toggle for mobile
    const dropdowns = document.querySelectorAll('.dropdown');
    dropdowns.forEach(dropdown => {
        const link = dropdown.querySelector('.nav-link');
        link.addEventListener('click', function(e) {
            if (window.innerWidth <= 768) {
                e.preventDefault();
                dropdown.classList.toggle('active');
            }
        });
    });

    // Close menu on window resize
    window.addEventListener('resize', function() {
        if (window.innerWidth > 768) {
            navLinks.classList.remove('active');
            dropdowns.forEach(dropdown => {
                dropdown.classList.remove('active');
            });
        }
    });
</script>