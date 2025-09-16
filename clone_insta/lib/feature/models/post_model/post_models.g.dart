// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebasePostModel _$FirebasePostModelFromJson(Map<String, dynamic> json) =>
    FirebasePostModel(
      id: json['id'] as String,
      profileId: json['profileId'] as String,
      contentImageUrl: json['contentImageUrl'] as String?,
      caption: json['caption'] as String?,
      lastCommentId: json['lastCommentId'] as String?,
      likeCount: (json['likeCount'] as num?)?.toInt(),
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
  'caption': instance.caption,
  'lastCommentId': instance.lastCommentId,
  'likeCount': instance.likeCount,
  'createdAt': const TimestampNullableConverter().toJson(instance.createdAt),
};
