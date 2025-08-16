class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }
  
  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
    }
    
    return null;
  }
  
  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }
  
  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    
    return null;
  }
  
  // Minimum length validation
  static String? validateMinLength(String? value, int minLength, String fieldName) {
    if (value == null || value.length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }
    
    return null;
  }
  
  // Maximum length validation
  static String? validateMaxLength(String? value, int maxLength, String fieldName) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must be no more than $maxLength characters long';
    }
    
    return null;
  }
  
  // Phone number validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    
    // Remove all non-digit characters for length check
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.length < 10 || digitsOnly.length > 15) {
      return 'Phone number must be between 10 and 15 digits';
    }
    
    return null;
  }
  
  // URL validation
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional
    }
    
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    
    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }
  
  // Date validation
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }
    
    try {
      DateTime.parse(value);
    } catch (e) {
      return 'Please enter a valid date';
    }
    
    return null;
  }
  
  // Future date validation
  static String? validateFutureDate(String? value) {
    final dateError = validateDate(value);
    if (dateError != null) {
      return dateError;
    }
    
    final date = DateTime.parse(value!);
    final now = DateTime.now();
    
    if (date.isBefore(now)) {
      return 'Date must be in the future';
    }
    
    return null;
  }
  
  // Past date validation
  static String? validatePastDate(String? value) {
    final dateError = validateDate(value);
    if (dateError != null) {
      return dateError;
    }
    
    final date = DateTime.parse(value!);
    final now = DateTime.now();
    
    if (date.isAfter(now)) {
      return 'Date must be in the past';
    }
    
    return null;
  }
  
  // Number validation
  static String? validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    if (double.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }
    
    return null;
  }
  
  // Positive number validation
  static String? validatePositiveNumber(String? value, String fieldName) {
    final numberError = validateNumber(value, fieldName);
    if (numberError != null) {
      return numberError;
    }
    
    final number = double.parse(value!);
    if (number <= 0) {
      return '$fieldName must be greater than 0';
    }
    
    return null;
  }
  
  // Range validation
  static String? validateRange(String? value, double min, double max, String fieldName) {
    final numberError = validateNumber(value, fieldName);
    if (numberError != null) {
      return numberError;
    }
    
    final number = double.parse(value!);
    if (number < min || number > max) {
      return '$fieldName must be between $min and $max';
    }
    
    return null;
  }
  
  // Multiple validators
  static String? validateMultiple(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) {
        return error;
      }
    }
    
    return null;
  }
  
  // Custom regex validation
  static String? validateRegex(String? value, RegExp regex, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    
    if (!regex.hasMatch(value)) {
      return errorMessage;
    }
    
    return null;
  }
}