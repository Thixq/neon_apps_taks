// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: json['id'] as String,
  profile: json['profile'] == null
      ? null
      : ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
  contentImage: json['contentImage'] as String?,
  comment: json['comment'] == null
      ? null
      : CommentModel.fromJson(json['comment'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'profile': instance.profile?.toJson(),
  'contentImage': instance.contentImage,
  'comment': instance.comment?.toJson(),
  'createdAt': instance.createdAt?.toIso8601String(),
};
