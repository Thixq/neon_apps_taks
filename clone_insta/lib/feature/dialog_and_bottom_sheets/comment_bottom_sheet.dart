import 'package:clone_insta/feature/components/profile_avatar.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/extensions/date_time_extension.dart';
import 'package:clone_insta/feature/models/comment_model/comment_models.dart';
import 'package:flutter/material.dart';

/// A bottom sheet for adding comments.
/// Use [CommentBottomSheet.show] to display the bottom sheet.

class CommentBottomSheet {
  const CommentBottomSheet._();

  /// Displays the bottom sheet.
  /// Use [context] to show the bottom sheet in the correct place.
  static Future<void> show(
    BuildContext context, {
    List<PopulatedCommentModel>? comments,
    void Function(String)? onSubmitted,
  }) async {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final controller = TextEditingController();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.large),
          child: Column(
            spacing: 16,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Add a comment',
                ),
                onSubmitted: (value) {
                  onSubmitted?.call(value);
                  controller.clear();
                },
              ),
              Expanded(
                child: comments != null
                    ? ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const ProfileAvatar(
                              imageUrl: 'https://picsum.photos/200',
                              size: AppSizes.extraLarge,
                            ),
                            title: Text('${comment.profile.fullName}'),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
