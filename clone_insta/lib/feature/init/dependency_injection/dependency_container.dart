import 'package:clone_insta/feature/init/dependency_injection/dependency_manager.dart';
import 'package:clone_insta/feature/init/firebase_remote_config.dart';
import 'package:clone_insta/feature/managers/comment_manager.dart';
import 'package:clone_insta/feature/managers/feed_manager.dart';
import 'package:clone_insta/feature/managers/file_manager.dart';
import 'package:clone_insta/feature/managers/notification_manager.dart';
import 'package:clone_insta/feature/managers/notification_token_manager.dart';
import 'package:clone_insta/feature/managers/post_manager.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/feature/managers/relationship_manager.dart';
import 'package:clone_insta/feature/managers/users_manager.dart';
import 'package:clone_insta/feature/orchestration/friendship_orchestration.dart';
import 'package:clone_insta/feature/services/image_picker_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Dependency container
final class DependencyContainer {
  DependencyContainer._();

  /// Services
  static DependencyContainerService get service =>
      DependencyContainerService._();

  /// Managers
  static DependencyContainerManager get manager =>
      DependencyContainerManager._();

  /// Orchestration
  static DependencyContainerOrchestration get orchestration =>
      DependencyContainerOrchestration._();
}

/// Dependency container service
final class DependencyContainerService {
  DependencyContainerService._();

  /// auth
  FirebaseAuth get auth => DependencyManager.read<FirebaseAuth>();

  /// firestore
  FirebaseFirestore get firestore =>
      DependencyManager.read<FirebaseFirestore>();

  /// storage
  FirebaseStorage get storage => DependencyManager.read<FirebaseStorage>();

  /// image picker
  ImagePickerService get imagePickerService =>
      DependencyManager.read<ImagePickerService>();
}

/// Dependency container manager
final class DependencyContainerManager {
  DependencyContainerManager._();

  /// ProfileManager
  ProfileManager get profileManager => DependencyManager.read<ProfileManager>();

  /// FeedManager
  FeedManager get feedManager => DependencyManager.read<FeedManager>();

  /// PostManager
  PostManager get postManager => DependencyManager.read<PostManager>();

  /// CommentManager
  CommentManager get commentManager => DependencyManager.read<CommentManager>();

  /// UsersManager
  UsersManager get usersManager => DependencyManager.read<UsersManager>();

  /// FirebaseRemoteConfig
  CloneInstaConfig get firebaseRemoteConfig =>
      DependencyManager.read<CloneInstaConfig>();

  /// FileManager
  FileManager get fileManager => DependencyManager.read<FileManager>();

  /// NotificationTokenManager
  NotificationTokenManager get notificationTokenManager =>
      DependencyManager.read<NotificationTokenManager>();

  /// NotificationManager
  FCMManager get fcmManager => DependencyManager.read<FCMManager>();

  /// RelationshipManager
  RelationshipManager get relationshipManager =>
      DependencyManager.read<RelationshipManager>();
}

/// Dependency container orchestration
final class DependencyContainerOrchestration {
  DependencyContainerOrchestration._();

  /// FriendshipOrchestration
  FriendshipOrchestration get friendshipOrchestration =>
      DependencyManager.read<FriendshipOrchestration>();
}
