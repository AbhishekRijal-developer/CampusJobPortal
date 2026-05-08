<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <div class="sidebar-header">
        <h2><i class="fas fa-shield-alt"></i> <span>AdminPanel</span></h2>
    </div>
    <div class="sidebar-menu">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item ${currentPage == 'dashboard' ? 'active' : ''}">
            <i class="fas fa-th-large"></i> <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="menu-item ${currentPage == 'users' ? 'active' : ''}">
            <i class="fas fa-user-shield"></i> <span>Manage Users</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/jobs" class="menu-item ${currentPage == 'jobs' ? 'active' : ''}">
            <i class="fas fa-briefcase"></i> <span>Approve Jobs</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/applications" class="menu-item ${currentPage == 'applications' ? 'active' : ''}">
            <i class="fas fa-file-contract"></i> <span>Applications</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/complaints" class="menu-item ${currentPage == 'complaints' ? 'active' : ''}">
            <i class="fas fa-exclamation-circle"></i> <span>Complaints</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/reports" class="menu-item ${currentPage == 'reports' ? 'active' : ''}">
            <i class="fas fa-chart-pie"></i> <span>Analytical Reports</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/content" class="menu-item ${currentPage == 'content' ? 'active' : ''}">
            <i class="fas fa-edit"></i> <span>Content CMS</span>
        </a>
        
        <div style="margin-top: 2rem; padding-top: 1rem; border-top: 1px solid var(--border-color);">
            <a href="${pageContext.request.contextPath}/" class="menu-item">
                <i class="fas fa-external-link-alt"></i> <span>View Site</span>
            </a>
            <form action="${pageContext.request.contextPath}/LogoutServlet" method="POST" style="margin: 0;">
                <button type="submit" class="menu-item" style="width: 100%; border: none; background: none; cursor: pointer; text-align: left;">
                    <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
                </button>
            </form>
        </div>
    </div>
</div>

<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
