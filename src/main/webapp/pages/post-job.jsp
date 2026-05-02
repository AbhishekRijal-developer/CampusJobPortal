<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Post Job</title>

    <link rel="stylesheet" href="../css/navbar.css">
    <link rel="stylesheet" href="../css/job-form.css">
</head>

<body>

<%@ include file="../includes/navbar.jsp" %>

<div class="container">
    <h2>Post a New Job</h2>

    <form action="../PostJobServlet" method="post">

        <input type="text" name="title" placeholder="Job Title" required>

        <textarea name="description" placeholder="Job Description" required></textarea>

        <input type="text" name="location" placeholder="Location" required>

        <input type="text" name="category" placeholder="Category" required>

        <input type="date" name="deadline" required>

        <button type="submit">Post Job</button>

    </form>
</div>

</body>
</html>