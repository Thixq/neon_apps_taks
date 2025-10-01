import 'package:clone_insta/feature/app_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// A service for handling FCM (Firebase Cloud Messaging) notifications.
///
/// Responsibilities:
/// - Requesting permissions (iOS)
/// - Managing FCM token
/// - Listening to foreground, background, and terminated messages
final class FCMManager {
  FCMManager._();

  /// Singleton instance.
  static final FCMManager instance = FCMManager._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Initializes FCM, requests permission and sets up listeners.
  Future<void> init() async {
    await _requestPermission();
    await _setupInteractedMessage();
    _setupForegroundListener();
    _setupBackgroundListener();
  }

  /// Requests notification permissions (required for iOS).
  Future<void> _requestPermission() async {
    await _messaging.requestPermission();
  }

  /// Handles messages that opened the app from terminated state.
  Future<void> _setupInteractedMessage() async {
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  /// Foreground notifications.
  void _setupForegroundListener() {
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  /// Background notifications (when user taps a notification).
  void _setupBackgroundListener() {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  /// Handles received messages (common entry point).
  void _handleMessage(RemoteMessage message) {
    final data = message.data;
    final notification = message.notification;
    AppLogger.log('📩 FCM Message received!');
    AppLogger.log('Data: $data');
    if (notification != null) {
      AppLogger.log('Title: ${notification.title}, Body: ${notification.body}');
    }
  }
}
