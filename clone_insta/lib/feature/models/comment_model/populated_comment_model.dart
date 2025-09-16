part of 'comment_models.dart';

/// The populated model for a comment, which includes the profile data.
final class PopulatedCommentModel extends FirebaseCommentModel {
  /// The populated model for a comment, which includes the profile data.
  const PopulatedCommentModel({
    required super.id,
    this.profile,
    super.comment,
    super.commentedAt,
  });

  /// Creates a mock populated comment model.
  factory PopulatedCommentModel.mock() => PopulatedCommentModel(
    id: 'commentId',
    profile: ProfileModel.mock(),
    comment: 'This is a sample comment.',
    commentedAt: DateTime.now(),
  );

  /// The profile data for the user who made the comment.
  final ProfileModel? profile;
}
