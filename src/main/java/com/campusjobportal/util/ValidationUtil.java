package com.campusjobportal.util;

public class ValidationUtil {

    public static boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        if (isNullOrEmpty(email)) return false;
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    public static boolean isValidPhone(String phone) {
        if (isNullOrEmpty(phone)) return false;
        return phone.matches("^\\+?[0-9]{10,15}$");
    }
}