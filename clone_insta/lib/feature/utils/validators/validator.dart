// ignore_for_file: library_private_types_in_public_api, document_ignores

import 'package:kartal/kartal.dart';

part 'sign_validator.dart';
part 'generic_validator.dart';

/// Validator
class Validator {
  const Validator._();

  /// Generic Validator
  static _GenericValidator get generic => const _GenericValidator._();

  /// Sign Validator
  static _SignValidator get sign => const _SignValidator._();
}
