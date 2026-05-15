<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Applications Tracking | Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../includes/admin-sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>Global Applications Tracking</h1>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Application ID</th>
                        <th>Student Name</th>
                        <th>Job Title</th>
                        <th>Recruiter</th>
                        <th>Status</th>
                        <th>Applied Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty applications}">
                            <c:forEach var="app" items="${applications}">
                                <tr>
                                    <td>#${app.applicationId}</td>
                                    <td><div style="font-weight: 600;">${app.studentName}</div></td>
                                    <td>${app.jobTitle}</td>
                                    <td>${app.recruiterName}</td>
                                    <td>
                                        <span class="badge ${app.status == 'APPROVED' || app.status == 'SELECTED' ? 'badge-approved' : (app.status == 'PENDING' ? 'badge-pending' : 'badge-rejected')}">
                                            ${app.status}
                                        </span>
                                    </td>
                                    <td>${app.applicationDate}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" style="text-align: center; padding: 3rem; color: var(--text-muted);">
                                    <i class="fas fa-folder-open" style="font-size: 2rem; display: block; margin-bottom: 1rem;"></i>
                                    No applications found in the system.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
