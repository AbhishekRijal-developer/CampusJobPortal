package com.campusjobportal.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@WebServlet("/CVUploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class CVUploadServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");
        
        if (userId == null || !userType.equals("STUDENT")) {
            response.sendRedirect("/CampusJobPortal/pages/login.jsp");
            return;
        }
        
        try {
            Part filePart = request.getPart("cvFile");
            String fileName = "CV_" + userId + ".pdf";
            String uploadPath = getServletContext().getRealPath("/") + "uploads/cv/";
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            String filePath = uploadPath + fileName;
            filePart.write(filePath);
            
            request.setAttribute("successMessage", "CV uploaded successfully!");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error uploading CV: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/pages/student-cv-upload.jsp").forward(request, response);
    }
}
