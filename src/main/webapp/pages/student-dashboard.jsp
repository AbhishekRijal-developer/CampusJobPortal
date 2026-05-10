<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.campusjobportal.model.Application" %>
<%@ page import="com.campusjobportal.model.Job" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Campus Job Portal</title>
    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/student-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .sidebar {
            position: fixed !important;
            top: 60px !important;
            left: 0 !important;
            width: 280px !important;
            height: calc(100vh - 60px) !important;
            background: linear-gradient(180deg, #1e293b 0%, #2d3748 100%) !important;
            border-right: 2px solid rgba(212, 175, 55, 0.2) !important;
            z-index: 999 !important;
            overflow-y: auto !important;
            overflow-x: hidden !important;
            padding-top: 1rem !important;
        }

        .sidebar-menu {
            display: flex !important;
            flex-direction: column !important;
            padding: 0.75rem !important;
        }

        .menu-item {
            display: flex !important;
            align-items: center !important;
            width: 100% !important;
            padding: 0.9rem 1rem !important;
            margin-bottom: 0.5rem !important;
            color: #a1aac3 !important;
            text-decoration: none !important;
            border-radius: 0.75rem !important;
            transition: all 0.3s ease !important;
        }

        .menu-item:hover,
        .menu-item.active {
            background: rgba(212, 175, 55, 0.15) !important;
            color: #d4af37 !important;
            transform: translateX(3px) !important;
        }

        .menu-item.active {
            background: linear-gradient(135deg, #d4af37, #e5c158) !important;
            color: #0f172a !important;
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3) !important;
        }

        .menu-item i {
            min-width: 20px !important;
            margin-right: 0.75rem !important;
            font-size: 1.1rem !important;
        }

        .dashboard-wrapper {
            margin-left: 280px !important;
            margin-top: 60px !important;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 80px !important;
            }
            .sidebar-header h2,
            .menu-item span {
                display: none !important;
            }
            .dashboard-wrapper {
                margin-left: 80px !important;
            }
        }

        @media (max-width: 480px) {
            .sidebar {
                width: 70px !important;
            }
            .dashboard-wrapper {
                margin-left: 70px !important;
            }
            .dashboard-container {
                padding: 30px 10px 20px !important;
            }
        }
    </style>
