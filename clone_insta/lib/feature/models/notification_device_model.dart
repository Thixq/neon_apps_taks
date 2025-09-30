import 'package:clone_insta/feature/models/base_model.dart';
import 'package:clone_insta/feature/utils/json_converters/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_device_model.g.dart';

@JsonSerializable(checked: true)
class NotificationDeviceModel extends BaseModel<NotificationDeviceModel>
    with EquatableMixin {
  NotificationDeviceModel({
    required super.id,
    this.userId,
    this.fcmToken,
    this.platform,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDeviceModelFromJson(json);

  /// Creates a new [NotificationDeviceModel]
  factory NotificationDeviceModel.create({
    required String platform,
    required String deviceId,
    required String? userId,
    required String? fcmToken,
  }) {
    final now = DateTime.now().toUtc();
    return NotificationDeviceModel(
      id: deviceId,
      createdAt: now,
      updatedAt: now,
      platform: platform,
      userId: userId,
      fcmToken: fcmToken,
    );
  }

  /// User id
  final String? userId;

  /// FCM token
  final String? fcmToken;

  /// Device platform
  final String? platform;
  @TimestampNullableConverter()
  /// Created at
  final DateTime? createdAt;
  @TimestampNullableConverter()
  /// Updated at
  final DateTime? updatedAt;

  @override
  NotificationDeviceModel fromJson(Map<String, dynamic> json) =>
      _$NotificationDeviceModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationDeviceModelToJson(this);

  /// Copies the [NotificationDeviceModel]
  NotificationDeviceModel copyWith({
    String? fcmToken,
    String? userId,
  }) {
    return NotificationDeviceModel(
      id: id,
      userId: userId ?? this.userId,
      fcmToken: fcmToken ?? this.fcmToken,
      platform: platform,
      createdAt: createdAt,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  @override
  List<Object?> get props => [id, fcmToken, userId, platform];
}
