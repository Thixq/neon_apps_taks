import 'package:clone_insta/feature/managers/post_manager.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:clone_insta/feature/utils/extension/extension_populated.dart';
import 'package:clone_insta/product/home/profile/view_model/profile_view_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ProfileViewModel extends Cubit<ProfileViewState> {
  ProfileViewModel({
    required ProfileManager profileManager,
    required PostManager postManager,
    required FirebaseFirestore firestoreService,
  }) : _profileManager = profileManager,
       _postManager = postManager,
       _firestoreService = firestoreService,
       super(const ProfileViewState(postsState: ProfileViewPostStateInitial()));

  final ProfileManager _profileManager;
  final PostManager _postManager;
  final FirebaseFirestore _firestoreService;

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
}
