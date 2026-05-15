package com.campusjobportal.util;

import org.apache.commons.codec.digest.DigestUtils;

public class PasswordUtil {
    
    /**
     * Hashes the password using SHA-256
     * @param password Plain text password
     * @return Hashed password string
     */
    public static String hashPassword(String password) {
        if (password == null) return null;
        return DigestUtils.sha256Hex(password);
    }
    
    /**
     * Verifies if the plain password matches the hashed password
     * @param plainPassword Plain text password from input
     * @param hashedPassword Hashed password from database
     * @return true if matches, false 
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) return false;
        return hashPassword(plainPassword).equals(hashedPassword);
    }
}
