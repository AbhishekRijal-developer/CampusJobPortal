package com.campusjobportal.dao;

import com.campusjobportal.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RecruiterDashboardDAO {

    /**
     * Get total jobs posted by recruiter
     */

    public int getTotalJobs(int recruiterId) {

        int count = 0;

        String query =
                "SELECT COUNT(*) FROM jobs WHERE recruiter_id=?";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        conn.prepareStatement(query)
        ) {

            ps.setInt(1, recruiterId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }

    /**
     * Get total applicants
     */

    public int getTotalApplicants(int recruiterId) {

        int count = 0;

        String query =
                "SELECT COUNT(*) " +
                        "FROM applications a " +
                        "JOIN jobs j ON a.job_id=j.job_id " +
                        "WHERE j.recruiter_id=?";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        conn.prepareStatement(query)
        ) {

            ps.setInt(1, recruiterId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }

    /**
     * Get shortlisted applicants count
     */

    public int getShortlistedApplicants(int recruiterId) {

        int count = 0;

        String query =
                "SELECT COUNT(*) " +
                        "FROM applications a " +
                        "JOIN jobs j ON a.job_id=j.job_id " +
                        "WHERE j.recruiter_id=? " +
                        "AND a.status='Shortlisted'";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        conn.prepareStatement(query)
        ) {

            ps.setInt(1, recruiterId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }

    /**
     * Get active jobs count
     */

    public int getActiveJobs(int recruiterId) {

        int count = 0;

        String query =
                "SELECT COUNT(*) " +
                        "FROM jobs " +
                        "WHERE recruiter_id=? " +
                        "AND status='Open'";

        try (
                Connection conn =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        conn.prepareStatement(query)
        ) {

            ps.setInt(1, recruiterId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }
}