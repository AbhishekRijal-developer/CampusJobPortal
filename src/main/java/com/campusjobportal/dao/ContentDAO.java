package com.campusjobportal.dao;

import com.campusjobportal.model.SiteContent;
import com.campusjobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContentDAO {

    public List<SiteContent> getPageContent(String pageName) {
        List<SiteContent> contents = new ArrayList<>();
        String query = "SELECT * FROM site_content WHERE page_name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, pageName);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    SiteContent content = new SiteContent();
                    content.setContentId(rs.getInt("content_id"));
                    content.setPageName(rs.getString("page_name"));
                    content.setContentKey(rs.getString("content_key"));
                    content.setContentValue(rs.getString("content_value"));
                    content.setUpdatedDate(rs.getTimestamp("updated_date"));
                    contents.add(content);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contents;
    }

    public boolean updateContent(String pageName, String key, String value) {
        String query = "INSERT INTO site_content (page_name, content_key, content_value) VALUES (?, ?, ?) " +
                       "ON DUPLICATE KEY UPDATE content_value = ?, updated_date = NOW()";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, pageName);
            stmt.setString(2, key);
            stmt.setString(3, value);
            stmt.setString(4, value);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
