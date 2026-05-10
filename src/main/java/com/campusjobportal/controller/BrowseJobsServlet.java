package com.campusjobportal.controller;

import com.campusjobportal.dao.JobDAO;
import com.campusjobportal.model.Job;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/BrowseJobsServlet")
public class BrowseJobsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get all active/approved jobs for students to browse
            List<Job> allJobs = jobDAO.getAllJobsForAdmin();
            
            // Filter only active jobs
            List<Job> activeJobs = allJobs.stream()
                    .filter(job -> "ACTIVE".equals(job.getApprovalStatus()))
                    .collect(Collectors.toList());

            // Get search keyword if present
            String keyword = request.getParameter("keyword");
            if (keyword != null && !keyword.isEmpty()) {
                activeJobs = activeJobs.stream()
                        .filter(job -> job.getTitle().toLowerCase().contains(keyword.toLowerCase())
                                || job.getDescription().toLowerCase().contains(keyword.toLowerCase())
                                || job.getCategory().toLowerCase().contains(keyword.toLowerCase()))
                        .collect(Collectors.toList());
            }

            request.setAttribute("jobs", activeJobs);
            request.setAttribute("keyword", keyword != null ? keyword : "");
            request.getRequestDispatcher("/pages/browse-jobs.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/CampusJobPortal/pages/error.jsp");
        }
    }
}
