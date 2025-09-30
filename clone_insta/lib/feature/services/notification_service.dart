import 'package:firebase_messaging/firebase_messaging.dart';

/// A service for handling FCM (Firebase Cloud Messaging) notifications.
///
/// Responsibilities:
/// - Requesting permissions (iOS)
/// - Managing FCM token
/// - Listening to foreground, background, and terminated messages
final class FCMService {
  FCMService._();
  static final FCMService instance = FCMService._();

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
    // TODO: Add your own logic here (e.g., navigation, logging, etc.)
    final data = message.data;
    final notification = message.notification;
    print('📩 FCM Message received!');
    print('Data: $data');
    if (notification != null) {
      print('Title: ${notification.title}, Body: ${notification.body}');
    }
  }

  /// Retrieves current FCM token.
  Future<String?> getToken() async {
    return _messaging.getToken();
  }

  /// Listen to token refresh events.
  void onTokenRefresh(void Function(String token) callback) {
    _messaging.onTokenRefresh.listen(callback);
  }
}
