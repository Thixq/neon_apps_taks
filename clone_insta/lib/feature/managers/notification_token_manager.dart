// ignore_for_file: prefer_constructors_over_static_methods, document_ignores

import 'package:clone_insta/feature/app_logger.dart';
import 'package:clone_insta/feature/constants/end_point_constant.dart';
import 'package:clone_insta/feature/init/dependency_injection/dependency_container.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/feature/models/notification_device_model.dart';
import 'package:clone_insta/feature/utils/func/generate_uuid_device_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Managing the notification ID of the active session
final class NotificationTokenManager {
  NotificationTokenManager._({
    required FirebaseFirestore firestore,
    required ProfileManager? profile,
  }) : _firestore = firestore,
       _profile = profile;

  static NotificationTokenManager? _instance;

  /// default instance
  static NotificationTokenManager get instance => instanceFor(
    firestore: DependencyContainer.service.firestore,
    profile: DependencyContainer.manager.profileManager,
  );

  /// custom instance
  static NotificationTokenManager instanceFor({
    required FirebaseFirestore firestore,
    required ProfileManager? profile,
  }) => _instance ??= NotificationTokenManager._(
    firestore: firestore,
    profile: profile,
  );

  final FirebaseFirestore _firestore;
  final ProfileManager? _profile;
  NotificationDeviceModel? _notificationDeviceModel;

  /// Get FCM Token
  Future<String?> get getFCMToken async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      AppLogger.log('Fetched FCM token: $token');
      return token;
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Failed to fetch FCM token');
      return null;
    }
  }

  /// Device Sync
  Future<void> deviceSync() async {
    try {
      final exists = await deviceCheck();
      if (!exists) {
        AppLogger.log('Device not found, created new device.');
        return;
      }

      final userIdOther = _checkUserId(other: _notificationDeviceModel);
      final tokenOther = await _checkToken(other: userIdOther);

      if (tokenOther != _notificationDeviceModel && tokenOther != null) {
        await _updateDevice(other: tokenOther);
      }

      _onRefreshToken();
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Device sync failed');
    }
  }

  @visibleForTesting
  /// Device Check
  Future<bool> deviceCheck() async {
    try {
      final isDeviceExist = await _getNotificationDevice();
      if (isDeviceExist) return true;

      return await _createNotificationDevice();
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Device check failed');
      return false;
    }
  }

  Future<bool> _createNotificationDevice() async {
    try {
      final fcmToken = await getFCMToken;
      final platform = defaultTargetPlatform;
      final deviceId = await GenerateUuidDeviceId.generateDeviceId();

      final notificationDeviceModel = NotificationDeviceModel.create(
        userId: _profile?.profile?.id,
        deviceId: deviceId,
        fcmToken: fcmToken,
        platform: platform.name,
      );

      _notificationDeviceModel = notificationDeviceModel;

      await _firestore
          .collection(EndPointConstant.devices)
          .doc(deviceId)
          .set(notificationDeviceModel.toJson());

      AppLogger.log('Created new notification device: $deviceId');
      return true;
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Failed to create device');
      return false;
    }
  }

  Future<bool> _getNotificationDevice() async {
    try {
      final deviceId = await GenerateUuidDeviceId.generateDeviceId();
      final snapshot = await _firestore
          .collection(EndPointConstant.devices)
          .doc(deviceId)
          .withConverter(
            fromFirestore: (snapshot, _) =>
                NotificationDeviceModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          )
          .get();

      if (!snapshot.exists) {
        AppLogger.log('No existing device found for: $deviceId');
        return false;
      }

      _notificationDeviceModel = snapshot.data();
      AppLogger.log('Fetched existing device: $deviceId');
      return true;
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Failed to fetch device');
      return false;
    }
  }

  NotificationDeviceModel? _checkUserId({
    NotificationDeviceModel? other,
  }) {
    if (other?.userId != _profile?.profile?.id) {
      AppLogger.log('UserId mismatch, updating userId');
      return other?.copyWith(
        userId: _profile?.profile?.id,
      );
    }
    return other;
  }

  Future<NotificationDeviceModel?> _checkToken({
    NotificationDeviceModel? other,
  }) async {
    try {
      final currentToken = await getFCMToken;
      if (other?.fcmToken != currentToken) {
        AppLogger.log('Token mismatch, updating FCM token');
        return other?.copyWith(fcmToken: currentToken);
      }
      return other;
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Failed to check token');
      return other;
    }
  }

  Future<void> _updateDevice({NotificationDeviceModel? other}) async {
    if (other == null) return;
    try {
      await _firestore
          .collection(EndPointConstant.devices)
          .doc(other.id)
          .update(other.toJson());

      AppLogger.log('Updated device: ${other.id}');
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Failed to update device');
    }
  }

  void _onRefreshToken() {
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (event) async {
        try {
          final deviceId = await GenerateUuidDeviceId.generateDeviceId();
          await _firestore
              .collection(EndPointConstant.devices)
              .doc(deviceId)
              .update({'fcmToken': event});

          AppLogger.log('Token refreshed for device: $deviceId');
        } catch (e, s) {
          AppLogger.error(e, s, reason: 'Failed during token refresh');
        }
      },
    );
  }

  /// Delete Device
  Future<void> deleteDevice() async {
    try {
      final deviceId =
          _notificationDeviceModel?.id ??
          await GenerateUuidDeviceId.generateDeviceId();
      await _firestore
          .collection(EndPointConstant.devices)
          .doc(deviceId)
          .delete();

      AppLogger.log('Deleted device: $deviceId');
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Failed to delete device');
    }
  }
}
