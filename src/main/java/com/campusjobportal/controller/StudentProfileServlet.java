package com.campusjobportal.controller;

import com.campusjobportal.dao.StudentProfileDAO;
import com.campusjobportal.model.StudentProfile;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/StudentProfileServlet")
public class StudentProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentProfileDAO profileDAO = new StudentProfileDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");

        // Check if user is logged in and is a STUDENT
        if (userId == null || !"STUDENT".equals(userType)) {
            response.sendRedirect("/CampusJobPortal/pages/login.jsp");
            return;
        }

        // Get student profile
        StudentProfile profile = profileDAO.getProfileByUserId(userId);

        if (profile == null) {
            profile = new StudentProfile(userId);
        }

        // Store profile in request for JSP
        request.setAttribute("profile", profile);
        request.getRequestDispatcher("/pages/student-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userType = (String) session.getAttribute("userType");

        // Check if user is logged in and is a STUDENT
        if (userId == null || !"STUDENT".equals(userType)) {
            response.sendRedirect("/CampusJobPortal/pages/login.jsp");
            return;
        }

        StudentProfile profile = new StudentProfile(userId);

        // Set profile fields from request parameters
        profile.setLocation(request.getParameter("location"));
        profile.setInstitution(request.getParameter("institution"));
        profile.setDegree(request.getParameter("degree"));
        profile.setFieldOfStudy(request.getParameter("fieldOfStudy"));
        profile.setSkills(request.getParameter("skills"));
        profile.setCompanyName(request.getParameter("company"));
        profile.setPosition(request.getParameter("position"));
        profile.setWorkDescription(request.getParameter("description"));
        profile.setBio(request.getParameter("bio"));

        // Parse numeric fields
        try {
            String gradYear = request.getParameter("graduationYear");
            if (gradYear != null && !gradYear.isEmpty()) {
                profile.setExpectedGraduation(Integer.parseInt(gradYear));
            }

            String gpaStr = request.getParameter("gpa");
            if (gpaStr != null && !gpaStr.isEmpty()) {
                profile.setGpa(Double.parseDouble(gpaStr));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // Parse dates
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            String dobStr = request.getParameter("dob");
            if (dobStr != null && !dobStr.isEmpty()) {
                java.util.Date dob = dateFormat.parse(dobStr);
                profile.setDateOfBirth(new Date(dob.getTime()));
            }

            String startDateStr = request.getParameter("startDate");
            if (startDateStr != null && !startDateStr.isEmpty()) {
                java.util.Date startDate = dateFormat.parse(startDateStr);
                profile.setStartDate(new Date(startDate.getTime()));
            }

            String endDateStr = request.getParameter("endDate");
            if (endDateStr != null && !endDateStr.isEmpty()) {
                java.util.Date endDate = dateFormat.parse(endDateStr);
                profile.setEndDate(new Date(endDate.getTime()));
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Save profile
        if (profileDAO.saveProfile(profile)) {
            session.setAttribute("message", "Profile saved successfully!");
            response.sendRedirect("/CampusJobPortal/StudentProfileServlet");
        } else {
            session.setAttribute("error", "Failed to save profile. Please try again.");
            response.sendRedirect("/CampusJobPortal/StudentProfileServlet");
        }
    }
}
