package com.campusjobportal.controller;

import com.campusjobportal.dao.JobDAO;
import com.campusjobportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/ManageJobServlet")
public class ManageJobServlet extends HttpServlet {

    /**
     * Displays all jobs posted by the recruiter
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        JobDAO dao = new JobDAO();

        // Fetch jobs of logged-in recruiter
        request.setAttribute("jobList", dao.getJobsByRecruiter(user.getUserId()));

        request.getRequestDispatcher("pages/manage-jobs.jsp").forward(request, response);
    }
}