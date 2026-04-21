<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Campus Job Portal</title>
    <link rel="icon" href="../images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="container">
            <div class="logo">
                <h1>CampusJobPortal</h1>
            </div>
        </div>
    </nav>

    <!-- Error Content -->
    <div class="container">
        <div style="text-align: center; padding: 50px;">
            <h2>Oops! Something went wrong</h2>
            <p>Error Code: <%= response.getStatus() %></p>
            <p>We're sorry, but the page you requested could not be found or an error occurred.</p>
            <a href="index.jsp" class="btn btn-primary">Go to Home</a>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 Campus Job Portal. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
