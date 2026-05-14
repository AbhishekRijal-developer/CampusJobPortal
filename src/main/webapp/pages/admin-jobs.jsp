<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.campusjobportal.model.Job" %>
<%
    String userType = (String) session.getAttribute("userType");
    if (userType == null || !userType.equals("ADMIN")) {
        response.sendRedirect("/CampusJobPortal/pages/login.jsp");
        return;
    }
    List<Job> jobs = (List<Job>) request.getAttribute("jobs");
    if (jobs == null) jobs = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Jobs - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">
    <style>
        .admin-container { max-width: 1200px; margin: 50px auto; padding: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #007bff; color: white; }
        tr:hover { background: #f5f5f5; }
        .btn { padding: 8px 12px; margin: 2px; border: none; border-radius: 4px; cursor: pointer; }
        .btn-delete { background: #dc3545; color: white; }
        .status-active { color: green; }
        .status-inactive { color: red; }
    </style>
</head>
<body>
    <%@ include file="../includes/navbar.jsp" %>
    <div class="admin-container">
        <h1><i class="fas fa-briefcase"></i> Job Management</h1>
        <table>
            <tr><th>ID</th><th>Title</th><th>Location</th><th>Applications</th><th>Status</th><th>Actions</th></tr>
            <% for (Job job : jobs) { %>
                <tr>
                    <td><%= job.getJobId() %></td>
                    <td><%= job.getJobTitle() %></td>
                    <td><%= job.getLocation() %></td>
                    <td><%= job.getApplicationsCount() %></td>
                    <td class="<%= job.isActive() ? "status-active" : "status-inactive" %>">
                        <%= job.isActive() ? "Active" : "Inactive" %>
                    </td>
                    <td>
                        <form method="POST" action="/CampusJobPortal/AdminJobManagementServlet" style="display:inline;">
                            <input type="hidden" name="jobId" value="<%= job.getJobId() %>">
                            <input type="hidden" name="action" value="deleteJob">
                            <button class="btn btn-delete">Delete</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
