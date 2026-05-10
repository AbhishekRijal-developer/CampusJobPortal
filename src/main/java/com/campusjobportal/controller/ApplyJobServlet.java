package com.campusjobportal.controller;

import com.campusjobportal.service.ApplicationService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/ApplyJobServlet")
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ApplicationService applicationService = new ApplicationService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");

        // Validate user is logged in and is a student
        if (userId == null || !userType.equals("STUDENT")) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Please log in as a student to apply\"}");
            return;
        }

        try {
            int jobId = Integer.parseInt(request.getParameter("jobId"));
            String coverNote = request.getParameter("coverNote") != null ? request.getParameter("coverNote") : "";

            // Apply for the job
            String errorMessage = applicationService.applyForJob(userId, jobId, coverNote);

            response.setContentType("application/json");
            if (errorMessage == null) {
                response.getWriter().write("{\"success\": true, \"message\": \"Application submitted successfully!\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"" + errorMessage + "\"}");
            }
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid job ID\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Error submitting application\"}");
        }
    }
}
