import 'dart:io';

String prompt(String message, {String defaultValue = ''}) {
  stdout.write(message);
  return stdin.readLineSync() ?? defaultValue;
}

int promptInt(String message, {int defaultValue = 0}) {
  stdout.write(message);
  return int.tryParse(stdin.readLineSync() ?? '') ?? defaultValue;
}

T promptEnum<T extends Enum>(
  String message,
  List<T> values, {
  T? defaultValue,
}) {
  while (true) {
    stdout.write('$message (${values.map((e) => e.name).join(', ')}): ');
    final input = stdin.readLineSync()?.toLowerCase() ?? '';

    if (input.isEmpty && defaultValue != null) {
      return defaultValue;
    }

    try {
      return values.firstWhere((v) => v.name.toLowerCase() == input);
    } catch (_) {
      print('Geçersiz değer girdiniz, lütfen tekrar deneyin.');
    }
  }
}
