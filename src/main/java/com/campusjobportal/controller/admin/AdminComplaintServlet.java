package com.campusjobportal.controller.admin;

import com.campusjobportal.dao.AdminDAO;
import com.campusjobportal.model.Complaint;
import com.campusjobportal.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/complaints")
public class AdminComplaintServlet extends HttpServlet {
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
            List<Complaint> complaints = adminDAO.getAllComplaints();
            request.setAttribute("complaints", complaints);
            request.setAttribute("currentPage", "complaints");
            request.getRequestDispatcher("/pages/admin/admin-complaints.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading complaints.");
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
            String complaintIdStr = request.getParameter("complaintId");
            String adminResponseText = request.getParameter("adminResponse");
            User admin = (User) request.getSession().getAttribute("user");

            if ("resolve".equals(action) && complaintIdStr != null && adminResponseText != null) {
                int complaintId = Integer.parseInt(complaintIdStr);
                boolean success = adminDAO.resolveComplaint(complaintId, adminResponseText);
                
                if (success) {
                    adminDAO.logAction(admin.getUserId(), "RESOLVE", "COMPLAINT", complaintId, "Resolved user complaint with response: " + adminResponseText);
                    request.getSession().setAttribute("message", "Complaint resolved successfully.");
                } else {
                    request.getSession().setAttribute("error", "Failed to resolve complaint.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error processing complaint resolution.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/complaints");
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
