<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../includes/admin-sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <div>
                <h1>Dashboard Overview</h1>
                <p style="color: var(--text-muted);">Welcome back, System Administrator</p>
            </div>
            <div class="date-display" style="text-align: right;">
                <span id="currentDate" style="font-weight: 600;"></span>
            </div>
        </div>

        <!-- Notification Alerts -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
            <% session.removeAttribute("message"); %>
        </c:if>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Students</h3>
                <div class="value">${stats.totalStudents}</div>
                <div style="margin-top: 1rem; font-size: 0.8rem; color: var(--success-color);">
                    <i class="fas fa-arrow-up"></i> Registered Accounts
                </div>
            </div>
            <div class="stat-card">
                <h3>Total Recruiters</h3>
                <div class="value">${stats.totalRecruiters}</div>
                <div style="margin-top: 1rem; font-size: 0.8rem; color: var(--accent-color);">
                    <i class="fas fa-user-tie"></i> Verified Partners
                </div>
            </div>
            <div class="stat-card">
                <h3>Active Job Posts</h3>
                <div class="value">${stats.activeJobs}</div>
                <div style="margin-top: 1rem; font-size: 0.8rem; color: var(--success-color);">
                    <i class="fas fa-briefcase"></i> Live Opportunities
                </div>
            </div>
            <div class="stat-card">
                <h3>Applications</h3>
                <div class="value">${stats.totalApplications}</div>
                <div style="margin-top: 1rem; font-size: 0.8rem; color: var(--primary-color);">
                    <i class="fas fa-file-alt"></i> Processed Requests
                </div>
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 2rem;">
            <!-- Critical Actions -->
            <div class="table-container">
                <h2 style="margin: 1rem; font-size: 1.25rem;"><i class="fas fa-bell"></i> Pending Approvals</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Category</th>
                            <th>Pending Count</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Recruiter Verifications</td>
                            <td><span class="badge badge-pending">${stats.pendingRecruiters}</span></td>
                            <td><a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary btn-sm">Review</a></td>
                        </tr>
                        <tr>
                            <td>Job Post Moderation</td>
                            <td><span class="badge badge-pending">${stats.pendingJobs}</span></td>
                            <td><a href="${pageContext.request.contextPath}/admin/jobs" class="btn btn-primary btn-sm">Review</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Quick Access -->
            <div class="stat-card" style="height: fit-content;">
                <h3 style="margin-bottom: 1.5rem;">System Utilities</h3>
                <div style="display: flex; flex-direction: column; gap: 1rem;">
                    <a href="${pageContext.request.contextPath}/admin/reports" class="btn btn-success" style="width: 100%;">
                        <i class="fas fa-file-export"></i> Export Report
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/content" class="btn btn-primary" style="width: 100%;">
                        <i class="fas fa-cog"></i> Site Settings
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('currentDate').innerText = new Date().toLocaleDateString('en-US', { 
            weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' 
        });
    </script>
</body>
</html>
