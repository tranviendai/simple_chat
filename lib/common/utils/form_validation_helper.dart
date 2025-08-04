class FormValidationHelper {
  static String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length > 45) {
      return 'Only 45 characters are allowed';
    }
    return null;
  }
}
