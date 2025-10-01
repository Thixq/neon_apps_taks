import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart' show debugPrint;

/// Central logging service.
/// Sends logs to both debugPrint (console) and Crashlytics.
class AppLogger {
  AppLogger._(); // private constructor

  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  /// Basic log
  static void log(String message) {
    debugPrint('📋 [LOG] $message');

    _crashlytics.log(message);
  }

  /// Error logging (without crashing)
  static void error(
    dynamic error,
    StackTrace stack, {
    String? reason,
    bool fatal = false,
  }) {
    debugPrint('❌ [ERROR] $reason\n$error\n$stack');

    _crashlytics.recordError(
      error,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Add custom key
  static Future<void> setKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value.toString());
    debugPrint('🔑 [KEY] $key = $value');
  }

  /// User ID identification
  static Future<void> setUserId(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
    debugPrint('👤 [USER] $userId');
  }

  /// Clear user ID
  static Future<void> clearUserId() async {
    await _crashlytics.setUserIdentifier('');
    debugPrint('👤 [USER] cleared');
  }

  /// Test crash
  static Future<void> crash() async {
    _crashlytics.crash();
  }
}
