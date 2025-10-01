import 'package:clone_insta/feature/managers/post_manager.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/feature/managers/relationship_manager.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:clone_insta/feature/utils/extension/extension_populated.dart';
import 'package:clone_insta/product/home/profile/view_model/profile_view_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The profile view model
final class ProfileViewModel extends Cubit<ProfileViewState> {
  /// Constructor
  ProfileViewModel({
    required ProfileManager profileManager,
    required PostManager postManager,
    required FirebaseFirestore firestoreService,
    required RelationshipManager relationshipManager,
  }) : _profileManager = profileManager,
       _postManager = postManager,
       _firestoreService = firestoreService,
       _relationshipManager = relationshipManager,
       super(
         const ProfileViewState(
           postsState: ProfileViewPostStateInitial(),
           profileState: ProfileViewContentStateInitial(),
         ),
       );

  final ProfileManager _profileManager;
  final PostManager _postManager;
  final FirebaseFirestore _firestoreService;
  final RelationshipManager _relationshipManager;

  /// User get posts
  Future<void> getPosts() async {
    emit(state.copyWith(postsState: const ProfileViewPostStateLoading()));
    final rawPosts = await _postManager.getUserPosts(
      _profileManager.profile!.id,
    );
    final populetedPosts = <PopulatedPostModel?>[];
    for (final post in rawPosts) {
      final populated = await post?.populateWithProfile(_firestoreService);
      populetedPosts.add(populated);
    }
    final oldPosts = (state.postsState is ProfileViewPostStateLoaded)
        ? (state.postsState as ProfileViewPostStateLoaded).posts
        : null;
    emit(
      state.copyWith(
        postsState: ProfileViewPostStateLoaded(
          posts: [...?oldPosts, ...populetedPosts],
        ),
      ),
    );
  }

  /// Get followers and following
  Future<void> getStatus() async {
    emit(state.copyWith(profileState: const ProfileViewContentStateLoading()));
    final followers = await _relationshipManager.getFollowers(
      _profileManager.profile!.id,
    );
    final following = await _relationshipManager.getFollowing(
      _profileManager.profile!.id,
    );
    emit(
      state.copyWith(
        profileState: ProfileViewContentStateLoaded(
          followers: followers.length,
          following: following.length,
        ),
      ),
    );
  }
}
