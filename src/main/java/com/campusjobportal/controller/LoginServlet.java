package com.campusjobportal.controller;

import com.campusjobportal.dao.UserDAO;
import com.campusjobportal.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email and password are required!");
            request.getRequestDispatcher("pages/login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        User user = userDAO.authenticateUser(email, password);
        
        if (user != null) {
            // Create session and store user information
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userType", user.getUserType());
            session.setAttribute("userName", user.getFirstName() + " " + user.getLastName());
            
            // Redirect based on user type
            String userType = user.getUserType();
            if ("STUDENT".equals(userType)) {
                response.sendRedirect("/CampusJobPortal/StudentDashboardServlet");
            } else if ("RECRUITER".equals(userType)) {
                response.sendRedirect("/CampusJobPortal/pages/recruiter-dashboard.jsp");
            } else if ("ADMIN".equals(userType)) {
                response.sendRedirect("/CampusJobPortal/pages/admin/admin-dashboard.jsp");
            }
        } else {
            // Login failed
            request.setAttribute("errorMessage", "Invalid email or password!");
            request.getRequestDispatcher("pages/login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("pages/login.jsp");
    }
}
