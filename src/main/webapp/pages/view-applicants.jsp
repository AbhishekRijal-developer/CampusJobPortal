<%@ page import="java.util.List" %>
<%@ page import="com.campusjobportal.model.Application" %>

<%
  List<Application> apps = (List<Application>) request.getAttribute("applicants");
%>

<!DOCTYPE html>
<html>
<head>
  <title>Applicants</title>

  <link rel="stylesheet" href="../css/navbar.css">
  <link rel="stylesheet" href="../css/applicants.css">
</head>

<body>

<%@ include file="../includes/navbar.jsp" %>

<div class="container">
  <h2>Applicants</h2>

  <table>
    <tr>
      <th>Student ID</th>
      <th>Status</th>
      <th>Action</th>
    </tr>

    <% for(Application a : apps) { %>
    <tr>
      <td><%= a.getStudentId() %></td>
      <td><%= a.getStatus() %></td>

      <td>
        <form action="../UpdateStatusServlet" method="post">
          <input type="hidden" name="applicationId" value="<%= a.getId() %>">
          <input type="hidden" name="jobId" value="<%= a.getJobId() %>">

          <select name="status">
            <option>Pending</option>
            <option>Shortlisted</option>
            <option>Rejected</option>
          </select>

          <button type="submit">Update</button>
        </form>
      </td>
    </tr>
    <% } %>

  </table>
</div>

</body>
</html>