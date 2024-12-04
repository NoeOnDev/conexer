class Validators {
  static String? validateRequired(String? value, String fieldName) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateLength(
      String? value, String fieldName, int min, int max) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < min || value.length > max) {
      return '$fieldName must be between $min and $max characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
    }
    return null;
  }

  static String? validateTextWithAccents(
      String? value, String fieldName, int min, int max) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < min || value.length > max) {
      return '$fieldName must be between $min and $max characters';
    }
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s]+$').hasMatch(value)) {
      return '$fieldName can only contain letters, numbers, and spaces';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value, String fieldName) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3 || value.length > 30) {
      return 'Username must be between 3 and 30 characters';
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Username can only contain letters';
    }
    return null;
  }

  static String? validateDescription(
      String? value, String fieldName, int min, int max) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < min || value.length > max) {
      return '$fieldName must be between $min and $max characters';
    }
    return null;
  }
}
