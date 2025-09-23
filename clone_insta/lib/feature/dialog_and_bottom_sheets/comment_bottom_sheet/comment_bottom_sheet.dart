import 'package:clone_insta/feature/app_logger.dart';
import 'package:clone_insta/feature/components/profile_avatar.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/extensions/date_time_extension.dart';
import 'package:clone_insta/feature/managers/comment_managar.dart';
import 'package:clone_insta/feature/models/comment_model/comment_models.dart';
import 'package:clone_insta/feature/models/profile_model.dart';
import 'package:flutter/material.dart';

part 'comment_bottom_sheet_mixin.dart';

/// A bottom sheet for adding comments.
/// Use [CommentBottomSheet.show] to display the bottom sheet.
class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet._({
    super.key,
    this.postId,
    this.profile,
    this.manager,
  });

  /// The ID of the post for which comments are being added.
  final String? postId;

  /// The manager for comments.
  final CommentManager? manager;

  /// The ID of the user who is commenting.
  final ProfileModel? profile;

  /// Displays the bottom sheet for adding comments.
  static Future<void> show(
    BuildContext context, {
    String? postId,
    ProfileModel? profile,
    CommentManager? manager,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return CommentBottomSheet._(
          postId: postId,
          profile: profile,
          manager: manager,
        );
      },
    );
  }

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet>
    with _CommentBottomSheetMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.large),
      child: Column(
        spacing: 16,
        children: [
          _buildCommentTextfield(),
          _buildCommets(context),
        ],
      ),
    );
  }

  Expanded _buildCommets(BuildContext context) {
    return Expanded(
      child: localComments.isNotEmpty
          ? ListView.builder(
              itemCount: localComments.length,
              itemBuilder: (context, index) {
                final comment = localComments[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ProfileAvatar(
                    imageUrl: comment.profile?.profileImage,
                    size: AppSizes.extraLarge,
                  ),
                  title: Text(comment.profile?.fullName ?? 'Unknown'),
                  subtitle: Text(
                    '${comment.comment}',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    '${comment.commentedAt?.toRelativeString()}',
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No comments yet',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
    );
  }

  TextField _buildCommentTextfield() {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Add a comment',
      ),
      onSubmitted: _addComment,
    );
  }
}
