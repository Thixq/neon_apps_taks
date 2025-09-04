// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
  id: json['id'] as String,
  likeCount: json['likeCount'] as String,
  byLastComment: json['byLastComment'] as String,
  lastComment: json['lastComment'] as String,
);

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'likeCount': instance.likeCount,
      'byLastComment': instance.byLastComment,
      'lastComment': instance.lastComment,
    };
