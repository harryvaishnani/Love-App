class Validation {
  static String? validateFullName(String value) {
    final pattern = RegExp(r"^[a-zA-Z\s'-]{3,50}$");
    if (value.isEmpty || !pattern.hasMatch(value)) {
      return "Enter a valid full name (3-50 characters, alphabets only)";
    }
    return null;
  }

  static String? validateEmail(String value) {
    final pattern = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (value.isEmpty || !pattern.hasMatch(value)) {
      return "Enter a valid email address.";
    }
    return null;
  }

  static String? validateMobile(String value) {
    final pattern = RegExp(r"^\+?[0-9]{10,15}$");
    if (value.isEmpty || !pattern.hasMatch(value)) {
      return "Enter a valid 10-digit mobile number.";
    }
    return null;
  }

  static String? validateDOB(String value) {
    final pattern = RegExp(r"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$");
    if (value.isEmpty || !pattern.hasMatch(value)) {
      return "Enter a valid date in DD/MM/YYYY format.";
    }
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your gender.";
    }
    return null;
  }
}
