<%@ page import="com.campusjobportal.model.Job" %>

<%
    Job job = (Job) request.getAttribute("job");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Job</title>

    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/edit-job.css">
</head>

<body>

<%@ include file="../includes/navbar.jsp" %>

<div class="container">
    <h2>Edit Job</h2>

    <form action="../EditJobServlet" method="post">

        <input type="hidden" name="id" value="<%= job.getId() %>">

        <input type="text" name="title" value="<%= job.getTitle() %>">

        <textarea name="description"><%= job.getDescription() %></textarea>

        <input type="text" name="location" value="<%= job.getLocation() %>">

        <input type="text" name="category" value="<%= job.getCategory() %>">

        <input type="date" name="deadline" value="<%= job.getDeadline() %>">

        <button type="submit">Update</button>

    </form>
</div>

</body>
</html>