// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  id: json['id'] as String,
  fullName: json['fullName'] as String?,
  nickName: json['nickName'] as String?,
  email: json['email'] as String?,
  profileImage: json['profileImage'] as String?,
  followers: (json['followers'] as num?)?.toInt(),
  following: (json['following'] as num?)?.toInt(),
  posts: (json['posts'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'nickName': instance.nickName,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'followers': instance.followers,
      'following': instance.following,
      'posts': instance.posts,
    };
