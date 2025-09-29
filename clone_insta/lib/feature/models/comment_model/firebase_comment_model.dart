// ignore_for_file: public_member_api_docs, sort_constructors_first, document_ignores
part of 'comment_models.dart';

/// The model for a comment.
@JsonSerializable()
final class FirebaseCommentModel extends BaseModel<FirebaseCommentModel> {
  /// The constructor for the FirebaseCommentModel.
  const FirebaseCommentModel({
    required super.id,
    this.comment,
    this.createdAt,
    this.userId,
  });

  /// A mock comment.
  factory FirebaseCommentModel.mock() => FirebaseCommentModel(
    id: '1',
    comment: 'Great post!',
    createdAt: DateTime.now(),
    userId: 'user_1',
  );

  /// The factory for the FirebaseCommentModel.
  factory FirebaseCommentModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseCommentModelFromJson(json);

  /// The text of the comment.
  final String? comment;

  /// The date and time when the comment was made.
  @TimestampNullableConverter()
  final DateTime? createdAt;

  /// The ID of the user who made the comment.
  final String? userId;

  /// The method to convert the FirebaseCommentModel to a Map.
  @override
  Map<String, dynamic> toJson() => _$FirebaseCommentModelToJson(this);

  /// The method to convert the Map to a FirebaseCommentModel.
  @override
  FirebaseCommentModel fromJson(Map<String, dynamic> json) =>
      _$FirebaseCommentModelFromJson(json);

  @override
  List<Object?> get props => [
    id,
    comment,
    createdAt,
    userId,
  ];

  @override
  bool? get stringify => true;

  FirebaseCommentModel copyWith({
    String? id,
    String? comment,
    DateTime? createdAt,
    String? userId,
  }) {
    return FirebaseCommentModel(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? createdAt,
      userId: userId ?? this.userId,
    );
  }
}
