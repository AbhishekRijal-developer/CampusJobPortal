package com.campusjobportal.controller;

import com.campusjobportal.dao.UserDAO;
import com.campusjobportal.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String userType = request.getParameter("userType");
        String phoneNumber = request.getParameter("phoneNumber");
        String companyName = request.getParameter("companyName");
        
        // Validate input
        if (!isValidInput(firstName, lastName, email, password, confirmPassword, userType, phoneNumber)) {
            request.setAttribute("errorMessage", "All fields are required!");
            request.getRequestDispatcher("pages/register.jsp").forward(request, response);
            return;
        }
        
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match!");
            request.getRequestDispatcher("pages/register.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        if (userDAO.getUserByEmail(email) != null) {
            request.setAttribute("errorMessage", "Email already registered!");
            request.getRequestDispatcher("pages/register.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User newUser = new User(firstName, lastName, email, password, userType, phoneNumber);
        if ("RECRUITER".equals(userType) && companyName != null && !companyName.trim().isEmpty()) {
            newUser.setCompanyName(companyName);
        }
        
        // Register user
        if (userDAO.registerUser(newUser)) {
            request.setAttribute("successMessage", "Registration successful! Please login.");
            request.getRequestDispatcher("pages/login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Registration failed! Please try again.");
            request.getRequestDispatcher("pages/register.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("pages/register.jsp");
    }

    private boolean isValidInput(String... inputs) {
        for (String input : inputs) {
            if (input == null || input.trim().isEmpty()) {
                return false;
            }
        }
        return true;
    }
}
