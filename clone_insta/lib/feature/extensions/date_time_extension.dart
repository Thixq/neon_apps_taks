import 'package:intl/intl.dart';

/// Extension for [DateTime] to get a human-friendly string.
extension ReadableDateTime on DateTime {
  /// - If it's today → shows only the time (`12:00`)
  /// - If it's within the last 7 days → shows weekday + time (`Monday 11:00`)
  /// - If it's older → shows full date + time (`2 January 2025 11:00`)
  String toReadableString({String? locale}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final inputDay = DateTime(year, month, day);

    final dayDiff = today.difference(inputDay).inDays;

    final timeFormat = DateFormat.Hm(locale); // "12:00"
    final dayFormat = DateFormat.EEEE(locale); // "Monday"
    final fullFormat = DateFormat(
      'd MMMM y HH:mm',
      locale,
    ); // "2 January 2025 11:00"

    if (dayDiff == 0) {
      return timeFormat.format(this);
    } else if (dayDiff < 7) {
      return '${dayFormat.format(this)} ${timeFormat.format(this)}';
    } else {
      return fullFormat.format(this);
    }
  }

  /// Returns a short, social-media style relative time string.
  ///
  /// Examples:
  /// - Less than 1 minute → "now"
  /// - Less than 1 hour  → "13m"
  /// - Less than 1 day   → "2h"
  /// - Less than 7 days  → "3d"
  /// - 7 days or more    → full date ("2 Jan 2025")
  String toRelativeString({String? locale}) {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inSeconds < 60) {
      return 'now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d';
    } else {
      return DateFormat('d MMM y', locale).format(this);
    }
  }
}
