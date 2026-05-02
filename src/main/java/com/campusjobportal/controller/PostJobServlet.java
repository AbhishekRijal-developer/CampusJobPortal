package com.campusjobportal.controller;

import com.campusjobportal.dao.JobDAO;
import com.campusjobportal.model.Job;
import com.campusjobportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/PostJobServlet")
public class PostJobServlet extends HttpServlet {

    /**
     * Responsible to handle GET request
     * Redirects recruiter to job posting form
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("pages/post-job.jsp").forward(request, response);
    }

    /**
     * Handles POST request
     * Collects form data and inserts job into database
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get logged-in recruiter
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Collect form data
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String category = request.getParameter("category");
        String deadline = request.getParameter("deadline");

        // Create Job object
        Job job = new Job();
        job.setTitle(title);
        job.setDescription(description);
        job.setLocation(location);
        job.setCategory(category);
        job.setDeadline(deadline);
        job.setRecruiterId(user.getUserId());

        // Save to DB
        JobDAO dao = new JobDAO();
        boolean success = dao.insertJob(job);

        // Redirect based on result
        if (success) {
            response.sendRedirect("ManageJobServlet");
        } else {
            response.sendRedirect("pages/error.jsp");
        }
    }
}