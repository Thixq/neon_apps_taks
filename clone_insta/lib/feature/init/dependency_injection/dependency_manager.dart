import 'package:clone_insta/feature/init/firebase_remote_config.dart';
import 'package:clone_insta/feature/managers/comment_managar.dart';
import 'package:clone_insta/feature/managers/feed_manager.dart';
import 'package:clone_insta/feature/managers/post_manager.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

/// Dependency manager
final class DependencyManager {
  DependencyManager._init();

  /// Singleton
  static final instance = DependencyManager._init();

  static final GetIt _getIt = GetIt.instance;

  /// Initialize dependency injection
  Future<void> initialize() async {
    await _configure();
    await _getIt.allReady();
  }

  Future<void> _configure() async {
    _getIt
      ..registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance)
      ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
      ..registerSingletonAsync<ProfileManager>(
        () async {
          final manager = await ProfileManager.initialize(
            firestore: _getIt.get<FirebaseFirestore>(),
            auth: _getIt.get<FirebaseAuth>(),
          );
          return manager;
        },
      )
      ..registerSingletonAsync<FeedManager>(
        () async => FeedManager(firestore: _getIt.get<FirebaseFirestore>()),
      )
      ..registerSingletonAsync(
        () async => PostManager(firestore: _getIt.get<FirebaseFirestore>()),
      )
      ..registerSingletonAsync(
        () async => CommentManager(
          firestore: _getIt.get<FirebaseFirestore>(),
        ),
      )
      ..registerSingletonAsync<CloneInstaConfig>(
        () async {
          final config = CloneInstaConfig.instance;
          await config.initialize();
          return config;
        },
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
