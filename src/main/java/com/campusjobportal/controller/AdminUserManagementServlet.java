package com.campusjobportal.controller;

import com.campusjobportal.dao.UserDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AdminUserManagementServlet")
public class AdminUserManagementServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("userType");
        
        if (userType == null || !userType.equals("ADMIN")) {
            response.sendRedirect("/CampusJobPortal/pages/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if ("getAllUsers".equals(action)) {
            request.setAttribute("users", userDAO.getAllUsers());
            request.getRequestDispatcher("/pages/admin-users.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/pages/admin-dashboard.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("userType");
        
        if (userType == null || !userType.equals("ADMIN")) {
            response.sendRedirect("/CampusJobPortal/pages/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if ("approveUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.activateUser(userId);
        } else if ("deleteUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.deactivateUser(userId);
        }
        response.sendRedirect("/CampusJobPortal/AdminUserManagementServlet?action=getAllUsers");
    }
}
