<%@ page import="java.util.List" %>
<%@ page import="com.campusjobportal.model.Job" %>

<%
    List<Job> jobs = (List<Job>) request.getAttribute("jobList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Jobs</title>

    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/manage-jobs.css">
</head>

<body>

<%@ include file="../includes/navbar.jsp" %>

<div class="container">
    <h2>Your Jobs</h2>

    <table>
        <tr>
            <th>Title</th>
            <th>Location</th>
            <th>Category</th>
            <th>Actions</th>
        </tr>

        <% for(Job j : jobs) { %>
        <tr>
            <td><%= j.getTitle() %></td>
            <td><%= j.getLocation() %></td>
            <td><%= j.getCategory() %></td>

            <td>
                <a href="../EditJobServlet?id=<%= j.getId() %>">Edit</a>
                <a href="../DeleteJobServlet?id=<%= j.getId() %>">Delete</a>
                <a href="../ViewApplicantsServlet?jobId=<%= j.getId() %>">Applicants</a>
            </td>
        </tr>
        <% } %>

    </table>
</div>

</body>
</html>