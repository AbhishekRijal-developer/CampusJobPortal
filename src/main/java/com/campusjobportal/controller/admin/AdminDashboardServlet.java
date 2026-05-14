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
import java.util.StringJoiner;

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
            // Basic dashboard stats (cards)
            Map<String, Integer> stats = adminDAO.getDashboardStats();
            request.setAttribute("stats", stats);

            // Monthly application data (bar chart)
            Map<Integer, Integer> monthlyApps = adminDAO.getMonthlyApplicationData();
            StringBuilder monthDataBuilder = new StringBuilder();
            for (int i = 1; i <= 12; i++) {
                if (i > 1) monthDataBuilder.append(", ");
                monthDataBuilder.append(monthlyApps.getOrDefault(i, 0));
            }
            request.setAttribute("monthData", monthDataBuilder.toString());

            // Monthly hired data (line chart - hired series)
            Map<Integer, Integer> monthlyHired = adminDAO.getMonthlyHiredData();
            StringBuilder hiredDataBuilder = new StringBuilder();
            for (int i = 1; i <= 12; i++) {
                if (i > 1) hiredDataBuilder.append(", ");
                hiredDataBuilder.append(monthlyHired.getOrDefault(i, 0));
            }
            request.setAttribute("trendHired", hiredDataBuilder.toString());
            // Applied series reuses monthly application data
            request.setAttribute("trendApplied", monthDataBuilder.toString());

            // Job category breakdown (pie/doughnut chart)
            Map<String, Integer> categories = adminDAO.getJobCategoryBreakdown();
            if (!categories.isEmpty()) {
                StringJoiner labelJoiner = new StringJoiner("', '", "'", "'");
                StringJoiner dataJoiner = new StringJoiner(", ");
                for (Map.Entry<String, Integer> entry : categories.entrySet()) {
                    labelJoiner.add(entry.getKey());
                    dataJoiner.add(String.valueOf(entry.getValue()));
                }
                request.setAttribute("categoryLabels", labelJoiner.toString());
                request.setAttribute("categoryData", dataJoiner.toString());
            }

            // Application status breakdown (doughnut chart)
            Map<String, Integer> statusBreakdown = adminDAO.getApplicationStatusBreakdown();
            if (!statusBreakdown.isEmpty()) {
                StringJoiner labelJoiner = new StringJoiner("', '", "'", "'");
                StringJoiner dataJoiner = new StringJoiner(", ");
                for (Map.Entry<String, Integer> entry : statusBreakdown.entrySet()) {
                    labelJoiner.add(entry.getKey());
                    dataJoiner.add(String.valueOf(entry.getValue()));
                }
                request.setAttribute("statusLabels", labelJoiner.toString());
                request.setAttribute("statusData", dataJoiner.toString());
            }

            request.setAttribute("currentPage", "dashboard");
            request.getRequestDispatcher("/pages/admin/admin-dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An internal error occurred while loading the dashboard.");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
}
