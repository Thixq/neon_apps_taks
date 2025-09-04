import 'package:clone_insta/feature/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

/// The model for a user profile.
@JsonSerializable()
final class ProfileModel extends BaseModel<ProfileModel> {
  /// Creates a new instance of [ProfileModel].
  const ProfileModel({
    required super.id,
    required this.fullName,
    required this.nickName,
    required this.profileImage,
  });

  /// A static mock object for testing.
  factory ProfileModel.mock() => const ProfileModel(
    id: '1',
    fullName: 'Kaan',
    nickName: 'Thixq',
    profileImage: 'https://cataas.com/cat',
  );

  /// Creates a new instance of [ProfileModel] from a JSON map.
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  /// The full name of the user.
  final String fullName;

  /// The nickname of the user.
  final String nickName;

  /// The URL of the profile image of the user.
  final String profileImage;

  @override
  ProfileModel fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  @override
  Map<String, dynamic> toMap(ProfileModel model) => _$ProfileModelToJson(this);
}
