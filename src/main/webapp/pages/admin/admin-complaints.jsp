<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaints & Resolution | Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../includes/admin-sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>Complaints & Resolution</h1>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success"><i class="fas fa-check"></i> ${message}</div>
            <% session.removeAttribute("message"); %>
        </c:if>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>User</th>
                        <th>Subject</th>
                        <th>Description / Resolution</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Resolution Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="complaint" items="${complaints}">
                        <tr>
                            <td><div style="font-weight: 600;">${complaint.userName}</div></td>
                            <td><strong>${complaint.subject}</strong></td>
                            <td style="max-width: 400px;">
                                <div style="margin-bottom: 0.75rem;">${complaint.description}</div>
                                <c:if test="${not empty complaint.adminResponse}">
                                    <div style="font-size: 0.85rem; color: var(--success-color); background: rgba(16, 185, 129, 0.05); padding: 1rem; border-radius: 0.75rem; border: 1px solid rgba(16, 185, 129, 0.2);">
                                        <i class="fas fa-reply"></i> <strong>Official Admin Response:</strong><br>
                                        ${complaint.adminResponse}
                                    </div>
                                </c:if>
                            </td>
                            <td><span style="font-size: 0.8rem; color: var(--text-muted);">${complaint.createdDate}</span></td>
                            <td>
                                <span class="badge ${complaint.status == 'OPEN' ? 'badge-pending' : 'badge-approved'}">
                                    ${complaint.status}
                                </span>
                            </td>
                            <td>
                                <c:if test="${complaint.status == 'OPEN'}">
                                    <form action="${pageContext.request.contextPath}/admin/complaints" method="POST" style="display: flex; flex-direction: column; gap: 0.75rem;">
                                        <input type="hidden" name="complaintId" value="${complaint.complaintId}">
                                        <input type="hidden" name="action" value="resolve">
                                        <textarea name="adminResponse" placeholder="Type resolution message..." required style="width: 100%; min-height: 80px; background: rgba(0,0,0,0.2); border: 1px solid var(--border-color); color: white; padding: 0.75rem; border-radius: 0.5rem; font-size: 0.85rem;"></textarea>
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-paper-plane"></i> Send & Resolve
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${complaint.status == 'RESOLVED'}">
                                    <span style="color: var(--text-muted); font-size: 0.85rem;"><i class="fas fa-check-circle"></i> Resolved</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
