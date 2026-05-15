package com.campusjobportal.controller;

import com.campusjobportal.dao.JobDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AdminJobManagementServlet")
public class AdminJobManagementServlet extends HttpServlet {
    private JobDAO jobDAO = new JobDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("userType");
        
        if (userType == null || !userType.equals("ADMIN")) {
            response.sendRedirect("/CampusJobPortal/pages/login.jsp");
            return;
        }
        
        request.setAttribute("jobs", jobDAO.getAllJobsForAdmin());
        request.getRequestDispatcher("/pages/admin-jobs.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("userType");
        
        if (userType == null || !userType.equals("ADMIN")) {
            response.sendRedirect("/CampusJobPortal/pages/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if ("deleteJob".equals(action)) {
            int jobId = Integer.parseInt(request.getParameter("jobId"));
            jobDAO.deactivateJob(jobId);
        }
        response.sendRedirect("/CampusJobPortal/AdminJobManagementServlet");
    }
}
