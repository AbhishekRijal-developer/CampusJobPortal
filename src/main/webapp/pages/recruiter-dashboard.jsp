<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String userType = (String) session.getAttribute("userType");
    if (userType == null || !userType.equals("RECRUITER")) {
        response.sendRedirect("error.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Recruiter Dashboard</title>
    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/home.css">
</head>

<body>

<%@ include file="../includes/navbar.jsp" %>

<div class="container" style="padding: 30px;">

    <h1>Welcome Recruiter</h1>

    <!-- STATS -->
    <div style="display:flex; gap:20px; margin-top:20px;">
        <div class="card">
            <h3>Total Jobs</h3>
            <p>5</p>
        </div>

        <div class="card">
            <h3>Total Applications</h3>
            <p>100</p>
        </div>

        <div class="card">
            <h3>Active Jobs</h3>
            <p>3</p>
        </div>
    </div>

    <!-- ACTION BUTTONS -->
    <div style="margin-top:30px;">
        <a href="post-job.jsp" class="btn-apply"> Post New Job</a>
        <a href="manage-jobs.jsp" class="btn-bookmark"> Manage Jobs</a>
        <a href="analytics.jsp" class="btn-bookmark"> View Analytics</a>
    </div>

</div>

</body>
</html>