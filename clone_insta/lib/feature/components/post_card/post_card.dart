// ignore_for_file: public_member_api_docs, document_ignores

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_insta/feature/components/profile_avatar.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/extensions/context_theme_extension.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:clone_insta/feature/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

part 'action_bar.dart';
part 'action_item.dart';
part 'content.dart';
part 'content_info.dart';
part 'info_bar.dart';

/// A card that represents a post.
final class PostCard extends StatelessWidget {
  /// [post] is the post that this widget represents.
  const PostCard({
    this.morePressed,
    this.profilePressed,
    this.favPressed,
    this.commentPressed,
    this.bookmarkPressed,
    this.post,
    super.key,
  });

  /// The post that this widget represents.
  final PopulatedPostModel? post;

  final VoidCallback? morePressed;
  final VoidCallback? profilePressed;
  final VoidCallback? favPressed;
  final VoidCallback? commentPressed;
  final VoidCallback? bookmarkPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildInfoBar(context),
        _buildContent(context),
        _buildActions(context),
        _buildContenInfo(),
      ],
    );
  }

  /// Builds the info bar at the top of the post.
  Widget _buildInfoBar(BuildContext context) {
    return _InfoBar(
      onMorePressed: morePressed,
      onProfilePressed: profilePressed,
      profile: post?.profile,
    );
  }

  /// Builds the content of the post.
  Widget _buildContent(BuildContext context) {
    return _Content(
      contentImage: post?.contentImageUrl,
    );
  }

  /// Builds the actions at the bottom of the post.
  Widget _buildActions(BuildContext context) {
    return _ActionBar(
      prefixActions: [
        _ActionItem(
          selectedIcon: const Icon(Icons.favorite, color: Colors.red),
          unselectedIcon: const Icon(Icons.favorite_border),
          onPressed: favPressed,
        ),
        _ActionItem(icon: const Icon(Icons.comment), onPressed: commentPressed),
      ],
      suffixActions: [
        _ActionItem(
          selectedIcon: const Icon(Icons.bookmark),
          unselectedIcon: const Icon(Icons.bookmark_border),
          onPressed: bookmarkPressed,
        ),
      ],
    );
  }

  /// Builds the content information at the bottom of the post.
  Widget _buildContenInfo() {
    return _ContentInfo(
      likeCount: post?.likeCount,
      byLastComment: post?.comment.profile.fullName,
      lastComment: post?.comment.comment,
      contentDescription: post?.contentDescription,
    );
  }
}
