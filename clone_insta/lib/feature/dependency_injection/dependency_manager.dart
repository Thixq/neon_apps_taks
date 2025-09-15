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
      ..registerSingletonAsync<FirebaseFirestore>(
        () async => FirebaseFirestore.instance,
      )
      ..registerSingletonAsync<FirebaseAuth>(() async => FirebaseAuth.instance)
      ..registerLazySingletonAsync(() async {
        final manager = await ProfileManager.initialize(
          firestore: _getIt<FirebaseFirestore>(),
          auth: _getIt<FirebaseAuth>(),
        );
        return manager;
      });
  }

  /// Get dependency
  static T read<T extends Object>() => _getIt<T>();
}
