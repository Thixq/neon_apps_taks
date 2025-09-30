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
  Future<String?> get getFCMToken async =>
      FirebaseMessaging.instance.getToken();

  /// Device Sync
  Future<void> deviceSync() async {
    if (!await deviceCheck()) {
      return;
    }

    final userIdOther = _checkUserId(other: _notificationDeviceModel);
    final tokenOther = await _checkToken(other: userIdOther);
    if (tokenOther != _notificationDeviceModel) {
      await _updateDevice(other: tokenOther);
    }
    _onRefreshToken();
  }

  @visibleForTesting
  /// Device Check
  Future<bool> deviceCheck() async {
    final isDeviceExist = await _getNotificationDevice();
    if (isDeviceExist) {
      return isDeviceExist;
    }
    return _createNotificationDevice();
  }

  Future<bool> _createNotificationDevice() async {
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
    return true;
  }

  Future<bool> _getNotificationDevice() async {
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
    _notificationDeviceModel = snapshot.data();
    return true;
  }

  NotificationDeviceModel? _checkUserId({
    NotificationDeviceModel? other,
  }) {
    if (other?.userId != _profile?.profile?.id) {
      return other?.copyWith(
        userId: _profile?.profile?.id,
      );
    }
    return other;
  }

  Future<NotificationDeviceModel?> _checkToken({
    NotificationDeviceModel? other,
  }) async {
    final currentToken = await getFCMToken;
    if (other?.fcmToken != currentToken) {
      return other?.copyWith(fcmToken: await getFCMToken);
    }
    return other;
  }

  Future<void> _updateDevice({NotificationDeviceModel? other}) async {
    await _firestore
        .collection(EndPointConstant.devices)
        .doc(other?.id)
        .update(other!.toJson());
  }

  void _onRefreshToken() {
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (event) async {
        final deviceId = await GenerateUuidDeviceId.generateDeviceId();
        await _firestore
            .collection(EndPointConstant.devices)
            .doc(deviceId)
            .update({'fcmToken': event});
      },
    );
  }

  /// Delete Device
  Future<void> deleteDevice() async {
    final deviceId = await GenerateUuidDeviceId.generateDeviceId();
    await _firestore
        .collection(EndPointConstant.devices)
        .doc(deviceId)
        .delete();
  }
}
