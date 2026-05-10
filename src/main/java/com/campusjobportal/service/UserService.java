package com.campusjobportal.service;

import com.campusjobportal.dao.UserDAO;
import com.campusjobportal.model.User;
import com.campusjobportal.util.PasswordUtil;
import com.campusjobportal.util.ValidationUtil;


import java.util.List;

/**
 * UserService.java
 * Service layer for all user-account business logic:
 * registration, login, profile management, and admin control.
 *
 * Roles handled:
 *   STUDENT   — registers, manages profile, applies for jobs
 *   RECRUITER — registers company, posts jobs
 *   ADMIN     — pre-seeded in DB; approves/suspends accounts
 *
 * Author: Prabesh Adhikari
 * Project: Campus Job Portal System
 */
public class UserService {

    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    // ----------------------------------------------------------------
    // REGISTRATION
    // ----------------------------------------------------------------

    /**
     * Registers a new Student account.
     *
     * Validation:
     *  - Full name must contain only letters and spaces
     *  - Email must be a valid format and must not already exist
     *  - Phone must be exactly 10 digits and must not already exist
     *  - Password must be at least 8 characters
     *  - Date of birth must be provided
     *
     * After validation the password is SHA-256 hashed before storage.
     * New accounts are set to PENDING — admin must approve.
     *
     * @param user  User object from the registration form
     * @return      Error message, or null on success
     */
    public String registerStudent(User user) {
        // Field validation
        String err = validateCommonFields(user);
        if (err != null) return err;

        // Student-specific: date of birth required
        if (user.getDateOfBirth() == null) {
            return "Date of birth is required.";
        }
        // Academic info
        if (ValidationUtil.isNullOrEmpty(user.getCourse())) {
            return "Course/programme is required.";
        }

        return persistNewUser(user, "STUDENT");
    }

    /**
     * Registers a new Recruiter (company) account.
     *
     * Validation:
     *  - Company name required
     *  - Company description required
     *  - Shared email/phone uniqueness rules apply
     *
     * @param user  User object from the recruiter registration form
     * @return      Error message, or null on success
     */
    public String registerRecruiter(User user) {
        String err = validateCommonFields(user);
        if (err != null) return err;

        if (ValidationUtil.isNullOrEmpty(user.getCompanyName())) {
            return "Company name is required.";
        }

        return persistNewUser(user, "RECRUITER");
    }

    // ----------------------------------------------------------------
    // LOGIN
    // ----------------------------------------------------------------

    /**
     * Authenticates a user by email and plain-text password.
     *
     * Steps:
     *  1. Look up user by email.
     *  2. Verify password against stored SHA-256 hash.
     *  3. Check account is ACTIVE (not PENDING or SUSPENDED).
     *
     * @param email     Email entered on the login form
     * @param password  Plain-text password entered on the login form
     * @return          Authenticated User object, or null on failure.
     *                  Call {@link #getLastLoginError()} for the reason.
     */
    public User login(String email, String password) {
        lastLoginError = null;

        if (ValidationUtil.isNullOrEmpty(email) || ValidationUtil.isNullOrEmpty(password)) {
            lastLoginError = "Email and password are required.";
            return null;
        }

        User user = userDAO.getUserByEmail(email.trim().toLowerCase());

        if (user == null) {
            lastLoginError = "No account found with that email address.";
            return null;
        }

        // Password verification — compare against SHA-256 hash
        String hashedInput = PasswordUtil.hashPassword(password);
        if (!hashedInput.equals(user.getPassword())) {
            lastLoginError = "Incorrect password. Please try again.";
            return null;
        }

        // Account status check
        if ("PENDING".equalsIgnoreCase(user.getApprovalStatus())) {
            lastLoginError = "Your account is awaiting admin approval. Please check back later.";
            return null;
        }
        if ("SUSPENDED".equalsIgnoreCase(user.getApprovalStatus())) {
            lastLoginError = "Your account has been suspended. Please contact support.";
            return null;
        }

        return user; // success
    }

    /** Stores the reason a login attempt failed (for controller to forward to JSP). */
    private String lastLoginError;

    public String getLastLoginError() {
        return lastLoginError;
    }

    // ----------------------------------------------------------------
    // PROFILE READ / UPDATE
    // ----------------------------------------------------------------

    /**
     * Retrieves a user by their primary key.
     *
     * @param userId User ID
     * @return       User object, or null if not found
     */
    public User getUserById(int userId) {
        if (userId <= 0) return null;
        return userDAO.getUserById(userId);
    }

