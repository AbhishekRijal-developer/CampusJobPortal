<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recruiter Dashboard</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>

<%@ include file="../includes/navbar.jsp" %>

<!-- BACKGROUND -->
<div class="dashboard-bg">
    <div class="glow glow1"></div>
    <div class="glow glow2"></div>
</div>

<div class="dashboard-container">

    <h1><i class="fas fa-briefcase"></i> Recruiter Dashboard</h1>

    <div class="cards">

        <a href="../PostJobServlet" class="card">
            <i class="fas fa-plus-circle"></i>
            <h3>Post Job</h3>
            <p>Create new job listings</p>
        </a>

        <a href="../ManageJobServlet" class="card">
            <i class="fas fa-list"></i>
            <h3>Manage Jobs</h3>
            <p>Edit or delete jobs</p>
        </a>

        <a href="../ManageJobServlet" class="card">
            <i class="fas fa-users"></i>
            <h3>View Applicants</h3>
            <p>See who applied</p>
        </a>

        <a href="#" class="card">
            <i class="fas fa-chart-line"></i>
            <h3>Analytics</h3>
            <p>Track job performance</p>
        </a>

    </div>

</div>

</body>
</html>

