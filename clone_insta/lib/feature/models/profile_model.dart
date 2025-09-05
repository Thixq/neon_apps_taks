import 'package:clone_insta/feature/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

/// The model for a user profile.
@JsonSerializable()
final class ProfileModel extends BaseModel<ProfileModel> {
  /// Creates a new instance of [ProfileModel].
  const ProfileModel({
    required super.id,
    this.fullName,
    this.nickName,
    this.profileImage,
    this.followers,
    this.following,
    this.posts,
  });

  /// A static mock object for testing.
  factory ProfileModel.mock() => const ProfileModel(
    id: '1',
    fullName: 'Kaan',
    nickName: 'Thixq',
    profileImage: 'https://cataas.com/cat',
    followers: 12344,
    following: 23,
    posts: 2,
  );

  /// Creates a new instance of [ProfileModel] from a JSON map.
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  /// The full name of the user.
  final String? fullName;

  /// The nickname of the user.
  final String? nickName;

  /// The URL of the profile image of the user.
  final String? profileImage;

  /// The number of followers of the user.
  final int? followers;

  /// The number of following of the user.
  final int? following;

  /// The number of posts of the user.
  final int? posts;

  @override
  ProfileModel fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
