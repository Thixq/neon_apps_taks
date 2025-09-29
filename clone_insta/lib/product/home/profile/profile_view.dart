import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_insta/feature/components/profile_avatar.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/extensions/context_theme_extension.dart';
import 'package:clone_insta/feature/extensions/num_extension.dart';
import 'package:clone_insta/feature/init/dependency_injection/dependency_container.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:clone_insta/feature/routing/app_router.gr.dart';
import 'package:clone_insta/product/home/profile/view_model/profile_view_model.dart';
import 'package:clone_insta/product/home/profile/view_model/profile_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_mixin.dart';
part 'widgets/profile_info.dart';
part 'widgets/profile_content.dart';
part 'widgets/content_grid.dart';

@RoutePage()
/// ProfileView
class ProfileView extends StatefulWidget {
  /// ProfileView
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with _ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async => _signOut(context),
            icon: const Icon(Icons.logout),
          ),
        ],
        title: Text(user.profile?.nickName ?? 'null'),
      ),
      body: Column(
        children: [
          _buildProfileInfo(),
          _buildContent(),
        ],
      ),
    );
  }

  Expanded _buildContent() {
    return Expanded(
      child: BlocBuilder<ProfileViewModel, ProfileViewState>(
        builder: (context, state) {
          return _ProfileContent(
            postsLoading: state.postsState is ProfileViewPostStateLoading,
            posts: (state.postsState is ProfileViewPostStateLoaded)
                ? (state.postsState as ProfileViewPostStateLoaded).posts
                : [],
          );
        },
      ),
    );
  }

  BlocBuilder<ProfileViewModel, ProfileViewState> _buildProfileInfo() {
    return BlocBuilder<ProfileViewModel, ProfileViewState>(
      builder: (context, state) {
        return _ProfileInfo(
          profileImage: user.profile?.profileImage,
          fullName: user.profile?.fullName,
          followers: state.profileState is ProfileViewContentStateLoaded
              ? (state.profileState as ProfileViewContentStateLoaded).followers
              : 0,
          following: state.profileState is ProfileViewContentStateLoaded
              ? (state.profileState as ProfileViewContentStateLoaded).following
              : 0,
          posts: state.postsState is ProfileViewPostStateLoaded
              ? (state.postsState as ProfileViewPostStateLoaded).posts?.length
              : null,
        );
      },
    );
  }
}
