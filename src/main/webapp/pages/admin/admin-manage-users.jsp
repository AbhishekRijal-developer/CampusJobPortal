<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management | Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../includes/admin-sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>User Management</h1>
            <div style="display: flex; gap: 1rem;">
                <input type="text" id="userSearch" placeholder="Search users..." class="btn" style="background: var(--card-bg); border: 1px solid var(--border-color); color: white; width: 300px; text-align: left;">
            </div>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success"><i class="fas fa-check"></i> ${message}</div>
            <% session.removeAttribute("message"); %>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
            <% session.removeAttribute("error"); %>
        </c:if>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email / Phone</th>
                        <th>Type</th>
                        <th>Status</th>
                        <th>Verification</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="userTableBody">
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>
                                <div style="font-weight: 600;">${user.firstName} ${user.lastName}</div>
                                <div style="font-size: 0.8rem; color: var(--text-muted);">${user.companyName}</div>
                            </td>
                            <td>
                                <div>${user.email}</div>
                                <div style="font-size: 0.8rem; color: var(--text-muted);">${user.phoneNumber}</div>
                            </td>
                            <td><span style="font-size: 0.8rem; font-weight: 600;">${user.userType}</span></td>
                            <td>
                                <span class="badge ${user.active ? 'badge-approved' : 'badge-rejected'}">
                                    ${user.active ? 'Active' : 'Suspended'}
                                </span>
                            </td>
                            <td>
                                <span class="badge ${user.approvalStatus == 'APPROVED' ? 'badge-approved' : (user.approvalStatus == 'PENDING' ? 'badge-pending' : 'badge-rejected')}">
                                    ${user.approvalStatus}
                                </span>
                            </td>
                            <td>
                                <div style="display: flex; gap: 0.5rem;">
                                    <c:if test="${user.approvalStatus == 'PENDING'}">
                                        <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;">
                                            <input type="hidden" name="userId" value="${user.userId}">
                                            <input type="hidden" name="action" value="approve">
                                            <button type="submit" class="btn btn-icon btn-success" title="Approve Recruiter"><i class="fas fa-check"></i></button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;">
                                            <input type="hidden" name="userId" value="${user.userId}">
                                            <input type="hidden" name="action" value="reject">
                                            <button type="submit" class="btn btn-icon btn-danger" title="Reject Recruiter"><i class="fas fa-times"></i></button>
                                        </form>
                                    </c:if>
                                    
                                    <c:if test="${user.active}">
                                        <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;">
                                            <input type="hidden" name="userId" value="${user.userId}">
                                            <input type="hidden" name="action" value="suspend">
                                            <button type="submit" class="btn btn-icon btn-danger" title="Suspend User"><i class="fas fa-ban"></i></button>
                                        </form>
                                    </c:if>
                                    <c:if test="${not user.active}">
                                        <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;">
                                            <input type="hidden" name="userId" value="${user.userId}">
                                            <input type="hidden" name="action" value="activate">
                                            <button type="submit" class="btn btn-icon btn-success" title="Activate User"><i class="fas fa-play"></i></button>
                                        </form>
                                    </c:if>

                                    <form action="${pageContext.request.contextPath}/admin/users" method="POST" onsubmit="return confirm('PERMANENTLY delete user ${user.firstName}?');" style="display:inline;">
                                        <input type="hidden" name="userId" value="${user.userId}">
                                        <input type="hidden" name="action" value="deletePermanent">
                                        <button type="submit" class="btn btn-icon btn-danger" title="Delete Permanently"><i class="fas fa-trash"></i></button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        document.getElementById('userSearch').addEventListener('keyup', function() {
            let filter = this.value.toLowerCase();
            let rows = document.querySelectorAll('#userTableBody tr');
            rows.forEach(row => {
                let text = row.innerText.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });
    </script>
</body>
</html>
