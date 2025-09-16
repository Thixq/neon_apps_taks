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
    required super.caption,
  });

  /// This method returns a mock populated post model with id, profile, contentImage and comment
  factory PopulatedPostModel.mock() => PopulatedPostModel(
    id: 'postId',
    profile: ProfileModel.mock(),
    comment: PopulatedCommentModel.mock(),
    createdAt: DateTime.now(),
    contentImageUrl: 'https://picsum.photos/900/1600',
    likeCount: 42,
    caption:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  );

  /// The profile associated with the post.
  final ProfileModel profile;

  /// The comment associated with the post.
  final PopulatedCommentModel comment;
}
