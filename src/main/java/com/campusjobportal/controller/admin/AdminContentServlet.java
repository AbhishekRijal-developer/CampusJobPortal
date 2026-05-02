package com.campusjobportal.controller.admin;

import com.campusjobportal.dao.ContentDAO;
import com.campusjobportal.model.SiteContent;
import com.campusjobportal.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/content")
public class AdminContentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ContentDAO contentDAO;

    @Override
    public void init() throws ServletException {
        contentDAO = new ContentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        try {
            List<SiteContent> aboutContent = contentDAO.getPageContent("about");
            List<SiteContent> contactContent = contentDAO.getPageContent("contact");
            List<SiteContent> homeContent = contentDAO.getPageContent("home");
            
            request.setAttribute("aboutContent", aboutContent);
            request.setAttribute("contactContent", contactContent);
            request.setAttribute("homeContent", homeContent);
            request.setAttribute("currentPage", "content");
            request.getRequestDispatcher("/pages/admin/admin-content.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading site content.");
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
            String pageName = request.getParameter("pageName");
            String key = request.getParameter("key");
            String value = request.getParameter("value");

            if (pageName != null && key != null && value != null) {
                boolean success = contentDAO.updateContent(pageName, key, value);
                if (success) {
                    request.getSession().setAttribute("message", "Content updated successfully.");
                } else {
                    request.getSession().setAttribute("error", "Failed to update content.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error processing content update.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/content");
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
