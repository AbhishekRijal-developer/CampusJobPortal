<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.campusjobportal.model.Job" %>
<%
    List<Job> jobs = (List<Job>) request.getAttribute("jobs");
    if (jobs == null) jobs = new ArrayList<>();
    String keyword = (String) request.getAttribute("keyword");
    if (keyword == null) keyword = "";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Browse Jobs - Campus Job Portal</title>
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

        .browse-container {
            max-width: 1200px;
            margin: 80px auto 40px;
            padding: 30px 20px;
        }

        .page-header {
            margin-bottom: 40px;
            text-align: center;
            padding-bottom: 20px;
            border-bottom: 2px solid rgba(212, 175, 55, 0.3);
        }

        .page-header h1 {
            font-size: 2.5rem;
            color: #fff;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #a1aac3;
            font-size: 1.1rem;
        }

        .search-section {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            display: flex;
            background: rgba(30, 41, 59, 0.8);
            border: 2px solid rgba(212, 175, 55, 0.3);
            border-radius: 8px;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }

        .search-box:focus-within {
            border-color: #d4af37;
            background: rgba(30, 41, 59, 1);
        }

        .search-box input {
            flex: 1;
            background: transparent;
            border: none;
            color: #e2e8f0;
            font-size: 1rem;
            outline: none;
        }

        .search-box input::placeholder {
            color: #64748b;
        }

        .search-btn {
            background: linear-gradient(135deg, #d4af37, #e5c158);
            color: #0f172a;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            background: linear-gradient(135deg, #e5c158, #f0d45c);
            transform: scale(1.05);
        }

        .jobs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .job-card {
            background: linear-gradient(135deg, #1e293b 0%, #2d3748 100%);
            border-radius: 12px;
            padding: 25px;
            border: 2px solid rgba(212, 175, 55, 0.2);
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
        }

        .job-card:hover {
            transform: translateY(-10px);
            border-color: #d4af37;
            box-shadow: 0 15px 40px rgba(212, 175, 55, 0.2);
        }

        .job-header {
            margin-bottom: 15px;
        }

        .job-title {
            font-size: 1.4rem;
            color: #d4af37;
            margin-bottom: 8px;
            font-weight: bold;
        }

        .company-name {
            color: #a1aac3;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .company-name i {
            color: #d4af37;
        }

        .job-meta {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin: 15px 0;
            padding: 15px 0;
            border-top: 1px solid rgba(212, 175, 55, 0.1);
            border-bottom: 1px solid rgba(212, 175, 55, 0.1);
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            color: #cbd5e1;
        }

        .meta-item i {
            color: #d4af37;
            font-size: 1rem;
        }

        .job-description {
            color: #cbd5e1;
            line-height: 1.6;
            margin-bottom: 15px;
            flex-grow: 1;
            font-size: 0.95rem;
        }

        .job-footer {
            display: flex;
            gap: 10px;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            padding-top: 15px;
            border-top: 1px solid rgba(212, 175, 55, 0.1);
        }

        .job-category {
            display: inline-block;
            background: rgba(212, 175, 55, 0.15);
            color: #d4af37;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .apply-btn {
            background: linear-gradient(135deg, #d4af37, #e5c158);
            color: #0f172a;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }

        .apply-btn:hover {
            background: linear-gradient(135deg, #e5c158, #f0d45c);
            transform: scale(1.05);
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

        .results-info {
            text-align: center;
            color: #a1aac3;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }

        .results-info strong {
            color: #d4af37;
        }

        @media (max-width: 768px) {
            .browse-container {
                padding: 20px 15px;
                margin-top: 70px;
            }

            .page-header h1 {
                font-size: 1.8rem;
            }

            .jobs-grid {
                grid-template-columns: 1fr;
            }

            .search-section {
                flex-direction: column;
            }

            .search-box {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="../includes/navbar.jsp" %>
    
    <div class="browse-container">
        <div class="page-header">
            <h1><i class="fas fa-briefcase"></i> Browse Jobs</h1>
            <p>Find your next opportunity</p>
        </div>

        <!-- Search Section -->
        <form method="GET" action="/CampusJobPortal/BrowseJobsServlet" class="search-section">
            <div class="search-box">
                <input type="text" name="keyword" placeholder="Search jobs by title, skills, or category..." value="<%= keyword %>">
                <i class="fas fa-search" style="color: #d4af37; margin-left: 10px;"></i>
            </div>
            <button type="submit" class="search-btn">
                <i class="fas fa-search"></i> Search
            </button>
        </form>

        <!-- Results Info -->
        <% if (!jobs.isEmpty()) { %>
            <div class="results-info">
                Found <strong><%= jobs.size() %></strong> job<%= jobs.size() != 1 ? "s" : "" %> <%= keyword.isEmpty() ? "" : "matching '" + keyword + "'" %>
            </div>
        <% } %>

        <!-- Jobs Grid -->
        <% if (!jobs.isEmpty()) { %>
            <div class="jobs-grid">
                <% for (Job job : jobs) { %>
                    <div class="job-card" onclick="window.location.href='/CampusJobPortal/pages/job-detail.jsp?id=<%= job.getId() %>'">
                        <div class="job-header">
                            <div class="job-title"><%= job.getTitle() %></div>
                            <div class="company-name">
                                <i class="fas fa-building"></i>
                                Category: <%= job.getCategory() %>
                            </div>
                        </div>

                        <div class="job-meta">
                            <div class="meta-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span><%= job.getLocation() != null && !job.getLocation().isEmpty() ? job.getLocation() : "Remote" %></span>
                            </div>
                            <div class="meta-item">
                                <i class="fas fa-calendar"></i>
                                <span>Deadline: <%= job.getDeadline() %></span>
                            </div>
                            <% if (job.getSalaryMin() > 0 || job.getSalaryMax() > 0) { %>
                            <div class="meta-item">
                                <i class="fas fa-money-bill"></i>
                                <span>₨ <%= String.format("%,.0f", job.getSalaryMin()) %> - <%= String.format("%,.0f", job.getSalaryMax()) %></span>
                            </div>
                            <% } %>

                        <div class="job-description">
                            <%= job.getDescription().length() > 100 ? job.getDescription().substring(0, 100) + "..." : job.getDescription() %>
                        </div>

                        <div class="job-footer">
                            <span class="job-category"><%= job.getCategory() %></span>
                            <button class="apply-btn" onclick="event.stopPropagation(); window.location.href='/CampusJobPortal/pages/job-detail.jsp?id=<%= job.getId() %>'">
                                <i class="fas fa-arrow-right"></i> View Details
                            </button>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="empty-state">
                <i class="fas fa-search"></i>
                <p><%= keyword.isEmpty() ? "No jobs available at the moment." : "No jobs found matching '" + keyword + "'." %></p>
                <% if (!keyword.isEmpty()) { %>
                    <p style="color: #64748b; margin-bottom: 20px;">Try searching with different keywords</p>
                    <a href="/CampusJobPortal/BrowseJobsServlet" style="color: #d4af37; text-decoration: none; font-weight: 600;">
                        View All Jobs <i class="fas fa-arrow-right"></i>
                    </a>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>
