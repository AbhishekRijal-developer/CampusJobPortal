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

@WebServlet("/admin/reports")
public class AdminReportServlet extends HttpServlet {
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
            Map<String, Integer> stats = adminDAO.getDashboardStats();
            request.setAttribute("stats", stats);
            request.setAttribute("currentPage", "reports");
            request.getRequestDispatcher("/pages/admin/admin-reports.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error generating system reports.");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
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