    /**
     * Updates a user's profile details.
     * Email and phone uniqueness are re-checked (excluding current user).
     * If a new password is supplied it is hashed before storage.
     *
     * @param user           Updated User object
     * @param newPlainPassword New password, or empty string to keep existing
     * @return               Error message, or null on success
     */
    public String updateProfile(User user, String newPlainPassword) {
        // Basic field validation
        if (ValidationUtil.isNullOrEmpty(user.getFullName())) {
            return "Full name is required.";
        }
        if (!user.getFullName().matches("[a-zA-Z ]+")) {
            return "Full name must contain only letters and spaces.";
        }
        if (!ValidationUtil.isValidEmail(user.getEmail())) {
            return "Please enter a valid email address.";
        }
        if (!ValidationUtil.isValidPhone(user.getPhone())) {
            return "Phone number must be 10 digits.";
        }

        // Email uniqueness (excluding current user)
        User emailOwner = userDAO.findByEmail(user.getEmail());
        if (emailOwner != null && emailOwner.getUserId() != user.getUserId()) {
            return "This email address is already in use by another account.";
        }

        // Phone uniqueness (excluding current user)
        User phoneOwner = userDAO.findByPhone(user.getPhone());
        if (phoneOwner != null && phoneOwner.getUserId() != user.getUserId()) {
            return "This phone number is already registered.";
        }

        // Hash new password if provided
        if (!ValidationUtil.isNullOrEmpty(newPlainPassword)) {
            if (newPlainPassword.length() < 8) {
                return "Password must be at least 8 characters long.";
            }
            user.setPasswordHash(PasswordUtil.hashPassword(newPlainPassword));
        }

        userDAO.updateUser(user);
        return null;
    }

    // ----------------------------------------------------------------
    // ADMIN OPERATIONS
    // ----------------------------------------------------------------

    /**
     * Returns all users of a given role for the admin panel.
     *
     * @param role  "STUDENT", "RECRUITER", or "ADMIN"
     * @return      List of matching users
     */
    public List<User> getUsersByRole(String role) {
        return userDAO.findByRole(role);
    }

    /**
     * Returns all users with PENDING status awaiting admin approval.
     *
     * @return List of pending users
     */
    public List<User> getPendingUsers() {
        return userDAO.findByStatus("PENDING");
    }

    /**
     * Admin approves a user account — sets status to ACTIVE.
     *
     * @param userId User to approve
     * @return       Error message, or null on success
     */
    public String approveUser(int userId) {
        return changeUserStatus(userId, "ACTIVE");
    }

    /**
     * Admin suspends a user account — sets status to SUSPENDED.
     *
     * @param userId User to suspend
     * @return       Error message, or null on success
     */
    public String suspendUser(int userId) {
        return changeUserStatus(userId, "SUSPENDED");
    }

    /**
     * Admin permanently deletes a user and all related records.
     *
     * @param userId User to delete
     * @return       Error message, or null on success
     */
    public String deleteUser(int userId) {
        User user = userDAO.findById(userId);
        if (user == null) return "User not found.";
        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            return "Admin accounts cannot be deleted through this panel.";
        }
        userDAO.deleteUser(userId);
        return null;
    }

    /**
     * Returns total count of users by role (for dashboard stats).
     *
     * @param role User role string
     * @return     Count
     */
    public int countUsersByRole(String role) {
        return userDAO.countByRole(role);
    }

    // ----------------------------------------------------------------
    // PRIVATE HELPERS
    // ----------------------------------------------------------------

    /**
     * Validates fields common to both students and recruiters.
     */
    private String validateCommonFields(User user) {
        if (ValidationUtil.isNullOrEmpty(user.getFullName())) {
            return "Full name is required.";
        }
        if (!user.getFullName().matches("[a-zA-Z ]+")) {
            return "Full name must contain only letters and spaces. Numbers are not allowed.";
        }
        if (!ValidationUtil.isValidEmail(user.getEmail())) {
            return "Please enter a valid email address.";
        }
        if (!ValidationUtil.isValidPhone(user.getPhone())) {
            return "Phone number must be exactly 10 digits.";
        }
        if (ValidationUtil.isNullOrEmpty(user.getPlainPassword())) {
            return "Password is required.";
        }
        if (user.getPlainPassword().length() < 8) {
            return "Password must be at least 8 characters long.";
        }
        return null;
    }

    /**
     * Checks email and phone uniqueness then persists the new user.
     *
     * @param user User to save
     * @param role Role to assign
     * @return     Error message, or null on success
     */
    private String persistNewUser(User user, String role) {
        // Email uniqueness
        if (userDAO.findByEmail(user.getEmail()) != null) {
            return "An account with this email address already exists.";
        }
        // Phone uniqueness
        if (userDAO.findByPhone(user.getPhone()) != null) {
            return "An account with this phone number already exists.";
        }

        // Hash password before storage
        user.setPasswordHash(PasswordUtil.hashPassword(user.getPlainPassword()));
        user.setRole(role);
        user.setStatus("PENDING"); // awaiting admin approval

        userDAO.insertUser(user);
        return null;
    }

    /**
     * Generic account-status helper used by approve/suspend.
     */
    private String changeUserStatus(int userId, String newStatus) {
        User user = userDAO.findById(userId);
        if (user == null) return "User not found.";
        userDAO.updateUserStatus(userId, newStatus);
        return null;
    }
}
