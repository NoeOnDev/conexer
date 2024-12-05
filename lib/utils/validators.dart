class Validators {
  static String? validateRequired(String? value, String fieldName) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$fieldName es requerido';
    }
    return null;
  }

  static String? validateLength(
      String? value, String fieldName, int min, int max) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$fieldName es requerido';
    }
    if (value.length < min || value.length > max) {
      return '$fieldName debe tener entre $min y $max caracteres';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Correo electrónico es requerido';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Contraseña es requerida';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
      return 'La contraseña debe contener al menos una letra mayúscula, una letra minúscula y un número';
    }
    return null;
  }

  static String? validateTextWithAccents(
      String? value, String fieldName, int min, int max) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$fieldName es requerido';
    }
    if (value.length < min || value.length > max) {
      return '$fieldName debe tener entre $min y $max caracteres';
    }
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s]+$').hasMatch(value)) {
      return '$fieldName solo puede contener letras, números y espacios';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value, String fieldName) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$fieldName es requerido';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Ingrese un número de teléfono de 10 dígitos válido';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Nombre de usuario es requerido';
    }
    if (value.length < 3 || value.length > 30) {
      return 'El nombre de usuario debe tener entre 3 y 30 caracteres';
    }
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'El nombre de usuario solo puede contener letras';
    }
    return null;
  }

  static String? validateDescription(
      String? value, String fieldName, int min, int max) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return '$fieldName es requerido';
    }
    if (value.length < min || value.length > max) {
      return '$fieldName debe tener entre $min y $max caracteres';
    }
    return null;
  }
}
