package com.campusjobportal.controller;

import com.campusjobportal.dao.CompanyDAO;
import com.campusjobportal.model.Company;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/CompanyProfileServlet")
public class CompanyProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CompanyDAO companyDAO =
            new CompanyDAO();

    /**
     * Load company profile
     */

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer recruiterId =
                (Integer) session.getAttribute("userId");

        if (recruiterId == null) {

            response.sendRedirect(
                    "/CampusJobPortal/pages/login.jsp");

            return;
        }

        Company company =
                companyDAO.getCompanyByRecruiterId(
                        recruiterId);

        request.setAttribute("company",
                company);

        request.getRequestDispatcher(
                        "/pages/company-profile.jsp")
                .forward(request, response);
    }

    /**
     * Update company profile
     */

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        Company company = new Company();

        company.setCompanyId(
                Integer.parseInt(
                        request.getParameter(
                                "companyId")));

        company.setCompanyName(
                request.getParameter(
                        "companyName"));

        company.setDescription(
                request.getParameter(
                        "description"));

        company.setWebsite(
                request.getParameter(
                        "website"));

        company.setIndustry(
                request.getParameter(
                        "industry"));

        company.setLocation(
                request.getParameter(
                        "location"));

        boolean success =
                companyDAO.updateCompany(company);

        if (success) {

            response.sendRedirect(
                    "/CampusJobPortal/CompanyProfileServlet");

        } else {

            response.sendRedirect(
                    "/CampusJobPortal/pages/error.jsp");
        }
    }
}