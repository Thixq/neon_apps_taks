// ignore_for_file: public_member_api_docs, sort_constructors_first, document_ignores
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
    this.email,
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

  /// The email of the user.
  final String? email;

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

  @override
  List<Object?> get props => [
    id,
    fullName,
    nickName,
    profileImage,
    followers,
    following,
    posts,
  ];

  @override
  bool? get stringify => true;

  ProfileModel copyWith({
    String? id,
    String? fullName,
    String? nickName,
    String? email,
    String? profileImage,
    int? followers,
    int? following,
    int? posts,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
    );
  }
}
