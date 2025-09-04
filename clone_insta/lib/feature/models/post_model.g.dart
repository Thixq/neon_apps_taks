// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: json['id'] as String,
  profile: ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
  contentImage: json['contentImage'] as String,
  comment: CommentModel.fromJson(json['comment'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'profile': instance.profile,
  'contentImage': instance.contentImage,
  'comment': instance.comment,
};
