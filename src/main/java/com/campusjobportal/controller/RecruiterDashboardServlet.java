package com.campusjobportal.controller;

import com.campusjobportal.dao.RecruiterDashboardDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/RecruiterDashboardServlet")
public class RecruiterDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RecruiterDashboardDAO dashboardDAO =
            new RecruiterDashboardDAO();

    /**
     * Load recruiter dashboard statistics
     */

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer recruiterId =
                (Integer) session.getAttribute("userId");

        String userType =
                (String) session.getAttribute("userType");

        /*
         * Check if user is recruiter
         */

        if (recruiterId == null ||
                !"RECRUITER".equals(userType)) {

            response.sendRedirect(
                    "/CampusJobPortal/pages/login.jsp"
            );

            return;
        }

        /*
         * Get dashboard statistics
         */

        int totalJobs =
                dashboardDAO.getTotalJobs(recruiterId);

        int totalApplicants =
                dashboardDAO.getTotalApplicants(recruiterId);

        int shortlisted =
                dashboardDAO.getShortlistedApplicants(recruiterId);

        int activeJobs =
                dashboardDAO.getActiveJobs(recruiterId);

        /*
         * Store data for JSP
         */

        request.setAttribute("totalJobs", totalJobs);

        request.setAttribute("totalApplicants",
                totalApplicants);

        request.setAttribute("shortlisted",
                shortlisted);

        request.setAttribute("activeJobs",
                activeJobs);

        /*
         * Forward to dashboard page
         */

        request.getRequestDispatcher(
                        "/pages/recruiter-dashboard.jsp")
                .forward(request, response);
    }
}