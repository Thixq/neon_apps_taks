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
  createdAt: const TimestampNullableConverter().fromJson(
    json['createdAt'] as Timestamp?,
  ),
  userId: json['userId'] as String?,
);

Map<String, dynamic> _$FirebaseCommentModelToJson(
  FirebaseCommentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'comment': instance.comment,
  'createdAt': const TimestampNullableConverter().toJson(instance.createdAt),
  'userId': instance.userId,
};
