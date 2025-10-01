part of 'validator.dart';

final class _SignValidator {
  const _SignValidator._();
  String? emailValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'Email can not be empty';
    }
    if (!text.ext.isValidEmail) {
      return 'Invalid email';
    }
    return null;
  }

  String? passwordValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'Password can not be empty';
    }
    if (text.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
