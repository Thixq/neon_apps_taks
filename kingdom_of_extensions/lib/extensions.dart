extension StringExtensions on String {
  String _clean() => replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toLowerCase();

  bool get isPalindrome {
    final s = _clean();
    return s == s.split('').reversed.join();
  }
}

extension IntExtensions on int {
  bool get isPrime {
    if (this < 2) return false;
    if (this == 2) return true;
    if (this % 2 == 0) return false;
    for (var i = 3; i * i <= this; i += 2) {
      if (this % i == 0) return false;
    }
    return true;
  }
}

extension DateTimeExtensions on DateTime {
  /// Returns absolute number of full days between two dates (ignores time of day).
  int daysBetween(DateTime other) {
    final a = DateTime(year, month, day);
    final b = DateTime(other.year, other.month, other.day);
    return a.difference(b).inDays.abs();
  }
}

extension BoolExtensions on bool {
  /// Toggle the boolean (convenience)
  bool toggle() => !this;

  /// Evaluate simple logic with another boolean using operator strings "AND", "OR", "XOR"
  bool evaluate(String operator, bool other) {
    switch (operator.toUpperCase()) {
      case 'AND':
        return this && other;
      case 'OR':
        return this || other;
      case 'XOR':
        return (this && !other) || (!this && other);
      default:
        throw ArgumentError('Unsupported operator: $operator');
    }
  }
}

extension SetExtensions<T> on Set<T> {
  /// Returns symmetric difference between two sets (items in either set but not both).
  Set<T> symmetricDifference(Set<T> other) {
    final result = {...this};
    for (var e in other) {
      if (!result.remove(e)) result.add(e);
    }
    return result;
  }
}

extension ListMapStringExtensions on List<Map<String, String>> {
  /// Groups a list of person maps by the `surname` key.
  /// Each map is expected to have keys like `{ 'name': 'Ali', 'surname': 'Kaya' }`.
  Map<String, List<Map<String, String>>> groupBySurname() {
    final Map<String, List<Map<String, String>>> res = {};
    for (final m in this) {
      final surname = m['surname'] ?? 'Unknown';
      res.putIfAbsent(surname, () => []).add(m);
    }
    return res;
  }
}
