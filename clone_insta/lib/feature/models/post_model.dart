import 'package:clone_insta/feature/models/base_model.dart';
import 'package:clone_insta/feature/models/comment_model.dart';
import 'package:clone_insta/feature/models/profile_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

/// The model for a post.
@JsonSerializable()
final class PostModel extends BaseModel<PostModel> {
  /// Constructor
  const PostModel({
    required super.id,
    this.profile,
    this.contentImage,
    this.comment,
    this.createdAt,
  });

  /// This method returns a mock post model with id, profile, contentImage and comment
  factory PostModel.mock() => PostModel(
    id: '1',
    profile: ProfileModel.mock(),
    contentImage: 'https://picsum.photos/900/1600',
    comment: CommentModel.mock(),
  );

  /// From json
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  /// Profile of the post
  final ProfileModel? profile;

  /// Content image of the post
  final String? contentImage;

  /// Comment of the post
  final CommentModel? comment;

  /// Created at of the post
  final DateTime? createdAt;

  /// From json
  @override
  PostModel fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  /// To json
  @override
  Map<String, dynamic> toMap(PostModel model) => _$PostModelToJson(this);
}
