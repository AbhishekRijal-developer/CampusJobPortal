package com.campusjobportal.dao;

import com.campusjobportal.model.User;
import com.campusjobportal.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());

    /**
     * Register a new user
     * @param user User object containing registration details
     * @return true if registration is successful, false otherwise
     */
    public boolean registerUser(User user) {
        String query = "INSERT INTO users (first_name, last_name, email, password, user_type, phone_number, is_active, created_date) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setString(3, user.getEmail());
            // Hash the password before saving
            preparedStatement.setString(4, com.campusjobportal.util.PasswordUtil.hashPassword(user.getPassword()));
            preparedStatement.setString(5, user.getUserType());
            preparedStatement.setString(6, user.getPhoneNumber());
            preparedStatement.setBoolean(7, true);
            
            int result = preparedStatement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error registering user: " + user.getEmail(), e);
            return false;
        }
    }

    /**
     * Authenticate a user during login
     * @param email User email
     * @param password User password
     * @return User object if authentication is successful, null otherwise
     */
    public User authenticateUser(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND password = ? AND is_active = true";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, email);
            // Hash input password to compare with database hash
            preparedStatement.setString(2, com.campusjobportal.util.PasswordUtil.hashPassword(password));
            
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setFirstName(resultSet.getString("first_name"));
                user.setLastName(resultSet.getString("last_name"));
                user.setEmail(resultSet.getString("email"));
                user.setUserType(resultSet.getString("user_type"));
                user.setPhoneNumber(resultSet.getString("phone_number"));
                user.setActive(resultSet.getBoolean("is_active"));
                return user;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error authenticating user: " + email, e);
        }
        return null;
    }

    /**
     * Get user by email
     * @param email User email
     * @return User object if found, null otherwise
     */
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setFirstName(resultSet.getString("first_name"));
                user.setLastName(resultSet.getString("last_name"));
                user.setEmail(resultSet.getString("email"));
                user.setUserType(resultSet.getString("user_type"));
                user.setPhoneNumber(resultSet.getString("phone_number"));
                return user;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting user by email: " + email, e);
        }
        return null;
    }

    /**
     * Get user by ID
     * @param studentId User ID
     * @return User object if found, null otherwise
     */
    public User getUserById(int studentId) {
        String query = "SELECT * FROM users WHERE user_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, studentId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setFirstName(resultSet.getString("first_name"));
                user.setLastName(resultSet.getString("last_name"));
                user.setEmail(resultSet.getString("email"));
                user.setUserType(resultSet.getString("user_type"));
                user.setPhoneNumber(resultSet.getString("phone_number"));
                user.setCompanyName(resultSet.getString("company_name"));
                user.setResumePath(resultSet.getString("resume_path"));
                return user;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting user by ID: " + studentId, e);
        }
        return null;
    }

    /**
     * Update user profile
     * @param user User object with updated details
     * @return true if update is successful, false otherwise
     */
    public boolean updateUserProfile(User user) {
        String query = "UPDATE users SET first_name=?, last_name=?, phone_number=?, company_name=?, resume_path=?, updated_date=NOW() WHERE user_id=?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setString(3, user.getPhoneNumber());
            preparedStatement.setString(4, user.getCompanyName());
            preparedStatement.setString(5, user.getResumePath());
            preparedStatement.setInt(6, user.getUserId());
            
            int result = preparedStatement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user profile: " + user.getUserId(), e);
            return false;
        }
    }

    /**
     * Get all users in the system (for admin management)
     * @return List of all User objects
     */
    public java.util.List<User> getAllUsers() {
        java.util.List<User> users = new java.util.ArrayList<>();
        String query = "SELECT * FROM users ORDER BY created_date DESC";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            
            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setFirstName(resultSet.getString("first_name"));
                user.setLastName(resultSet.getString("last_name"));
                user.setEmail(resultSet.getString("email"));
                user.setUserType(resultSet.getString("user_type"));
                user.setPhoneNumber(resultSet.getString("phone_number"));
                user.setCompanyName(resultSet.getString("company_name"));
                user.setActive(resultSet.getBoolean("is_active"));
                user.setApprovalStatus(resultSet.getString("approval_status"));
                user.setCreatedDate(resultSet.getString("created_date"));
                users.add(user);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all users", e);
        }
        
        return users;
    }

    /**
     * Activate a user account
     * @param userId User ID
     * @return true if activation successful, false otherwise
     */
    public boolean activateUser(int userId) {
        String query = "UPDATE users SET is_active = true, approval_status = 'APPROVED' WHERE user_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, userId);
            int result = preparedStatement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error activating user: " + userId, e);
            return false;
        }
    }

    /**
     * Deactivate a user account
     * @param userId User ID
     * @return true if deactivation successful, false otherwise
     */
    public boolean deactivateUser(int userId) {
        String query = "UPDATE users SET is_active = false, approval_status = 'REJECTED' WHERE user_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, userId);
            int result = preparedStatement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deactivating user: " + userId, e);
            return false;
        }
    }

    public Map<String, User> getUsersByStatus(String status) {
        Map<String, User> users = new HashMap<>();
        String query = "SELECT * FROM users WHERE approval_status = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, status);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                User user = mapResultSetToUser(resultSet);
                users.put(String.valueOf(user.getUserId()), user);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting users by status: " + status, e);
        }
        return users;
    }

    public User findById(int userId) {
        return getUserById(userId);
    }

    public User findByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToUser(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding user by email: " + email, e);
        }
        return null;
    }

    public User findByPhone(String phone) {
        String query = "SELECT * FROM users WHERE phone_number = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, phone);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToUser(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding user by phone: " + phone, e);
        }
        return null;
    }

    public boolean updateUser(User user) {
        String query = "UPDATE users SET first_name = ?, last_name = ?, email = ?, password = ?, user_type = ?, phone_number = ?, company_name = ?, resume_path = ?, is_active = ?, approval_status = ?, updated_date = ? WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setString(5, user.getUserType());
            preparedStatement.setString(6, user.getPhoneNumber());
            preparedStatement.setString(7, user.getCompanyName());
            preparedStatement.setString(8, user.getResumePath());
            preparedStatement.setBoolean(9, user.isActive());
            preparedStatement.setString(10, user.getApprovalStatus());
            preparedStatement.setString(11, user.getUpdatedDate());
            preparedStatement.setInt(12, user.getUserId());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user: " + user.getUserId(), e);
            return false;
        }
    }

    public boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting user: " + userId, e);
            return false;
        }
    }

    public List<User> findByRole(String role) {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users WHERE user_type = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, role);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                users.add(mapResultSetToUser(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding users by role: " + role, e);
        }
        return users;
    }

    public List<User> findByStatus(String status) {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users WHERE approval_status = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, status);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                users.add(mapResultSetToUser(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding users by status: " + status, e);
        }
        return users;
    }

    public int countByRole(String role) {
        String query = "SELECT COUNT(*) FROM users WHERE user_type = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, role);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting users by role: " + role, e);
        }
        return 0;
    }

    private User mapResultSetToUser(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setUserId(resultSet.getInt("user_id"));
        user.setFirstName(resultSet.getString("first_name"));
        user.setLastName(resultSet.getString("last_name"));
        user.setEmail(resultSet.getString("email"));
        user.setPassword(resultSet.getString("password"));
        user.setUserType(resultSet.getString("user_type"));
        user.setPhoneNumber(resultSet.getString("phone_number"));
        user.setCompanyName(resultSet.getString("company_name"));
        user.setResumePath(resultSet.getString("resume_path"));
        user.setActive(resultSet.getBoolean("is_active"));
        user.setApprovalStatus(resultSet.getString("approval_status"));
        user.setCreatedDate(resultSet.getString("created_date"));
        user.setUpdatedDate(resultSet.getString("updated_date"));
        return user;
    }

    public boolean insertUser(User user) {
        String query = "INSERT INTO users (first_name, last_name, email, password, user_type, phone_number, is_active, approval_status, created_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setString(5, user.getUserType());
            preparedStatement.setString(6, user.getPhoneNumber());
            preparedStatement.setBoolean(7, user.isActive());
            preparedStatement.setString(8, user.getApprovalStatus());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting user", e);
            return false;
        }
    }

    public boolean updateUserStatus(int userId, String status) {
        String query = "UPDATE users SET approval_status = ? WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, userId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user status: " + userId, e);
            return false;
        }
    }
}
