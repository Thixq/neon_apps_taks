import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Extension for [double] to get the width or height of the screen.
extension PercentSize on num {
  /// Get the width or height of the screen.
  double w(BuildContext context) =>
      (toDouble() / 100) * MediaQuery.of(context).size.width;

  /// Get the width or height of the screen.
  double h(BuildContext context) =>
      (toDouble() / 100) * MediaQuery.of(context).size.height;
}

extension CompactNumber on num {
  /// Returns a localized compact string (e.g. 12345 -> "12K" or "12k" depending on options/locale).
  ///
  /// - [locale]: Locale string like 'en_US', 'tr_TR'. If null, uses platform/default locale.
  /// - [decimalDigits]: maximum fraction digits (default 0 to get "12k" from 12345). Use 1 to get "12.3k".
  /// - [lowercase]: if true, the suffix part will be lowercased (e.g. "12K" -> "12k"). Default true.
  /// - [removeNbsp]: removes non-breaking space between number and suffix which some locales use.
  String toCompactString({
    String? locale,
    int decimalDigits = 0,
    bool lowercase = true,
    bool removeNbsp = true,
  }) {
    final fmt = NumberFormat.compact(locale: locale);
    // configure fraction digits
    fmt.maximumFractionDigits = decimalDigits;
    fmt.minimumFractionDigits = 0;

    var formatted = fmt.format(this);

    if (removeNbsp) {
      // normalize NBSP to regular space then remove if there's a trailing suffix
      formatted = formatted.replaceAll('\u00A0', ' ');
      // remove space between number and suffix (optional)
      // but keep spaces within the numeric part (rare). We'll remove single space between number and letters/word suffix.
      formatted = formatted.replaceFirstMapped(
        RegExp(r'^([\d\.,\s\-]+)\s+(.+)$'),
        (m) => '${m[1]}${m[2]}',
      );
    }

    if (lowercase) {
      // split into numeric prefix and suffix -> lowercase suffix only to preserve numeric symbols/locale decimals
      final match = RegExp(r'^([\-\d\.,\s]+)(.*)$').firstMatch(formatted);
      if (match != null) {
        final prefix = match.group(1) ?? '';
        final suffix = match.group(2) ?? '';
        formatted = prefix + suffix.toLowerCase();
      } else {
        formatted = formatted.toLowerCase();
      }
    }
    return formatted;
  }
}
