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
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equalsIgnoreCase(user.getUserType())) {
            request.setAttribute("error", "Unauthorized access. Admin privileges required.");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return;
        }

        try {
            Map<String, Integer> stats = adminDAO.getDashboardStats();
            request.setAttribute("stats", stats);
            request.setAttribute("currentPage", "dashboard");
            request.getRequestDispatcher("/pages/admin/admin-dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An internal error occurred while loading the dashboard.");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
}
