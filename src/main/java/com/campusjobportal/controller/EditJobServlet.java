package com.campusjobportal.controller;

import com.campusjobportal.dao.JobDAO;
import com.campusjobportal.model.Job;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/EditJobServlet")
public class EditJobServlet extends HttpServlet {

    /**
     * Load job details and send to edit page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int jobId = Integer.parseInt(request.getParameter("id"));

            JobDAO dao = new JobDAO();
            Job job = dao.getJobById(jobId);

            if (job != null) {
                request.setAttribute("job", job);
                request.getRequestDispatcher("pages/edit-job.jsp").forward(request, response);
            } else {
                response.sendRedirect("pages/error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("pages/error.jsp");
        }
    }

    /**
     * Update job after form submission
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int jobId = Integer.parseInt(request.getParameter("id"));

            Job job = new Job();
            job.setId(jobId);
            job.setTitle(request.getParameter("title"));
            job.setDescription(request.getParameter("description"));
            job.setLocation(request.getParameter("location"));
            job.setCategory(request.getParameter("category"));
            job.setDeadline(request.getParameter("deadline"));

            JobDAO dao = new JobDAO();
            boolean success = dao.updateJob(job);

            if (success) {
                response.sendRedirect("ManageJobServlet");
            } else {
                response.sendRedirect("pages/error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("pages/error.jsp");
        }
    }
}