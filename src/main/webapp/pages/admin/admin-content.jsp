<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Content CMS | Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../includes/admin-sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>Dynamic Content CMS</h1>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success"><i class="fas fa-check"></i> ${message}</div>
            <% session.removeAttribute("message"); %>
        </c:if>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
            <!-- About Page -->
            <div class="stat-card" style="height: fit-content;">
                <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-info-circle"></i> About Page Section</h3>
                <form action="${pageContext.request.contextPath}/admin/content" method="POST">
                    <input type="hidden" name="pageName" value="about">
                    <input type="hidden" name="key" value="main_content">
                    <label style="display: block; margin-bottom: 0.5rem; font-size: 0.85rem; color: var(--text-muted);">Main Content Description</label>
                    <textarea name="value" style="width: 100%; height: 250px; background: rgba(0,0,0,0.2); border: 1px solid var(--border-color); color: white; padding: 1rem; border-radius: 0.75rem; margin-bottom: 1.5rem;"><c:forEach var="item" items="${aboutContent}"><c:if test="${item.contentKey == 'main_content'}">${item.contentValue}</c:if></c:forEach></textarea>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Save Changes</button>
                </form>
            </div>

            <!-- Contact Info -->
            <div class="stat-card" style="height: fit-content;">
                <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-address-card"></i> Contact Information</h3>
                <form action="${pageContext.request.contextPath}/admin/content" method="POST" style="display: flex; flex-direction: column; gap: 1rem;">
                    <input type="hidden" name="pageName" value="contact">
                    
                    <div>
                        <label style="display: block; margin-bottom: 0.5rem; font-size: 0.85rem; color: var(--text-muted);">Office Address</label>
                        <input type="hidden" name="key" value="address">
                        <input type="text" name="value" value="<c:forEach var="item" items="${contactContent}"><c:if test="${item.contentKey == 'address'}">${item.contentValue}</c:if></c:forEach>" style="width: 100%; background: rgba(0,0,0,0.2); border: 1px solid var(--border-color); color: white; padding: 0.875rem; border-radius: 0.75rem;">
                    </div>
                    
                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Update Contact Info</button>
                </form>

                <div style="margin-top: 2.5rem; padding: 1.5rem; background: rgba(99, 102, 241, 0.05); border: 1px solid rgba(99, 102, 241, 0.2); border-radius: 1rem;">
                    <h4 style="font-size: 0.9rem; margin-bottom: 0.75rem;"><i class="fas fa-lightbulb"></i> CMS Tip</h4>
                    <p style="font-size: 0.8rem; color: var(--text-muted); line-height: 1.5;">
                        Changes made here are stored in the <code>site_content</code> table and will be updated instantly on all public-facing pages.
                    </p>
                </div>
            </div>
        </div>

        <!-- Announcements -->
        <div class="stat-card" style="margin-top: 2rem;">
            <h3 style="margin-bottom: 1.5rem;"><i class="fas fa-bullhorn"></i> System Announcement / Home Banner</h3>
            <form action="${pageContext.request.contextPath}/admin/content" method="POST">
                <input type="hidden" name="pageName" value="home">
                <input type="hidden" name="key" value="announcement">
                <textarea name="value" placeholder="Enter system-wide announcement..." style="width: 100%; height: 100px; background: rgba(0,0,0,0.2); border: 1px solid var(--border-color); color: white; padding: 1rem; border-radius: 0.75rem; margin-bottom: 1.5rem;"><c:forEach var="item" items="${homeContent}"><c:if test="${item.contentKey == 'announcement'}">${item.contentValue}</c:if></c:forEach></textarea>
                <button type="submit" class="btn btn-success">Update Announcement</button>
            </form>
        </div>
    </div>
</body>
</html>
