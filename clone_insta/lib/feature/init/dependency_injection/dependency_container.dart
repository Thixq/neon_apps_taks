import 'package:clone_insta/feature/init/dependency_injection/dependency_manager.dart';
import 'package:clone_insta/feature/init/firebase_remote_config.dart';
import 'package:clone_insta/feature/managers/comment_managar.dart';
import 'package:clone_insta/feature/managers/feed_manager.dart';
import 'package:clone_insta/feature/managers/post_manager.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/feature/services/image_picker_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Dependency container
final class DependencyContainer {
  DependencyContainer._();

  // --- services ---

  /// auth
  static final FirebaseAuth auth = DependencyManager.read<FirebaseAuth>();

  /// firestore
  static final FirebaseFirestore firestore =
      DependencyManager.read<FirebaseFirestore>();

  /// storage
  static final FirebaseStorage storage =
      DependencyManager.read<FirebaseStorage>();

  /// image picker
  static final ImagePickerService imagePickerService =
      DependencyManager.read<ImagePickerService>();

  // // --- managers ---

  // /// ProfileManager
  // static final ProfileManager profileManager =
  //     DependencyManager.read<ProfileManager>();

  // /// FeedManager
  // static final FeedManager feedManager = DependencyManager.read<FeedManager>();

  // /// PostManager
  // static final PostManager postManager = DependencyManager.read<PostManager>();

  // /// CommentManager
  // static final CommentManager commentManager =
  //     DependencyManager.read<CommentManager>();

  // /// FirebaseRemoteConfig
  // static final CloneInstaConfig firebaseRemoteConfig =
  //     DependencyManager.read<CloneInstaConfig>();

  static DependencyContainerManager get manager =>
      DependencyContainerManager._();

  static DependencyContainerService get service =>
      DependencyContainerService._();
}

final class DependencyContainerService {
  DependencyContainerService._();

  /// auth
  final FirebaseAuth auth = DependencyManager.read<FirebaseAuth>();

  /// firestore
  final FirebaseFirestore firestore =
      DependencyManager.read<FirebaseFirestore>();

  /// storage
  final FirebaseStorage storage = DependencyManager.read<FirebaseStorage>();

  /// image picker
  final ImagePickerService imagePickerService =
      DependencyManager.read<ImagePickerService>();
}

/// Dependency container manager
final class DependencyContainerManager {
  DependencyContainerManager._();

  final ProfileManager profileManager =
      DependencyManager.read<ProfileManager>();

  /// FeedManager
  final FeedManager feedManager = DependencyManager.read<FeedManager>();

  /// PostManager
  final PostManager postManager = DependencyManager.read<PostManager>();

  /// CommentManager
  final CommentManager commentManager =
      DependencyManager.read<CommentManager>();

  /// FirebaseRemoteConfig
  final CloneInstaConfig firebaseRemoteConfig =
      DependencyManager.read<CloneInstaConfig>();
}
