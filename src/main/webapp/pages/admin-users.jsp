<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.campusjobportal.model.User" %>
<%
    String userType = (String) session.getAttribute("userType");
    if (userType == null || !userType.equals("ADMIN")) {
        response.sendRedirect("/CampusJobPortal/pages/login.jsp");
        return;
    }
    List<User> users = (List<User>) request.getAttribute("users");
    if (users == null) users = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">
    <style>
        .admin-container { max-width: 1200px; margin: 50px auto; padding: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #007bff; color: white; }
        tr:hover { background: #f5f5f5; }
        .btn { padding: 8px 12px; margin: 2px; border: none; border-radius: 4px; cursor: pointer; }
        .btn-approve { background: #28a745; color: white; }
        .btn-delete { background: #dc3545; color: white; }
        .status-active { color: green; }
        .status-inactive { color: red; }
    </style>
</head>
<body>
    <%@ include file="../includes/navbar.jsp" %>
    <div class="admin-container">
        <h1><i class="fas fa-users"></i> User Management</h1>
        <table>
            <tr><th>ID</th><th>Name</th><th>Email</th><th>Type</th><th>Status</th><th>Actions</th></tr>
            <% for (User user : users) { %>
                <tr>
                    <td><%= user.getUserId() %></td>
                    <td><%= user.getFirstName() + " " + user.getLastName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getUserType() %></td>
                    <td class="<%= user.isActive() ? "status-active" : "status-inactive" %>">
                        <%= user.isActive() ? "Active" : "Inactive" %>
                    </td>
                    <td>
                        <form method="POST" action="/CampusJobPortal/AdminUserManagementServlet" style="display:inline;">
                            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                            <input type="hidden" name="action" value="<%= user.isActive() ? "deleteUser" : "approveUser" %>">
                            <button class="btn <%= user.isActive() ? "btn-delete" : "btn-approve" %>">
                                <%= user.isActive() ? "Deactivate" : "Approve" %>
                            </button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
