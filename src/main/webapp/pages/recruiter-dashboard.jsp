<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

    <title>Recruiter Dashboard</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet"
          href="/CampusJobPortal/css/navbar.css">

    <link rel="stylesheet"
          href="/CampusJobPortal/css/recruiter-dashboard.css">


    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>

<!--  For NAVBAR -->
<%@ include file="../includes/navbar.jsp" %>

<!-- For BACKGROUND -->

<div class="dashboard-bg">

    <div class="glow glow1"></div>

    <div class="glow glow2"></div>

</div>

<!-- MAIN CONTAINER -->

<div class="dashboard-container">

    <!-- HEADER -->

    <div class="dashboard-header">

        <h1>

            <i class="fas fa-briefcase"></i>

            Recruiter Dashboard

        </h1>

        <p>
            Manage jobs, applicants and hiring activities.
        </p>

    </div>

    <!-- STATISTICS -->

    <div class="stats-container">

        <!-- TOTAL JOBS -->

        <div class="stat-card">

            <i class="fas fa-briefcase"></i>

            <h2>

                <%= request.getAttribute("totalJobs") %>

            </h2>

            <p>Total Jobs</p>

        </div>

        <!-- TOTAL APPLICANTS -->

        <div class="stat-card">

            <i class="fas fa-users"></i>

            <h2>

                <%= request.getAttribute("totalApplicants") %>

            </h2>

            <p>Total Applicants</p>

        </div>

        <!-- SHORTLISTED -->

        <div class="stat-card">

            <i class="fas fa-user-check"></i>

            <h2>

                <%= request.getAttribute("shortlisted") %>

            </h2>

            <p>Shortlisted</p>

        </div>

        <!-- ACTIVE JOBS -->

        <div class="stat-card">

            <i class="fas fa-check-circle"></i>

            <h2>

                <%= request.getAttribute("activeJobs") %>

            </h2>

            <p>Active Jobs</p>

        </div>

    </div>

    <!-- QUICK ACTIONS -->

    <div class="cards">

        <!-- POST JOB -->

        <a href="../PostJobServlet"
           class="card">

            <i class="fas fa-plus-circle"></i>

            <h3>Post Job</h3>

            <p>Create new job listings</p>

        </a>

        <!-- MANAGE JOBS -->

        <a href="../ManageJobServlet"
           class="card">

            <i class="fas fa-list"></i>

            <h3>Manage Jobs</h3>

            <p>Edit or delete jobs</p>

        </a>

        <!-- VIEW APPLICANTS -->

        <a href="../ViewApplicantsServlet"
           class="card">

            <i class="fas fa-users"></i>

            <h3>View Applicants</h3>

            <p>See who applied</p>

        </a>

        <!-- COMPANY PROFILE -->

        <a href="../CompanyProfileServlet"
           class="card">

            <i class="fas fa-building"></i>

            <h3>Company Profile</h3>

            <p>Manage company details</p>

        </a>

    </div>

    <!-- ANALYTICS SECTION -->

    <div class="analytics-section">

        <div class="analytics-card">

            <h2>

                <i class="fas fa-chart-bar"></i>

                Job Application Analytics

            </h2>

            <canvas id="applicationChart"></canvas>

        </div>

    </div>

</div>

<!-- CHART SCRIPT -->

<script>

    const ctx =
        document.getElementById('applicationChart');

    new Chart(ctx, {

        type: 'bar',

        data: {

            labels: [

                'Java Developer',
                'UI/UX Designer',
                'Backend Developer',
                'Marketing'

            ],

            datasets: [{

                label: 'Applicants',

                data: [12, 19, 8, 15]

            }]
        }
    });

</script>

</body>
</html>