package com.campusjobportal.controller;

import com.campusjobportal.dao.ApplicationDAO;
import com.campusjobportal.dao.JobDAO;
import com.campusjobportal.dao.StudentProfileDAO;
import com.campusjobportal.dao.UserDAO;
import com.campusjobportal.model.Application;
import com.campusjobportal.model.Job;
import com.campusjobportal.model.StudentProfile;
import com.campusjobportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ApplicationDAO applicationDAO = new ApplicationDAO();
    private JobDAO jobDAO = new JobDAO();
    private StudentProfileDAO profileDAO = new StudentProfileDAO();
    private UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Validate session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/CampusJobPortal/pages/login.jsp");
            return;
        }
        
        // Validate user type
        String userType = (String) session.getAttribute("userType");
        if (userType == null || !userType.equals("STUDENT")) {
            response.sendRedirect("/CampusJobPortal/pages/error.jsp");
            return;
        }
        
        // Get student ID and details
        int studentId = (Integer) session.getAttribute("userId");
        
        try {
            // Fetch user details
            User user = userDAO.getUserById(studentId);
            if (user == null) {
                response.sendRedirect("/CampusJobPortal/pages/error.jsp");
                return;
            }
            
            // Fetch student profile
            StudentProfile profile = profileDAO.getProfileByUserId(studentId);
            
            // Fetch applications
            List<Application> applications = applicationDAO.getApplicationsByStudentId(studentId);
            
            // Fetch recent jobs
            List<Job> recentJobs = jobDAO.getAllJobsForAdmin();
            if (recentJobs.size() > 5) {
                recentJobs = recentJobs.subList(0, 5);
            }
            
            // Calculate statistics
            int totalApplications = applications.size();
            int pendingApplications = (int) applications.stream()
                    .filter(app -> "PENDING".equals(app.getStatus())).count();
            int approvedApplications = (int) applications.stream()
                    .filter(app -> "APPROVED".equals(app.getStatus())).count();
            int rejectedApplications = (int) applications.stream()
                    .filter(app -> "REJECTED".equals(app.getStatus())).count();
            
            // Set attributes
            request.setAttribute("user", user);
            request.setAttribute("profile", profile);
            request.setAttribute("applications", applications);
            request.setAttribute("recentJobs", recentJobs);
            request.setAttribute("totalApplications", totalApplications);
            request.setAttribute("pendingApplications", pendingApplications);
            request.setAttribute("approvedApplications", approvedApplications);
            request.setAttribute("rejectedApplications", rejectedApplications);
            
            // Forward to dashboard
            request.getRequestDispatcher("pages/student-dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("pages/error.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
