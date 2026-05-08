<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytical Reports | Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @media print {
            .sidebar, .header .btn, .no-print { display: none !important; }
            .main-content { margin-left: 0; padding: 0; }
            .stat-card { border: 1px solid #ddd; background: #fff !important; color: #000 !important; }
            .stat-card * { color: #000 !important; }
            body { background: white; color: black; }
        }
    </style>
</head>
<body>
    <jsp:include page="../../includes/admin-sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <div>
                <h1>Analytical Reports</h1>
                <p style="color: var(--text-muted);">System-wide performance metrics</p>
            </div>
            <button onclick="window.print()" class="btn btn-primary no-print">
                <i class="fas fa-print"></i> Print System Report
            </button>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>Student Population</h3>
                <div class="value">${stats.totalStudents}</div>
                <div style="margin-top: 1rem; font-size: 0.85rem;">Total registered students</div>
            </div>
            <div class="stat-card">
                <h3>Recruiter Partners</h3>
                <div class="value">${stats.totalRecruiters}</div>
                <div style="margin-top: 1rem; font-size: 0.85rem;">Approved recruiting companies</div>
            </div>
            <div class="stat-card">
                <h3>Live Opportunities</h3>
                <div class="value">${stats.activeJobs}</div>
                <div style="margin-top: 1rem; font-size: 0.85rem;">Currently active job postings</div>
            </div>
            <div class="stat-card">
                <h3>Application Volume</h3>
                <div class="value">${stats.totalApplications}</div>
                <div style="margin-top: 1rem; font-size: 0.85rem;">Total applications submitted</div>
            </div>
        </div>

        <div class="table-container">
            <h2 style="margin: 1rem; font-size: 1.25rem;"><i class="fas fa-chart-line"></i> Critical KPIs</h2>
            <table>
                <thead>
                    <tr>
                        <th>Metric Type</th>
                        <th>Current Count</th>
                        <th>Priority Level</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Pending Recruiter Approvals</td>
                        <td><div class="value" style="font-size: 1.25rem;">${stats.pendingRecruiters}</div></td>
                        <td><span class="badge badge-pending">High</span></td>
                    </tr>
                    <tr>
                        <td>Pending Job Moderation</td>
                        <td><div class="value" style="font-size: 1.25rem;">${stats.pendingJobs}</div></td>
                        <td><span class="badge badge-pending">Medium</span></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="no-print" style="margin-top: 3rem; text-align: center; color: var(--text-muted);">
            <i class="fas fa-info-circle"></i> This report is generated in real-time based on current database state.
        </div>
    </div>
</body>
</html>
