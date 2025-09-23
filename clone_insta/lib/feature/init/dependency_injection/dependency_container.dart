import 'package:clone_insta/feature/init/dependency_injection/dependency_manager.dart';
import 'package:clone_insta/feature/init/firebase_remote_config.dart';
import 'package:clone_insta/feature/managers/comment_managar.dart';
import 'package:clone_insta/feature/managers/feed_manager.dart';
import 'package:clone_insta/feature/managers/post_manager.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Dependency container
final class DependencyContainer {
  DependencyContainer._();

  /// auth
  static final FirebaseAuth auth = DependencyManager.read<FirebaseAuth>();

  /// firestore
  static final FirebaseFirestore firestore =
      DependencyManager.read<FirebaseFirestore>();

  /// ProfileManager
  static final ProfileManager profileManager =
      DependencyManager.read<ProfileManager>();

  /// FeedManager
  static final FeedManager feedManager = DependencyManager.read<FeedManager>();

  /// PostManager
  static final PostManager postManager = DependencyManager.read<PostManager>();

  /// CommentManager
  static final CommentManager commentManager =
      DependencyManager.read<CommentManager>();

  /// FirebaseRemoteConfig
  static final CloneInstaConfig firebaseRemoteConfig =
      DependencyManager.read<CloneInstaConfig>();
}
