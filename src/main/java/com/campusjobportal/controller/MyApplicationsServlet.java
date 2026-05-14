package com.campusjobportal.controller;

import com.campusjobportal.dao.ApplicationDAO;
import com.campusjobportal.model.Application;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/MyApplicationsServlet")
public class MyApplicationsServlet extends HttpServlet {
    private ApplicationDAO applicationDAO = new ApplicationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");
        
        if (userId == null || !userType.equals("STUDENT")) {
            response.sendRedirect("/CampusJobPortal/pages/login.jsp");
            return;
        }
        
        List<Application> applications = applicationDAO.getApplicationsByStudentId(userId);
        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/pages/my-applications.jsp").forward(request, response);
    }
}
