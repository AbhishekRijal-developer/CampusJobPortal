// Placeholder for JavaScript utilities
// Add your custom JavaScript functions here

console.log("Campus Job Portal initialized");

// Form validation helpers
function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// Password strength checker
function checkPasswordStrength(password) {
    let strength = 0;
    if (password.length >= 8) strength++;
    if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
    if (/\d/.test(password)) strength++;
    if (/[^a-zA-Z\d]/.test(password)) strength++;
    return strength;
}

// Confirm action
function confirmAction(message) {
    return confirm(message);
}

// Show success message
function showSuccessMessage(message) {
    alert("Success: " + message);
}

// Show error message
function showErrorMessage(message) {
    alert("Error: " + message);
}
