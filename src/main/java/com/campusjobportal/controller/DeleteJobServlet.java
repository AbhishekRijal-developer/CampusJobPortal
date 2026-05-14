package com.campusjobportal.controller;

import com.campusjobportal.dao.JobDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteJobServlet")
public class DeleteJobServlet extends HttpServlet {

    /**
     * Deletes a job by ID
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int jobId = Integer.parseInt(request.getParameter("id"));

        JobDAO dao = new JobDAO();
        dao.deleteJob(jobId);

        response.sendRedirect("ManageJobServlet");
    }
}
