package com.campusjobportal.controller.admin;

import com.campusjobportal.dao.AdminDAO;
import com.campusjobportal.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        try {
            List<User> users = adminDAO.getAllUsers();
            request.setAttribute("users", users);
            request.setAttribute("currentPage", "users");
            request.getRequestDispatcher("/pages/admin/admin-manage-users.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving user list.");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            String action = request.getParameter("action");
            String userIdStr = request.getParameter("userId");
            User admin = (User) request.getSession().getAttribute("user");
            
            if (userIdStr != null && action != null) {
                int userId = Integer.parseInt(userIdStr);
                boolean success = false;
                String logDetails = "";

                switch (action) {
                    case "approve":
                        success = adminDAO.updateUserStatus(userId, true, "APPROVED");
                        logDetails = "Approved recruiter account";
                        break;
                    case "reject":
                        success = adminDAO.updateUserStatus(userId, true, "REJECTED");
                        logDetails = "Rejected recruiter account";
                        break;
                    case "suspend":
                        success = adminDAO.updateUserStatus(userId, false, "APPROVED");
                        logDetails = "Suspended user account";
                        break;
                    case "activate":
                        success = adminDAO.updateUserStatus(userId, true, "APPROVED");
                        logDetails = "Activated user account";
                        break;
                    case "deletePermanent":
                        success = adminDAO.deleteUser(userId);
                        logDetails = "PERMANENTLY deleted user account";
                        break;
                }
                
                if (success) {
                    adminDAO.logAction(admin.getUserId(), action, "USER", userId, logDetails);
                    request.getSession().setAttribute("message", "User action completed successfully.");
                } else {
                    request.getSession().setAttribute("error", "Failed to update user status.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "An error occurred during user management.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            return "ADMIN".equalsIgnoreCase(user.getUserType());
        }
        return false;
    }
}
