import 'package:clone_insta/feature/models/base_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

/// The model for a comment.
@JsonSerializable()
final class CommentModel extends BaseModel<CommentModel> {
  /// The constructor for the CommentModel.
  const CommentModel({
    required super.id,
    required this.likeCount,
    required this.byLastComment,
    required this.lastComment,
  });

  /// A mock comment.
  factory CommentModel.mock() => CommentModel(
    id: '1',
    likeCount: '123',
    byLastComment: 'Kaan',
    lastComment: 'bla bla ' * 24,
  );

  /// The factory for the CommentModel.
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  /// The number of likes the comment has.
  final String likeCount;

  /// The username of the user who made the last comment.
  final String byLastComment;

  /// The text of the last comment.
  final String lastComment;

  /// The method to convert the CommentModel to a Map.
  @override
  Map<String, dynamic> toMap(CommentModel model) => _$CommentModelToJson(model);

  /// The method to convert the Map to a CommentModel.
  @override
  CommentModel fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
