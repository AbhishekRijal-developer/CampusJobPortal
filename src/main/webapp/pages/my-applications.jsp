<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.campusjobportal.model.Application" %>
<%
    String userType = (String) session.getAttribute("userType");
    String userName = (String) session.getAttribute("userName");
    
    if (userType == null || !userType.equals("STUDENT")) {
        response.sendRedirect("/CampusJobPortal/pages/login.jsp");
        return;
    }
    
    List<Application> applications = (List<Application>) request.getAttribute("applications");
    if (applications == null) applications = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Applications - Campus Job Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/CampusJobPortal/css/navbar.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #0f172a 0%, #1a2332 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #e2e8f0;
        }

        .applications-container {
            max-width: 1000px;
            margin: 80px auto 40px;
            padding: 30px 20px;
        }

        .page-header {
            margin-bottom: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            border-bottom: 2px solid rgba(212, 175, 55, 0.3);
        }

        .page-header h1 {
            font-size: 2rem;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .page-header h1 i {
            color: #d4af37;
            font-size: 2.2rem;
        }

        .filters {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 8px 16px;
            border: 2px solid rgba(212, 175, 55, 0.3);
            background: transparent;
            color: #e2e8f0;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: #d4af37;
            color: #0f172a;
            border-color: #d4af37;
        }

        .app-card {
            background: linear-gradient(135deg, #1e293b 0%, #2d3748 100%);
            border-radius: 12px;
            padding: 25px;
            margin: 15px 0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            border-left: 4px solid #d4af37;
            transition: all 0.3s ease;
        }

        .app-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(212, 175, 55, 0.2);
        }

        .app-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .app-header h3 {
            color: #d4af37;
            font-size: 1.3rem;
            flex: 1;
        }

        .app-status {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.9rem;
            text-transform: uppercase;
        }

        .status-PENDING {
            background: rgba(245, 158, 11, 0.2);
            color: #fbbf24;
            border: 1px solid #fbbf24;
        }

        .status-APPROVED {
            background: rgba(16, 185, 129, 0.2);
            color: #10b981;
            border: 1px solid #10b981;
        }

        .status-REJECTED {
            background: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            border: 1px solid #ef4444;
        }

        .app-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin: 15px 0;
            padding: 15px 0;
            border-top: 1px solid rgba(212, 175, 55, 0.1);
            border-bottom: 1px solid rgba(212, 175, 55, 0.1);
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .detail-item i {
            color: #d4af37;
            font-size: 1.1rem;
        }

        .detail-item .detail-text {
            display: flex;
            flex-direction: column;
        }

        .detail-label {
            color: #a1aac3;
            font-size: 0.8rem;
            text-transform: uppercase;
        }

        .detail-value {
            color: #e2e8f0;
            font-weight: 600;
        }

        .app-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .app-btn {
            padding: 10px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .app-btn-primary {
            background: linear-gradient(135deg, #d4af37, #e5c158);
            color: #0f172a;
        }

        .app-btn-primary:hover {
            background: linear-gradient(135deg, #e5c158, #f0d45c);
            transform: scale(1.05);
        }

        .app-btn-secondary {
            background: transparent;
            border: 2px solid #d4af37;
            color: #d4af37;
        }

        .app-btn-secondary:hover {
            background: #d4af37;
            color: #0f172a;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #a1aac3;
        }

        .empty-state i {
            font-size: 80px;
            color: rgba(212, 175, 55, 0.3);
            margin-bottom: 20px;
            display: block;
        }

        .empty-state p {
            font-size: 1.2rem;
            margin-bottom: 30px;
        }

        .empty-state .btn-primary {
            background: linear-gradient(135deg, #d4af37, #e5c158);
            color: #0f172a;
            padding: 12px 30px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .empty-state .btn-primary:hover {
            background: linear-gradient(135deg, #e5c158, #f0d45c);
            transform: scale(1.05);
        }

        .stats-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }

        .stat-box {
            background: linear-gradient(135deg, #1e293b 0%, #2d3748 100%);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid rgba(212, 175, 55, 0.2);
            text-align: center;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #d4af37;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #a1aac3;
            font-size: 0.9rem;
            text-transform: uppercase;
        }

        @media (max-width: 768px) {
            .applications-container {
                padding: 20px 15px;
                margin-top: 70px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .app-header {
                flex-direction: column;
            }

            .app-details {
                grid-template-columns: repeat(2, 1fr);
            }

            .app-actions {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
    <%@ include file="../includes/navbar.jsp" %>
    
    <div class="applications-container">
        <div class="page-header">
            <h1>
                <i class="fas fa-file-alt"></i> My Applications
            </h1>
            <a href="/CampusJobPortal/StudentDashboardServlet" style="color: #d4af37; text-decoration: none; font-weight: 600;">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <% if (!applications.isEmpty()) { %>
            <!-- Statistics Summary -->
            <div class="stats-summary">
                <div class="stat-box">
                    <div class="stat-number"><%= applications.size() %></div>
                    <div class="stat-label">Total Applications</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">
                        <%= applications.stream().filter(a -> "PENDING".equals(a.getStatus())).count() %>
                    </div>
                    <div class="stat-label">Pending</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">
                        <%= applications.stream().filter(a -> "APPROVED".equals(a.getStatus())).count() %>
                    </div>
                    <div class="stat-label">Approved</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">
                        <%= applications.stream().filter(a -> "REJECTED".equals(a.getStatus())).count() %>
                    </div>
                    <div class="stat-label">Rejected</div>
                </div>
            </div>

            <!-- Filter Buttons -->
            <div class="filters">
                <button class="filter-btn active" onclick="filterApplications('ALL')">All</button>
                <button class="filter-btn" onclick="filterApplications('PENDING')">Pending</button>
                <button class="filter-btn" onclick="filterApplications('APPROVED')">Approved</button>
                <button class="filter-btn" onclick="filterApplications('REJECTED')">Rejected</button>
            </div>

            <!-- Applications List -->
            <div id="applications-list">
                <% for (Application app : applications) { %>
                    <div class="app-card" data-status="<%= app.getStatus() %>">
                        <div class="app-header">
                            <h3><i class="fas fa-briefcase"></i> <%= app.getJobTitle() %></h3>
                            <span class="app-status status-<%= app.getStatus() %>"><%= app.getStatus() %></span>
                        </div>
                        
                        <div class="app-details">
                            <div class="detail-item">
                                <i class="fas fa-building"></i>
                                <div class="detail-text">
                                    <span class="detail-label">Company</span>
                                    <span class="detail-value"><%= app.getRecruiterName() %></span>
                                </div>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-calendar"></i>
                                <div class="detail-text">
                                    <span class="detail-label">Applied On</span>
                                    <span class="detail-value"><%= app.getApplicationDate() %></span>
                                </div>
                            </div>
                        </div>

                        <div class="app-actions">
                            <a href="/CampusJobPortal/pages/job-detail.jsp?id=<%= app.getJobId() %>" class="app-btn app-btn-primary">
                                <i class="fas fa-eye"></i> View Job Details
                            </a>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <!-- Empty State -->
            <div class="empty-state">
                <i class="fas fa-inbox"></i>
                <p>You haven't applied for any jobs yet.</p>
                <p style="color: #a1aac3; margin-bottom: 20px;">Start exploring opportunities and apply for positions that match your skills!</p>
                <a href="/CampusJobPortal/BrowseJobsServlet" class="btn-primary">
                    <i class="fas fa-search"></i> Browse Jobs
                </a>
            </div>
        <% } %>
    </div>

    <script>
        function filterApplications(status) {
            const cards = document.querySelectorAll('.app-card');
            const buttons = document.querySelectorAll('.filter-btn');
            
            // Update active button
            buttons.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            // Filter cards
            cards.forEach(card => {
                if (status === 'ALL' || card.dataset.status === status) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>
