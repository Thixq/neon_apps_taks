part of 'comment_models.dart';

/// The populated model for a comment, which includes the profile data.
final class PopulatedCommentModel extends FirebaseCommentModel {
  /// The populated model for a comment, which includes the profile data.
  const PopulatedCommentModel({
    required super.id,
    required this.profile,
    required super.comment,
    required super.commentedAt,
    required super.userId,
  });

  /// Creates a mock populated comment model.
  factory PopulatedCommentModel.mock() => PopulatedCommentModel(
    id: 'commentId',
    profile: ProfileModel.mock(),
    comment: 'This is a sample comment.',
    commentedAt: DateTime.now(),
    userId: 'userId',
  );

  /// The profile data for the user who made the comment.
  final ProfileModel profile;
}
