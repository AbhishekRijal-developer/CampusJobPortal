package com.campusjobportal.controller;

import com.campusjobportal.dao.ApplicationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ViewApplicantsServlet")
public class ViewApplicantsServlet extends HttpServlet {

    /**
     * Shows all applicants for a specific job
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int jobId = Integer.parseInt(request.getParameter("jobId"));

        ApplicationDAO dao = new ApplicationDAO();

        request.setAttribute("applicants", dao.getApplicantsByJob(jobId));

        request.getRequestDispatcher("pages/view-applicants.jsp").forward(request, response);
    }
}