</head>
<body>
    <%@ include file="../includes/navbar.jsp" %>
    <%@ include file="../includes/student-sidebar.jsp" %>

    <!-- BACKGROUND GLOW -->
    <div class="dashboard-bg">
        <div class="glow glow1"></div>
        <div class="glow glow2"></div>
    </div>

    <div class="dashboard-wrapper" style="margin-left: 280px; margin-top: 60px;">
        <div class="dashboard-container">
        <!-- HEADER -->
        <div class="dashboard-header">
            <div class="header-content">
                <h1><i class="fas fa-graduation-cap"></i> Student Dashboard</h1>
                <p>Welcome back, <span class="student-name"><%= session.getAttribute("userName") %></span>!</p>
            </div>
            <div class="header-stats">
                <div class="stat-badge">
                    <span class="stat-value"><%= request.getAttribute("totalApplications") != null ? request.getAttribute("totalApplications") : 0 %></span>
                    <span class="stat-label">Total Applications</span>
                </div>
            </div>
        </div>

        <!-- STATISTICS CARDS -->
        <div class="stats-section">
            <h2 class="section-title"><i class="fas fa-chart-bar"></i> Your Statistics</h2>
            <div class="stats-grid">
                <div class="stat-card pending">
                    <div class="stat-icon">
                        <i class="fas fa-hourglass-half"></i>
                    </div>
                    <div class="stat-info">
                        <h3><%= request.getAttribute("pendingApplications") != null ? request.getAttribute("pendingApplications") : 0 %></h3>
                        <p>Pending Applications</p>
                    </div>
                </div>

                <div class="stat-card approved">
                    <div class="stat-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-info">
                        <h3><%= request.getAttribute("approvedApplications") != null ? request.getAttribute("approvedApplications") : 0 %></h3>
                        <p>Approved Applications</p>
                    </div>
                </div>

                <div class="stat-card rejected">
                    <div class="stat-icon">
                        <i class="fas fa-times-circle"></i>
                    </div>
                    <div class="stat-info">
                        <h3><%= request.getAttribute("rejectedApplications") != null ? request.getAttribute("rejectedApplications") : 0 %></h3>
                        <p>Rejected Applications</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- QUICK ACTIONS -->
        <div class="actions-section">
            <h2 class="section-title"><i class="fas fa-lightning-bolt"></i> Quick Actions</h2>
            <div class="actions-grid">
                <a href="/CampusJobPortal/BrowseJobsServlet" class="action-btn browse">
                    <i class="fas fa-search"></i>
                    <h3>Browse Jobs</h3>
                    <p>Find new opportunities</p>
                </a>

                <a href="/CampusJobPortal/MyApplicationsServlet" class="action-btn applications">
                    <i class="fas fa-file-alt"></i>
                    <h3>My Applications</h3>
                    <p>View all your applications</p>
                </a>

                <a href="/CampusJobPortal/StudentProfileServlet" class="action-btn profile">
                    <i class="fas fa-edit"></i>
                    <h3>Edit Profile</h3>
                    <p>Update your information</p>
                </a>

                <a href="/CampusJobPortal/pages/job-detail.jsp" class="action-btn view-profile">
                    <i class="fas fa-user-circle"></i>
                    <h3>View Profile</h3>
                    <p>See your profile</p>
                </a>
            </div>
        </div>

        <!-- RECENT APPLICATIONS -->
        <div class="applications-section">
            <h2 class="section-title"><i class="fas fa-inbox"></i> Recent Applications</h2>
            <%
                List<Application> applications = (List<Application>) request.getAttribute("applications");
                if (applications != null && !applications.isEmpty()) {
                    if (applications.size() > 5) {
                        applications = applications.subList(0, 5);
                    }
            %>
            <div class="applications-table">
                <table>
                    <thead>
                        <tr>
                            <th>Job Title</th>
                            <th>Company</th>
                            <th>Status</th>
                            <th>Applied Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Application app : applications) {
                                String statusClass = "";
                                if ("PENDING".equals(app.getStatus())) {
                                    statusClass = "status-pending";
                                } else if ("APPROVED".equals(app.getStatus())) {
                                    statusClass = "status-approved";
                                } else if ("REJECTED".equals(app.getStatus())) {
                                    statusClass = "status-rejected";
                                }
                        %>
                        <tr>
                            <td class="job-title"><strong><%= app.getJobTitle() %></strong></td>
                            <td><%= app.getRecruiterName() %></td>
                            <td>
                                <span class="status-badge <%= statusClass %>">
                                    <%= app.getStatus() %>
                                </span>
                            </td>
                            <td><%= app.getApplicationDate() %></td>
                            <td>
                                <a href="/CampusJobPortal/pages/job-detail.jsp?id=<%= app.getJobId() %>" class="view-btn">
                                    View
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <div class="view-all-btn">
                <a href="/CampusJobPortal/pages/my-applications.jsp" class="btn-link">
                    View All Applications <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            <% } else { %>
            <div class="no-data">
                <i class="fas fa-inbox"></i>
                <p>No applications yet. Start browsing jobs to apply!</p>
                <a href="/CampusJobPortal/BrowseJobsServlet" class="btn-primary">Browse Jobs</a>
            </div>
            <% } %>
        </div>

        <!-- RECENT JOB POSTINGS -->
        <div class="jobs-section">
            <h2 class="section-title"><i class="fas fa-briefcase"></i> Recent Job Postings</h2>
            <%
                List<Job> jobs = (List<Job>) request.getAttribute("recentJobs");
                if (jobs != null && !jobs.isEmpty()) {
            %>
            <div class="jobs-grid">
                <%
                    for (Job job : jobs) {
                %>
                <div class="job-card">
                    <div class="job-header">
                        <h3><%= job.getTitle() %></h3>
                        <span class="job-category"><%= job.getCategory() %></span>
                    </div>
                    <div class="job-details">
                        <p><i class="fas fa-map-marker-alt"></i> <%= job.getLocation() %></p>
                        <p><i class="fas fa-calendar"></i> Deadline: <%= job.getDeadline() %></p>
                    </div>
                    <p class="job-description"><%= job.getDescription().length() > 100 ? 
                        job.getDescription().substring(0, 100) + "..." : job.getDescription() %></p>
                    <a href="/CampusJobPortal/pages/job-detail.jsp?id=<%= job.getId() %>" class="job-btn">
                        View Details
                    </a>
                </div>
                <% } %>
            </div>
            <div class="view-all-btn">
                <a href="/CampusJobPortal/BrowseJobsServlet" class="btn-link">
                    Browse All Jobs <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            <% } else { %>
            <div class="no-data">
                <i class="fas fa-briefcase"></i>
                <p>No jobs available at the moment. Check back soon!</p>
            </div>
            <% } %>
        </div>

        <!-- PROFILE SUMMARY -->
        <%
            com.campusjobportal.model.StudentProfile profile = (com.campusjobportal.model.StudentProfile) request.getAttribute("profile");
            com.campusjobportal.model.User user = (com.campusjobportal.model.User) request.getAttribute("user");
        %>
        <div class="profile-section">
            <h2 class="section-title"><i class="fas fa-id-card"></i> Profile Summary</h2>
            <div class="profile-card">
                <div class="profile-left">
                    <div class="profile-avatar">
                        <i class="fas fa-user-graduate"></i>
                    </div>
                </div>
                <div class="profile-right">
                    <h3><%= user.getFirstName() %> <%= user.getLastName() %></h3>
                    <p class="email"><i class="fas fa-envelope"></i> <%= user.getEmail() %></p>
                    <p class="phone"><i class="fas fa-phone"></i> <%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "Not provided" %></p>
                    
                    <%
                        if (profile != null) {
                    %>
                    <div class="profile-details">
                        <div class="detail-row">
                            <span class="detail-label">Institution:</span>
                            <span class="detail-value"><%= profile.getInstitution() != null ? profile.getInstitution() : "Not provided" %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Degree:</span>
                            <span class="detail-value"><%= profile.getDegree() != null ? profile.getDegree() : "Not provided" %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Expected Graduation:</span>
                            <span class="detail-value"><%= profile.getExpectedGraduation() > 0 ? profile.getExpectedGraduation() : "Not provided" %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Skills:</span>
                            <span class="detail-value"><%= profile.getSkills() != null ? profile.getSkills() : "Not added" %></span>
                        </div>
                    </div>
                    <% } else { %>
                    <p class="no-profile">Profile not yet created. <a href="/CampusJobPortal/pages/student-profile.jsp">Complete your profile</a></p>
                    <% } %>
                    
                    <a href="/CampusJobPortal/pages/student-profile.jsp" class="btn-primary">Edit Profile</a>
                </div>
            </div>
        </div>

    </div>

    <script>
        // Form validation
        function validateForm(form) {
            const inputs = form.querySelectorAll('input, textarea, select');
            for (let input of inputs) {
                if (input.hasAttribute('required') && !input.value.trim()) {
                    alert('Please fill in all required fields');
                    input.focus();
                    return false;
                }
            }
            return true;
        }

        // Status color indicator
        document.querySelectorAll('.status-badge').forEach(badge => {
            const status = badge.textContent.trim();
            if (status === 'PENDING') {
                badge.classList.add('pending');
            } else if (status === 'APPROVED') {
                badge.classList.add('approved');
            } else if (status === 'REJECTED') {
                badge.classList.add('rejected');
            }
        });

        // Smooth scroll to sections
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth' });
                }
            });
        });
    </script>
        </div>
    </div>
</body>
</html>
