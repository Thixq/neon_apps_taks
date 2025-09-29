import 'package:auto_route/auto_route.dart';
import 'package:clone_insta/feature/components/post_card/post_card.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/dialog_and_bottom_sheets/comment_bottom_sheet/comment_bottom_sheet.dart';
import 'package:clone_insta/feature/dialog_and_bottom_sheets/friendship_bottom_sheet/friendship_bottom_sheet.dart';
import 'package:clone_insta/feature/init/dependency_injection/dependency_container.dart';
import 'package:clone_insta/feature/managers/comment_manager.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:clone_insta/feature/models/profile_model.dart';
import 'package:clone_insta/feature/routing/app_router.gr.dart';
import 'package:clone_insta/product/home/feed/feed_view_model/feed_state.dart';
import 'package:clone_insta/product/home/feed/feed_view_model/feed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

part 'feed_mixin.dart';
part 'widget/feed_contents.dart';
part 'widget/feed_app_bar.dart';
part 'widget/shimmer_contens.dart';

@RoutePage()
/// FeedView
class FeedView extends StatefulWidget {
  /// FeedView
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> with _FeedMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _FeedAppBar(
        addPostPressed: _navigateToCreatePost,
        currentUserId: _profileManager.profile!.id,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.small),
        child: BlocBuilder<FeedViewModel, FeedState>(
          builder: (context, state) {
            if (state is FeedLoadingState) {
              return const _ShimmerContents();
            } else if (state is FeedLoadedState) {
              if (state.posts.isEmpty) {
                return const Center(child: Text('No Following Anyone'));
              }
              return _FeedContents(
                posts: state.posts,
                profile: _profileManager.profile,
                commentManager: _commentManager,
              );
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}
