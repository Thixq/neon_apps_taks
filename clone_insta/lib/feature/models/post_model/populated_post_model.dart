part of 'post_models.dart';

/// The populated model for a post, which includes the profile and comment data.
final class PopulatedPostModel extends FirebasePostModel {
  /// The populated model for a post, which includes the profile and comment data.
  const PopulatedPostModel({
    required super.id,
    required this.profile,
    required this.comment,
    required super.createdAt,
    required super.contentImageUrl,
    required super.likeCount,
  });

  factory PopulatedPostModel.mock() => PopulatedPostModel(
    id: 'postId',
    profile: ProfileModel.mock(),
    comment: PopulatedCommentModel.mock(),
    createdAt: DateTime.now(),
    contentImageUrl: 'https://picsum.photos/900/1600',
    likeCount: 42,
  );

  /// The profile associated with the post.
  final ProfileModel profile;

  /// The comment associated with the post.
  final PopulatedCommentModel comment;
}
