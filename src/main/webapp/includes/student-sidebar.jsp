<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar student-sidebar">
    <div class="sidebar-header">
        <h2><i class="fas fa-graduation-cap"></i> <span>Dashboard</span></h2>
    </div>
    <div class="sidebar-menu">
        <a href="/CampusJobPortal/StudentDashboardServlet" class="menu-item" title="Dashboard">
            <i class="fas fa-th-large"></i>
            <span>Dashboard</span>
        </a>
        <a href="/CampusJobPortal/BrowseJobsServlet" class="menu-item" title="Browse Jobs">
            <i class="fas fa-search"></i>
            <span>Browse Jobs</span>
        </a>
        <a href="/CampusJobPortal/MyApplicationsServlet" class="menu-item" title="My Applications">
            <i class="fas fa-file-alt"></i>
            <span>My Applications</span>
        </a>
        <a href="/CampusJobPortal/StudentProfileServlet" class="menu-item" title="Edit Profile">
            <i class="fas fa-user-edit"></i>
            <span>Edit Profile</span>
        </a>
        <a href="/CampusJobPortal/StudentProfileServlet?view=true" class="menu-item" title="View Profile">
            <i class="fas fa-id-card"></i>
            <span>View Profile</span>
        </a>

        <div class="sidebar-divider"></div>

        <a href="/CampusJobPortal/pages/about.jsp" class="menu-item" title="About">
            <i class="fas fa-info-circle"></i>
            <span>About</span>
        </a>
        <a href="/CampusJobPortal/pages/contact.jsp" class="menu-item" title="Contact">
            <i class="fas fa-envelope"></i>
            <span>Contact</span>
        </a>

        <div style="margin-top: auto; padding-top: 1rem; border-top: 1px solid rgba(212, 175, 55, 0.2);">
            <a href="/CampusJobPortal/" class="menu-item" title="Home">
                <i class="fas fa-external-link-alt"></i>
                <span>Home</span>
            </a>
            <form action="/CampusJobPortal/LogoutServlet" method="POST" style="margin: 0;">
                <button type="submit" class="menu-item logout-btn" title="Logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </button>
            </form>
        </div>
    </div>
</div>

<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
