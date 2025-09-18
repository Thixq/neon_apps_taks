import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

/// Remote Config
final class CloneInstaConfig {
  /// Constructor
  CloneInstaConfig._({required FirebaseRemoteConfig remoteConfig})
    : _remoteConfig = remoteConfig;

  static CloneInstaConfig? _instance;

  /// custom instance
  static CloneInstaConfig instanceFor({
    required FirebaseRemoteConfig remoteConfig,
  }) => _instance ??= CloneInstaConfig._(remoteConfig: remoteConfig);

  /// default instance
  static CloneInstaConfig get instance => _instance ??= CloneInstaConfig._(
    remoteConfig: FirebaseRemoteConfig.instance,
  );

  final FirebaseRemoteConfig _remoteConfig;

  /// Initialize Remote Config
  Future<void> initialize() async {
    await _remoteConfig.ensureInitialized();

    // Remote Config Settings
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 5),
        minimumFetchInterval: const Duration(seconds: 1), // prod'da büyüt
      ),
    );

    await _remoteConfig.setDefaults({
      'theme_color': '#1877F2',
    });

    await _remoteConfig.fetchAndActivate();
  }

  /// Getter for theme color
  Color get themeColor {
    final hex = _remoteConfig.getString('theme_color');
    return _hexToColor(hex, fallback: const Color(0xFF1877F2));
  }

  Color _hexToColor(String hex, {Color fallback = Colors.blue}) {
    try {
      final buffer = StringBuffer();
      if (hex.length == 6 || hex.length == 7) buffer.write('ff');
      buffer.write(hex.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      debugPrint('Unable to parse color $hex');
      return fallback;
    }
  }
}
