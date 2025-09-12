// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebasePostModel _$FirebasePostModelFromJson(Map<String, dynamic> json) =>
    FirebasePostModel(
      id: json['id'] as String,
      profileId: json['profileId'] as String?,
      likeCount: (json['likeCount'] as num?)?.toInt(),
      contentImageUrl: json['contentImageUrl'] as String?,
      contentDescription: json['contentDescription'] as String?,
      lastCommentId: json['lastCommentId'] as String?,
      createdAt: const TimestampNullableConverter().fromJson(
        json['createdAt'] as Timestamp?,
      ),
    );

Map<String, dynamic> _$FirebasePostModelToJson(
  FirebasePostModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'profileId': instance.profileId,
  'contentImageUrl': instance.contentImageUrl,
  'contentDescription': instance.contentDescription,
  'lastCommentId': instance.lastCommentId,
  'likeCount': instance.likeCount,
  'createdAt': const TimestampNullableConverter().toJson(instance.createdAt),
};
