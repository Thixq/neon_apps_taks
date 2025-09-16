part of 'post_models.dart';

/// A post populated with profile and last comment data.
final class PopulatedPostModel extends FirebasePostModel {
  /// Creates a populated post model.
  const PopulatedPostModel({
    required super.id,
    required super.profileId,
    required this.profile,
    super.contentImageUrl,
    super.caption,
    super.lastCommentId,
    super.likeCount,
    super.createdAt,
    this.lastComment,
  });

  /// Mock populated post
  factory PopulatedPostModel.mock() => PopulatedPostModel(
    id: 'postId',
    profileId: 'user_1',
    profile: ProfileModel.mock(),
    lastComment: PopulatedCommentModel.mock(),
    contentImageUrl: 'https://picsum.photos/900/1600',
    caption: 'This is a mock populated post',
    likeCount: 42,
    createdAt: DateTime.now(),
  );

  /// The profile associated with the post.
  final ProfileModel profile;

  /// The last (or highlighted) comment associated with the post.
  final PopulatedCommentModel? lastComment;

  @override
  List<Object?> get props => [
    ...super.props,
    profile,
    lastComment,
  ];
}
