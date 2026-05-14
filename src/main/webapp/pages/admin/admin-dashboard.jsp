<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>
    <jsp:include page="../../includes/admin-sidebar.jsp" />

    <div class="main-content">
        <!-- Header -->
        <div class="dashboard-header">
            <div class="header-left">
                <h1 class="header-title">Dashboard Overview</h1>
                <p class="header-subtitle">Welcome back, System Administrator</p>
            </div>
            <div class="header-right">
                <div class="header-date-card">
                    <i class="fas fa-calendar-alt"></i>
                    <span id="currentDate"></span>
                </div>
            </div>
        </div>

        <!-- Notification Alerts -->
        <c:if test="${not empty message}">
            <div class="alert alert-success animate-slide-in">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
            <% session.removeAttribute("message"); %>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error animate-slide-in">
                <i class="fas fa-exclamation-triangle"></i> ${error}
            </div>
        </c:if>

        <!-- Statistics Cards Grid -->
        <div class="stats-grid-enhanced">
            <!-- Card 1: Total Jobs Posted -->
            <div class="stat-card-enhanced card-jobs" id="card-jobs">
                <div class="card-glow"></div>
                <div class="card-content">
                    <div class="card-icon-wrapper icon-jobs">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <div class="card-info">
                        <span class="card-label">Total Jobs Posted</span>
                        <span class="card-value count-up" data-target="${stats.activeJobs != null ? stats.activeJobs : 0}">${stats.activeJobs != null ? stats.activeJobs : 0}</span>
                        <span class="card-trend trend-up">
                            <i class="fas fa-briefcase"></i> Live Opportunities
                        </span>
                    </div>
                </div>
                <div class="card-sparkline">
                    <svg viewBox="0 0 100 30" preserveAspectRatio="none">
                        <polyline points="0,25 15,20 30,22 45,15 60,18 75,10 90,12 100,5" fill="none" stroke="currentColor" stroke-width="2"/>
                    </svg>
                </div>
            </div>

            <!-- Card 2: Total Students Registered -->
            <div class="stat-card-enhanced card-students" id="card-students">
                <div class="card-glow"></div>
                <div class="card-content">
                    <div class="card-icon-wrapper icon-students">
                        <i class="fas fa-user-graduate"></i>
                    </div>
                    <div class="card-info">
                        <span class="card-label">Students Registered</span>
                        <span class="card-value count-up" data-target="${stats.totalStudents != null ? stats.totalStudents : 0}">${stats.totalStudents != null ? stats.totalStudents : 0}</span>
                        <span class="card-trend trend-up">
                            <i class="fas fa-graduation-cap"></i> Active Learners
                        </span>
                    </div>
                </div>
                <div class="card-sparkline">
                    <svg viewBox="0 0 100 30" preserveAspectRatio="none">
                        <polyline points="0,28 20,22 35,25 50,15 65,18 80,8 100,5" fill="none" stroke="currentColor" stroke-width="2"/>
                    </svg>
                </div>
            </div>

            <!-- Card 3: Applications Submitted -->
            <div class="stat-card-enhanced card-applications" id="card-applications">
                <div class="card-glow"></div>
                <div class="card-content">
                    <div class="card-icon-wrapper icon-applications">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <div class="card-info">
                        <span class="card-label">Applications Submitted</span>
                        <span class="card-value count-up" data-target="${stats.totalApplications != null ? stats.totalApplications : 0}">${stats.totalApplications != null ? stats.totalApplications : 0}</span>
                        <span class="card-trend trend-neutral">
                            <i class="fas fa-paper-plane"></i> Total Received
                        </span>
                    </div>
                </div>
                <div class="card-sparkline">
                    <svg viewBox="0 0 100 30" preserveAspectRatio="none">
                        <polyline points="0,20 15,25 30,18 50,22 65,12 80,15 100,8" fill="none" stroke="currentColor" stroke-width="2"/>
                    </svg>
                </div>
            </div>

            <!-- Card 4: Total Recruiters/Companies -->
            <div class="stat-card-enhanced card-recruiters" id="card-recruiters">
                <div class="card-glow"></div>
                <div class="card-content">
                    <div class="card-icon-wrapper icon-recruiters">
                        <i class="fas fa-building"></i>
                    </div>
                    <div class="card-info">
                        <span class="card-label">Total Recruiters</span>
                        <span class="card-value count-up" data-target="${stats.totalRecruiters != null ? stats.totalRecruiters : 0}">${stats.totalRecruiters != null ? stats.totalRecruiters : 0}</span>
                        <span class="card-trend trend-up">
                            <i class="fas fa-handshake"></i> Verified Partners
                        </span>
                    </div>
                </div>
                <div class="card-sparkline">
                    <svg viewBox="0 0 100 30" preserveAspectRatio="none">
                        <polyline points="0,22 20,20 40,25 55,15 70,18 85,10 100,8" fill="none" stroke="currentColor" stroke-width="2"/>
                    </svg>
                </div>
            </div>

            <!-- Card 5: Selected Candidates -->
            <div class="stat-card-enhanced card-selected" id="card-selected">
                <div class="card-glow"></div>
                <div class="card-content">
                    <div class="card-icon-wrapper icon-selected">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="card-info">
                        <span class="card-label">Selected Candidates</span>
                        <span class="card-value count-up" data-target="${stats.selectedCandidates != null ? stats.selectedCandidates : 0}">${stats.selectedCandidates != null ? stats.selectedCandidates : 0}</span>
                        <span class="card-trend trend-up">
                            <i class="fas fa-trophy"></i> Successfully Hired
                        </span>
                    </div>
                </div>
                <div class="card-sparkline">
                    <svg viewBox="0 0 100 30" preserveAspectRatio="none">
                        <polyline points="0,28 15,22 35,25 50,18 70,12 85,15 100,5" fill="none" stroke="currentColor" stroke-width="2"/>
                    </svg>
                </div>
            </div>

            <!-- Card 6: Pending Applications -->
            <div class="stat-card-enhanced card-pending" id="card-pending">
                <div class="card-glow"></div>
                <div class="card-content">
                    <div class="card-icon-wrapper icon-pending">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="card-info">
                        <span class="card-label">Pending Applications</span>
                        <span class="card-value count-up" data-target="${stats.pendingApplications != null ? stats.pendingApplications : 0}">${stats.pendingApplications != null ? stats.pendingApplications : 0}</span>
                        <span class="card-trend trend-warning">
                            <i class="fas fa-hourglass-half"></i> Awaiting Review
                        </span>
                    </div>
                </div>
                <div class="card-sparkline">
                    <svg viewBox="0 0 100 30" preserveAspectRatio="none">
                        <polyline points="0,15 20,20 35,12 50,25 65,18 80,22 100,15" fill="none" stroke="currentColor" stroke-width="2"/>
                    </svg>
                </div>
            </div>
        </div>

        <!-- Charts Section -->
        <div class="charts-section">
            <!-- Row 1: Pie Chart + Bar Chart -->
            <div class="charts-row">
                <!-- Pie Chart: Job Categories -->
                <div class="chart-card" id="chart-card-pie">
                    <div class="chart-header">
                        <div class="chart-title-group">
                            <h3 class="chart-title"><i class="fas fa-chart-pie"></i> Job Categories</h3>
                            <p class="chart-subtitle">Distribution by employment type</p>
                        </div>
                        <div class="chart-badge">
                            <i class="fas fa-circle" style="color: #6366f1; font-size: 0.5rem;"></i> Live
                        </div>
                    </div>
                    <div class="chart-body">
                        <canvas id="jobCategoriesChart"></canvas>
                    </div>
                </div>

                <!-- Bar Chart: Monthly Applications -->
                <div class="chart-card" id="chart-card-bar">
                    <div class="chart-header">
                        <div class="chart-title-group">
                            <h3 class="chart-title"><i class="fas fa-chart-bar"></i> Monthly Applications</h3>
                            <p class="chart-subtitle">Volume over current year</p>
                        </div>
                        <div class="chart-badge">
                            <i class="fas fa-circle" style="color: #10b981; font-size: 0.5rem;"></i> Updated
                        </div>
                    </div>
                    <div class="chart-body">
                        <canvas id="monthlyApplicationsChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Row 2: Line Chart + Doughnut Chart -->
            <div class="charts-row">
                <!-- Line Chart: Hiring Trends -->
                <div class="chart-card" id="chart-card-line">
                    <div class="chart-header">
                        <div class="chart-title-group">
                            <h3 class="chart-title"><i class="fas fa-chart-line"></i> Hiring Trends</h3>
                            <p class="chart-subtitle">Applied vs Hired trends</p>
                        </div>
                        <div class="chart-badge">
                            <i class="fas fa-circle" style="color: #f59e0b; font-size: 0.5rem;"></i> Trends
                        </div>
                    </div>
                    <div class="chart-body">
                        <canvas id="hiringTrendsChart"></canvas>
                    </div>
                </div>

                <!-- Doughnut Chart: Application Status -->
                <div class="chart-card" id="chart-card-status">
                    <div class="chart-header">
                        <div class="chart-title-group">
                            <h3 class="chart-title"><i class="fas fa-circle-notch"></i> Application Status</h3>
                            <p class="chart-subtitle">Overall status breakdown</p>
                        </div>
                        <div class="chart-badge">
                            <i class="fas fa-circle" style="color: #ef4444; font-size: 0.5rem;"></i> Live
                        </div>
                    </div>
                    <div class="chart-body">
                        <canvas id="applicationStatusChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pending Approvals Section -->
        <div class="approvals-section">
            <div class="approvals-grid">
                <!-- Critical Actions Table -->
                <div class="table-container-enhanced">
                    <div class="table-header-enhanced">
                        <h2><i class="fas fa-bell"></i> Pending Approvals</h2>
                        <span class="pulse-dot"></span>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>Category</th>
                                <th>Pending Count</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="category-cell">
                                        <i class="fas fa-user-tie" style="color: var(--accent-color);"></i>
                                        Recruiter Verifications
                                    </div>
                                </td>
                                <td><span class="badge badge-pending">${stats.pendingRecruiters != null ? stats.pendingRecruiters : 0}</span></td>
                                <td><a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary btn-sm">Review</a></td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="category-cell">
                                        <i class="fas fa-briefcase" style="color: var(--warning-color);"></i>
                                        Job Post Moderation
                                    </div>
                                </td>
                                <td><span class="badge badge-pending">${stats.pendingJobs != null ? stats.pendingJobs : 0}</span></td>
                                <td><a href="${pageContext.request.contextPath}/admin/jobs" class="btn btn-primary btn-sm">Review</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Quick Actions -->
                <div class="quick-actions-card">
                    <h3><i class="fas fa-bolt"></i> Quick Actions</h3>
                    <div class="actions-grid">
                        <a href="${pageContext.request.contextPath}/admin/reports" class="action-btn action-reports">
                            <i class="fas fa-file-export"></i>
                            <span>Export Report</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/content" class="action-btn action-settings">
                            <i class="fas fa-cog"></i>
                            <span>Site Settings</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/users" class="action-btn action-users">
                            <i class="fas fa-users"></i>
                            <span>Manage Users</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/complaints" class="action-btn action-complaints">
                            <i class="fas fa-headset"></i>
                            <span>Complaints</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // ========== DATE DISPLAY ==========
        document.getElementById('currentDate').innerText = new Date().toLocaleDateString('en-US', {
            weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
        });

        // ========== ANIMATED COUNT-UP ==========
        function animateCountUp() {
            document.querySelectorAll('.count-up').forEach(el => {
                const target = parseInt(el.getAttribute('data-target')) || 0;
                const duration = 2000;
                const increment = target / (duration / 16);
                let current = 0;

                const updateCount = () => {
                    current += increment;
                    if (current < target) {
                        el.textContent = Math.floor(current).toLocaleString();
                        requestAnimationFrame(updateCount);
                    } else {
                        el.textContent = target.toLocaleString();
                    }
                };
                updateCount();
            });
        }

        // ========== INTERSECTION OBSERVER FOR ANIMATIONS ==========
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-in');
                }
            });
        }, { threshold: 0.1 });

        document.querySelectorAll('.stat-card-enhanced, .chart-card').forEach(card => {
            observer.observe(card);
        });

        // Trigger count-up on page load
        window.addEventListener('load', () => {
            setTimeout(animateCountUp, 300);
        });

        // ========== CHART.JS CONFIGURATION ==========
        Chart.defaults.color = '#94a3b8';
        Chart.defaults.font.family = "'Outfit', 'Inter', sans-serif";
        Chart.defaults.font.weight = '500';

        // --- PIE CHART: Job Categories ---
        const jobCatCtx = document.getElementById('jobCategoriesChart').getContext('2d');
        
        const categoryLabels = [
            <c:choose>
                <c:when test="${not empty categoryLabels}">${categoryLabels}</c:when>
                <c:otherwise>'Full-Time', 'Part-Time', 'Internship', 'Contract', 'Remote'</c:otherwise>
            </c:choose>
        ];
        const categoryData = [
            <c:choose>
                <c:when test="${not empty categoryData}">${categoryData}</c:when>
                <c:otherwise>15, 10, 8, 5, 4</c:otherwise>
            </c:choose>
        ];

        new Chart(jobCatCtx, {
            type: 'pie',
            data: {
                labels: categoryLabels,
                datasets: [{
                    data: categoryData,
                    backgroundColor: [
                        'rgba(99, 102, 241, 0.85)',
                        'rgba(6, 182, 212, 0.85)',
                        'rgba(16, 185, 129, 0.85)',
                        'rgba(245, 158, 11, 0.85)',
                        'rgba(239, 68, 68, 0.85)'
                    ],
                    borderColor: 'rgba(255, 255, 255, 0.1)',
                    borderWidth: 2,
                    hoverOffset: 15
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { padding: 20, usePointStyle: true, font: { size: 12, weight: '600' } }
                    }
                },
                animation: { animateRotate: true, animateScale: true, duration: 1500, easing: 'easeOutQuart' }
            }
        });

        // --- DOUGHNUT CHART: Application Status ---
        const statusCtx = document.getElementById('applicationStatusChart').getContext('2d');
        
        const statusLabels = [
            <c:choose>
                <c:when test="${not empty statusLabels}">${statusLabels}</c:when>
                <c:otherwise>'PENDING', 'APPROVED', 'REJECTED', 'WITHDRAWN'</c:otherwise>
            </c:choose>
        ];
        const statusData = [
            <c:choose>
                <c:when test="${not empty statusData}">${statusData}</c:when>
                <c:otherwise>25, 15, 10, 5</c:otherwise>
            </c:choose>
        ];

        new Chart(statusCtx, {
            type: 'doughnut',
            data: {
                labels: statusLabels,
                datasets: [{
                    data: statusData,
                    backgroundColor: [
                        'rgba(245, 158, 11, 0.85)', // Pending
                        'rgba(16, 185, 129, 0.85)', // Approved
                        'rgba(239, 68, 68, 0.85)',  // Rejected
                        'rgba(100, 116, 139, 0.85)' // Withdrawn
                    ],
                    borderColor: 'rgba(255, 255, 255, 0.1)',
                    borderWidth: 2,
                    hoverOffset: 15,
                    spacing: 5,
                    borderRadius: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { padding: 20, usePointStyle: true, font: { size: 12, weight: '600' } }
                    }
                },
                animation: { animateRotate: true, animateScale: true, duration: 1500, easing: 'easeOutQuart' }
            }
        });

        // --- BAR CHART: Monthly Applications ---
        const monthlyCtx = document.getElementById('monthlyApplicationsChart').getContext('2d');

        const monthLabels = [
            <c:choose>
                <c:when test="${not empty monthLabels}">${monthLabels}</c:when>
                <c:otherwise>'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'</c:otherwise>
            </c:choose>
        ];
        const monthData = [
            <c:choose>
                <c:when test="${not empty monthData}">${monthData}</c:when>
                <c:otherwise>12, 19, 8, 15, 22, 30, 25, 18, 35, 28, 20, 14</c:otherwise>
            </c:choose>
        ];

        const barGradient = monthlyCtx.createLinearGradient(0, 0, 0, 300);
        barGradient.addColorStop(0, 'rgba(99, 102, 241, 0.9)');
        barGradient.addColorStop(1, 'rgba(6, 182, 212, 0.4)');

        new Chart(monthlyCtx, {
            type: 'bar',
            data: {
                labels: monthLabels,
                datasets: [{
                    label: 'Applications',
                    data: monthData,
                    backgroundColor: barGradient,
                    borderColor: 'rgba(99, 102, 241, 0.8)',
                    borderWidth: 1,
                    borderRadius: 8,
                    borderSkipped: false,
                    barPercentage: 0.6,
                    categoryPercentage: 0.7
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: 'rgba(15, 23, 42, 0.95)',
                        titleFont: { size: 14, weight: '700' },
                        bodyFont: { size: 13 },
                        padding: 14,
                        borderColor: 'rgba(99, 102, 241, 0.3)',
                        borderWidth: 1,
                        cornerRadius: 12,
                        callbacks: {
                            label: function(ctx) {
                                return ' Applications: ' + ctx.raw;
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { font: { size: 11, weight: '600' } }
                    },
                    y: {
                        grid: { color: 'rgba(255, 255, 255, 0.05)' },
                        ticks: { font: { size: 11 }, stepSize: 5 },
                        beginAtZero: true
                    }
                },
                animation: {
                    duration: 1800,
                    easing: 'easeOutQuart'
                }
            }
        });

        // --- LINE CHART: Hiring Trends ---
        const hiringCtx = document.getElementById('hiringTrendsChart').getContext('2d');

        const trendLabels = [
            <c:choose>
                <c:when test="${not empty trendLabels}">${trendLabels}</c:when>
                <c:otherwise>'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'</c:otherwise>
            </c:choose>
        ];
        const trendHired = [
            <c:choose>
                <c:when test="${not empty trendHired}">${trendHired}</c:when>
                <c:otherwise>3, 5, 4, 8, 6, 12, 9, 7, 14, 11, 8, 10</c:otherwise>
            </c:choose>
        ];
        const trendApplied = [
            <c:choose>
                <c:when test="${not empty trendApplied}">${trendApplied}</c:when>
                <c:otherwise>12, 19, 8, 15, 22, 30, 25, 18, 35, 28, 20, 14</c:otherwise>
            </c:choose>
        ];

        const hireGradient = hiringCtx.createLinearGradient(0, 0, 0, 250);
        hireGradient.addColorStop(0, 'rgba(16, 185, 129, 0.3)');
        hireGradient.addColorStop(1, 'rgba(16, 185, 129, 0.0)');

        const appGradient = hiringCtx.createLinearGradient(0, 0, 0, 250);
        appGradient.addColorStop(0, 'rgba(99, 102, 241, 0.2)');
        appGradient.addColorStop(1, 'rgba(99, 102, 241, 0.0)');

        new Chart(hiringCtx, {
            type: 'line',
            data: {
                labels: trendLabels,
                datasets: [
                    {
                        label: 'Hired',
                        data: trendHired,
                        borderColor: 'rgba(16, 185, 129, 1)',
                        backgroundColor: hireGradient,
                        fill: true,
                        tension: 0.4,
                        borderWidth: 3,
                        pointBackgroundColor: '#10b981',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5,
                        pointHoverRadius: 8
                    },
                    {
                        label: 'Applied',
                        data: trendApplied,
                        borderColor: 'rgba(99, 102, 241, 1)',
                        backgroundColor: appGradient,
                        fill: true,
                        tension: 0.4,
                        borderWidth: 3,
                        pointBackgroundColor: '#6366f1',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5,
                        pointHoverRadius: 8
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: {
                    mode: 'index',
                    intersect: false
                },
                plugins: {
                    legend: {
                        position: 'top',
                        align: 'end',
                        labels: {
                            padding: 20,
                            usePointStyle: true,
                            pointStyleWidth: 10,
                            font: { size: 12, weight: '600' }
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(15, 23, 42, 0.95)',
                        titleFont: { size: 14, weight: '700' },
                        bodyFont: { size: 13 },
                        padding: 14,
                        borderColor: 'rgba(99, 102, 241, 0.3)',
                        borderWidth: 1,
                        cornerRadius: 12
                    }
                },
                scales: {
                    x: {
                        grid: { color: 'rgba(255, 255, 255, 0.04)' },
                        ticks: { font: { size: 11, weight: '600' } }
                    },
                    y: {
                        grid: { color: 'rgba(255, 255, 255, 0.05)' },
                        ticks: { font: { size: 11 } },
                        beginAtZero: true
                    }
                },
                animation: {
                    duration: 2000,
                    easing: 'easeOutQuart'
                }
            }
        });
    </script>
</body>
</html>
