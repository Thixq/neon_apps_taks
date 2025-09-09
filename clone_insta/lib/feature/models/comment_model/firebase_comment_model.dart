part of 'comment_models.dart';

/// The model for a comment.
@JsonSerializable()
class FirebaseCommentModel extends BaseModel<FirebaseCommentModel> {
  /// The constructor for the FirebaseCommentModel.
  const FirebaseCommentModel({
    required super.id,
    this.comment,
    this.commentedAt,
    this.userId,
  });

  /// A mock comment.
  factory FirebaseCommentModel.mock() => FirebaseCommentModel(
    id: '1',
    comment: 'Great post!',
    commentedAt: DateTime.now(),
    userId: 'user_1',
  );

  /// The factory for the FirebaseCommentModel.
  factory FirebaseCommentModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseCommentModelFromJson(json);

  /// The text of the comment.
  final String? comment;

  /// The date and time when the comment was made.
  @TimestampNullableConverter()
  final DateTime? commentedAt;

  /// The ID of the user who made the comment.
  final String? userId;

  /// The method to convert the FirebaseCommentModel to a Map.
  @override
  Map<String, dynamic> toJson() => _$FirebaseCommentModelToJson(this);

  /// The method to convert the Map to a FirebaseCommentModel.
  @override
  /*************  ✨ Windsurf Command ⭐  *************/
  /// The method to convert the Map to a FirebaseCommentModel.
  ///
  /// This method is used to convert a Map to a FirebaseCommentModel. The
  /// Map should contain the id, comment, commentedAt, and userId of the
  /// comment.
  /// *****  d1108bc9-6987-4882-a17a-d7049c8bf810  ******
  FirebaseCommentModel fromJson(Map<String, dynamic> json) =>
      _$FirebaseCommentModelFromJson(json);

  @override
  List<Object?> get props => [
    id,
    comment,
    commentedAt,
    userId,
  ];

  @override
  bool? get stringify => true;
}
