import 'package:clone_insta/feature/init/firebase_remote_config.dart';
import 'package:clone_insta/feature/managers/comment_manager.dart';
import 'package:clone_insta/feature/managers/feed_manager.dart';
import 'package:clone_insta/feature/managers/file_manager.dart';
import 'package:clone_insta/feature/managers/post_manager.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/feature/managers/relationship_manager.dart';
import 'package:clone_insta/feature/managers/users_manager.dart';
import 'package:clone_insta/feature/orchestration/friendship_orchestration.dart';
import 'package:clone_insta/feature/services/image_picker_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hl_image_picker_ios/hl_image_picker_ios.dart';

/// Dependency manager
final class DependencyManager {
  DependencyManager._init();

  /// Singleton
  static final instance = DependencyManager._init();

  static final GetIt _getIt = GetIt.instance;

  /// Initialize dependency injection
  Future<void> initialize() async {
    await _serviceConfigure();
    await _managerConfigure();
    await _orchestrationConfigure();
    await _getIt.allReady();
  }

  Future<void> _managerConfigure() async {
    _getIt
      ..registerSingletonAsync<ProfileManager>(
        () async {
          final manager = await ProfileManager.initialize(
            firestore: _getIt.get<FirebaseFirestore>(),
            auth: _getIt.get<FirebaseAuth>(),
          );
          return manager;
        },
      )
      ..registerSingletonAsync<CloneInstaConfig>(
        () async {
          final config = CloneInstaConfig.instance;
          await config.initialize();
          return config;
        },
      )
      ..registerSingleton<FeedManager>(
        FeedManager(firestore: _getIt.get<FirebaseFirestore>()),
      )
      ..registerSingleton<PostManager>(
        PostManager(firestore: _getIt.get<FirebaseFirestore>()),
      )
      ..registerSingleton<CommentManager>(
        CommentManager(
          firestore: _getIt.get<FirebaseFirestore>(),
        ),
      )
      ..registerSingleton<UsersManager>(
        UsersManager(firestore: _getIt.get<FirebaseFirestore>()),
      )
      ..registerSingleton<RelationshipManager>(
        RelationshipManager(
          firestore: _getIt.get<FirebaseFirestore>(),
        ),
      )
      ..registerSingleton<FileManager>(
        FileManager(firebaseStorage: _getIt.get<FirebaseStorage>()),
      );
  }

  Future<void> _serviceConfigure() async {
    _getIt
      ..registerSingleton<ImagePickerService>(
        ImagePickerService(picker: HLImagePickerIOS()),
      )
      ..registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance)
      ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
      ..registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  }

  Future<void> _orchestrationConfigure() async {
    _getIt.registerSingleton<FriendshipOrchestration>(
      FriendshipOrchestration(
        usersManager: _getIt.get<UsersManager>(),
        relationshipManager: _getIt.get<RelationshipManager>(),
      ),
    );
  }

  /// Get dependency
  static T read<T extends Object>() => _getIt<T>();

  /// Maybe get dependency
  static T? maybeRead<T extends Object>() =>
      _getIt.isRegistered<T>() ? _getIt<T>() : null;

  /// Get dependency async
  static Future<T> readAsync<T extends Object>() => _getIt.getAsync<T>();
}
