// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseCommentModel _$FirebaseCommentModelFromJson(
  Map<String, dynamic> json,
) => FirebaseCommentModel(
  id: json['id'] as String,
  comment: json['comment'] as String?,
  commentedAt: const TimestampNullableConverter().fromJson(
    json['commentedAt'] as Timestamp?,
  ),
  userId: json['userId'] as String?,
);

Map<String, dynamic> _$FirebaseCommentModelToJson(
  FirebaseCommentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'comment': instance.comment,
  'commentedAt': const TimestampNullableConverter().toJson(
    instance.commentedAt,
  ),
  'userId': instance.userId,
};
