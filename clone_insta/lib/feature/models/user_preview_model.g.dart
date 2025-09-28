// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreviewModel _$UserPreviewModelFromJson(Map<String, dynamic> json) =>
    UserPreviewModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String?,
      nickName: json['nickName'] as String?,
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$UserPreviewModelToJson(UserPreviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'nickName': instance.nickName,
      'profileImage': instance.profileImage,
    };
