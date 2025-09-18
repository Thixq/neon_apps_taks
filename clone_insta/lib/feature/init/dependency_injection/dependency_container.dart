import 'package:clone_insta/feature/init/dependency_injection/dependency_manager.dart';
import 'package:clone_insta/feature/init/firebase_remote_config.dart';
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

  /// FirebaseRemoteConfig
  static final CloneInstaConfig firebaseRemoteConfig =
      DependencyManager.read<CloneInstaConfig>();
}
