part of 'post_models.dart';

/// The model for a post.
@JsonSerializable(explicitToJson: true)
class FirebasePostModel extends BaseModel<FirebasePostModel> {
  /// Constructor
  const FirebasePostModel({
    required super.id,
    this.profileId,
    this.likeCount,
    this.contentImageUrl,
    this.contentDescription,
    this.lastCommentId,
    this.createdAt,
  });

  /// This method returns a mock post model with id, profile, contentImage and comment
  factory FirebasePostModel.mock() => const FirebasePostModel(
    id: '1',
    profileId: 'user_1',
    contentImageUrl: 'https://picsum.photos/900/1600',
    lastCommentId: 'comment_1',
  );

  /// From json
  factory FirebasePostModel.fromJson(Map<String, dynamic> json) =>
      _$FirebasePostModelFromJson(json);

  /// Profile of the post
  final String? profileId;

  /// Content image of the post
  final String? contentImageUrl;

  /// Description of the post
  final String? contentDescription;

  /// Comment of the post
  final String? lastCommentId;

  /// Number of likes
  final int? likeCount;

  /// Created at of the post
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
    lastCommentId,
    likeCount,
    createdAt,
  ];

  @override
  bool? get stringify => true;
}
