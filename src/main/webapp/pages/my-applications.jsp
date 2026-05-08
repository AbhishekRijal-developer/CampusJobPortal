<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.campusjobportal.model.Application" %>
<%
    String userType = (String) session.getAttribute("userType");
    String userName = (String) session.getAttribute("userName");
    
    if (userType == null || !userType.equals("STUDENT")) {
        response.sendRedirect("/CampusJobPortal/pages/login.jsp");
        return;
    }
    
    List<Application> applications = (List<Application>) request.getAttribute("applications");
    if (applications == null) applications = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Applications - Campus Job Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/styles.css">
    <style>
        .applications-container { max-width: 1000px; margin: 50px auto; padding: 20px; }
        .app-card { background: white; border-radius: 8px; padding: 20px; margin: 15px 0; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border-left: 4px solid #007bff; }
        .app-header { display: flex; justify-content: space-between; align-items: center; }
        .app-status { padding: 5px 12px; border-radius: 20px; font-weight: bold; }
        .status-APPLIED { background: #e3f2fd; color: #1976d2; }
        .status-APPROVED { background: #e8f5e9; color: #388e3c; }
        .status-REJECTED { background: #ffebee; color: #c62828; }
        .empty-state { text-align: center; padding: 50px; color: #999; }
    </style>
</head>
<body>
    <%@ include file="../includes/navbar.jsp" %>
    
    <div class="applications-container">
        <h1><i class="fas fa-file-alt"></i> My Applications</h1>
        
        <% if (applications.isEmpty()) { %>
            <div class="empty-state">
                <i class="fas fa-inbox" style="font-size: 60px; color: #ddd;"></i>
                <p>You haven't applied for any jobs yet.</p>
            </div>
        <% } else { %>
            <% for (Application app : applications) { %>
                <div class="app-card">
                    <div class="app-header">
                        <div>
                            <h3><i class="fas fa-briefcase"></i> Job ID: <%= app.getJobId() %></h3>
                            <p style="color: #666;">Applied: <%= app.getAppliedDate() %></p>
                        </div>
                        <span class="app-status status-<%= app.getStatus() %>"><%= app.getStatus() %></span>
                    </div>
                </div>
            <% } %>
        <% } %>
    </div>
</body>
</html>
