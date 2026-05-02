package com.campusjobportal.controller.admin;

import com.campusjobportal.dao.AdminDAO;
import com.campusjobportal.model.Job;
import com.campusjobportal.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/jobs")
public class AdminJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        try {
            List<Job> jobs = adminDAO.getAllJobs();
            request.setAttribute("jobs", jobs);
            request.setAttribute("currentPage", "jobs");
            request.getRequestDispatcher("/pages/admin/admin-approve-jobs.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving job list.");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            String action = request.getParameter("action");
            String jobIdStr = request.getParameter("jobId");
            User admin = (User) request.getSession().getAttribute("user");

            if (jobIdStr != null && action != null) {
                int jobId = Integer.parseInt(jobIdStr);
                boolean success = false;
                String logDetails = "";

                if ("approve".equals(action)) {
                    success = adminDAO.updateJobStatus(jobId, "APPROVED");
                    logDetails = "Approved job posting";
                } else if ("reject".equals(action)) {
                    success = adminDAO.updateJobStatus(jobId, "REJECTED");
                    logDetails = "Rejected job posting";
                }
                
                if (success) {
                    adminDAO.logAction(admin.getUserId(), action, "JOB", jobId, logDetails);
                    request.getSession().setAttribute("message", "Job status updated successfully.");
                } else {
                    request.getSession().setAttribute("error", "Failed to update job status.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error processing job action.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/jobs");
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            return "ADMIN".equalsIgnoreCase(user.getUserType());
        }
        return false;
    }
}
