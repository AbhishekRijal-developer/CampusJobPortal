package com.campusjobportal.dao;

import com.campusjobportal.model.Company;
import com.campusjobportal.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CompanyDAO {

    /**
     * Get company profile
     */

    public Company getCompanyByRecruiterId(int recruiterId) {

        Company company = null;

        String query =
                "SELECT * FROM companies " +
                        "WHERE recruiter_id=?";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        conn.prepareStatement(query)
        ) {

            ps.setInt(1, recruiterId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                company = new Company();

                company.setCompanyId(
                        rs.getInt("company_id"));

                company.setCompanyName(
                        rs.getString("company_name"));

                company.setDescription(
                        rs.getString("description"));

                company.setWebsite(
                        rs.getString("website"));

                company.setIndustry(
                        rs.getString("industry"));

                company.setLocation(
                        rs.getString("location"));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return company;
    }

    /**
     * Update company profile
     */

    public boolean updateCompany(Company company) {

        boolean success = false;

        String query =
                "UPDATE companies " +
                        "SET company_name=?, " +
                        "description=?, " +
                        "website=?, " +
                        "industry=?, " +
                        "location=? " +
                        "WHERE company_id=?";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        conn.prepareStatement(query)
        ) {

            ps.setString(1,
                    company.getCompanyName());

            ps.setString(2,
                    company.getDescription());

            ps.setString(3,
                    company.getWebsite());

            ps.setString(4,
                    company.getIndustry());

            ps.setString(5,
                    company.getLocation());

            ps.setInt(6,
                    company.getCompanyId());

            int rows = ps.executeUpdate();

            success = rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return success;
    }
}