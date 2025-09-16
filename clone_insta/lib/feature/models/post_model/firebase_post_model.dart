// ignore_for_file: public_member_api_docs, sort_constructors_first, document_ignores

part of 'post_models.dart';

/// The Firestore representation of a post.
@JsonSerializable(explicitToJson: true)
final class FirebasePostModel extends BaseModel<FirebasePostModel> {
  const FirebasePostModel({
    required super.id,
    required this.profileId,
    this.contentImageUrl,
    this.caption,
    this.lastCommentId,
    this.likeCount,
    this.createdAt,
  });

  /// Mock post for testing
  factory FirebasePostModel.mock() => FirebasePostModel(
    id: 'post_1',
    profileId: 'user_1',
    contentImageUrl: 'https://picsum.photos/900/1600',
    lastCommentId: 'comment_1',
    caption: 'This is a mock post',
    likeCount: 10,
    createdAt: DateTime.now(),
  );

  factory FirebasePostModel.fromJson(Map<String, dynamic> json) =>
      _$FirebasePostModelFromJson(json);

  /// Author of the post
  final String profileId;

  /// Media of the post (optional)
  final String? contentImageUrl;

  /// Description of the post (optional)
  final String? caption;

  /// Last comment id (optional, denormalized)
  final String? lastCommentId;

  /// Number of likes
  final int? likeCount;

  /// When post was created
  @TimestampNullableConverter()
  final DateTime? createdAt;

  @override
  FirebasePostModel fromJson(Map<String, dynamic> json) =>
      _$FirebasePostModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FirebasePostModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    profileId,
    contentImageUrl,
    caption,
    lastCommentId,
    likeCount,
    createdAt,
  ];

  @override
  bool? get stringify => true;

  FirebasePostModel copyWith({
    String? profileId,
    String? contentImageUrl,
    String? caption,
    String? lastCommentId,
    int? likeCount,
    DateTime? createdAt,
  }) {
    return FirebasePostModel(
      id: id,
      profileId: profileId ?? this.profileId,
      contentImageUrl: contentImageUrl ?? this.contentImageUrl,
      caption: caption ?? this.caption,
      lastCommentId: lastCommentId ?? this.lastCommentId,
      likeCount: likeCount ?? this.likeCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
