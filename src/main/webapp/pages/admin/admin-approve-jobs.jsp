<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Approvals | Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../includes/admin-sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>Job Moderation</h1>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success"><i class="fas fa-check"></i> ${message}</div>
            <% session.removeAttribute("message"); %>
        </c:if>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Job Details</th>
                        <th>Recruiter</th>
                        <th>Type / Location</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="job" items="${jobs}">
                        <tr>
                            <td>
                                <div style="font-weight: 600;">${job.title}</div>
                                <div style="font-size: 0.8rem; color: var(--text-muted); max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${job.description}</div>
                            </td>
                            <td>${job.companyName}</td>
                            <td>
                                <div>${job.category}</div>
                                <div style="font-size: 0.8rem; color: var(--text-muted);">${job.location}</div>
                            </td>
                            <td>
                                <span class="badge ${job.approvalStatus == 'APPROVED' ? 'badge-approved' : (job.approvalStatus == 'PENDING' ? 'badge-pending' : 'badge-rejected')}">
                                    ${job.approvalStatus}
                                </span>
                            </td>
                            <td>
                                <div style="display: flex; gap: 0.5rem;">
                                    <c:if test="${job.approvalStatus == 'PENDING'}">
                                        <form action="${pageContext.request.contextPath}/admin/jobs" method="POST" style="display:inline;">
                                            <input type="hidden" name="jobId" value="${job.id}">
                                            <input type="hidden" name="action" value="approve">
                                            <button type="submit" class="btn btn-success" style="padding: 0.5rem 1rem;">Approve</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/jobs" method="POST" style="display:inline;">
                                            <input type="hidden" name="jobId" value="${job.id}">
                                            <input type="hidden" name="action" value="reject">
                                            <button type="submit" class="btn btn-danger" style="padding: 0.5rem 1rem;">Reject</button>
                                        </form>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
