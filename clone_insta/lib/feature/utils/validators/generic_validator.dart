part of 'validator.dart';

class _GenericValidator {
  const _GenericValidator._();

  String? isEmpty(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'Field can not be empty';
    }
    return null;
  }
}
