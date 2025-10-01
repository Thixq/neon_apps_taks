import 'package:clone_insta/feature/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_preview_model.g.dart';

@JsonSerializable()
/// The model for a user.
final class UserPreviewModel extends BaseModel<UserPreviewModel> {
  /// Creates an instance of [UserPreviewModel]
  UserPreviewModel({
    required super.id,
    this.fullName,
    this.nickName,
    this.profileImage,
  });

  /// Creates an instance of [UserPreviewModel] from a JSON map
  factory UserPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$UserPreviewModelFromJson(json);

  /// The user's full name
  final String? fullName;

  /// The user's nick name
  final String? nickName;

  /// The user's profile image
  final String? profileImage;

  @override
  UserPreviewModel fromJson(Map<String, dynamic> json) =>
      _$UserPreviewModelFromJson(json);

  @override
  List<Object?> get props => [id, fullName, nickName, profileImage];

  @override
  bool? get stringify => true;

  @override
  Map<String, dynamic> toJson() => _$UserPreviewModelToJson(this);
}
