import 'package:clone_insta/feature/app_logger.dart';
import 'package:clone_insta/feature/constants/end_point_constant.dart';
import 'package:clone_insta/feature/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// The manager for user profile
final class ProfileManager {
  /// Constructor
  ProfileManager._({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) : _firestore = firestore,
       _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ProfileModel? _profileModel;

  /// The current user profile
  ProfileModel? get profile => _profileModel;

  /// Initializes the ProfileManager with Firestore + Auth
  static Future<ProfileManager> initialize({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) async {
    final manager = ProfileManager._(firestore: firestore, auth: auth);

    try {
      if (auth.currentUser != null) {
        await AppLogger.setUserId(auth.currentUser!.uid);
        AppLogger.log(
          '👤 Initializing profile for user: ${auth.currentUser!.uid}',
        );
        manager._profileModel = await firestore
            .collection(EndPointConstant.users)
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) => ProfileModel.fromJson(value.data()!));

        AppLogger.log(
          '✅ Profile initialized for user: ${auth.currentUser!.uid}',
        );
      } else {
        AppLogger.log('⚠️ No user logged in during initialization');
      }
    } catch (e, stack) {
      AppLogger.error(e, stack, reason: '❌ Error initializing profile manager');
      rethrow;
    }

    return manager;
  }

  /// Sign up with email and password
  Future<void> signUpWithEmailAndPassword({
    required String nickName,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      AppLogger.log('📝 Signing up user with email: $email');

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await AppLogger.setUserId(credential.user!.uid);

      if (credential.user != null) {
        final currentProfile = ProfileModel(
          id: credential.user!.uid,
          email: credential.user!.email,
          fullName: fullName,
          nickName: nickName,
          profileImage: '',
          followers: 0,
          following: 0,
          posts: 0,
        );

        await _auth.currentUser!.updateDisplayName(nickName);

        await _firestore
            .collection(EndPointConstant.users)
            .doc(credential.user!.uid)
            .set(currentProfile.toJson());

        _profileModel = currentProfile;

        AppLogger.log('✅ User signed up successfully: ${credential.user!.uid}');
      }
    } catch (e, stack) {
      AppLogger.error(
        e,
        stack,
        reason: '❌ Profile Manager Sign Up With Email Error ($email)',
      );
      rethrow;
    }
  }

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      AppLogger.log('🔑 Signing in user with email: $email');

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      _profileModel = await _firestore
          .collection(EndPointConstant.users)
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) => ProfileModel.fromJson(value.data()!));
      await AppLogger.setUserId(_auth.currentUser!.uid);
      AppLogger.log('✅ User signed in: ${_auth.currentUser!.uid}');
    } catch (e, stack) {
      AppLogger.error(
        e,
        stack,
        reason: '❌ Profile Manager Sign In Error ($email)',
      );
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      AppLogger.log('🚪 Signing out user: ${_auth.currentUser?.uid}');
      await _auth.signOut();
      _profileModel = null;
      await AppLogger.clearUserId();
      AppLogger.log('✅ User signed out');
    } catch (e, stack) {
      AppLogger.error(e, stack, reason: '❌ Error during sign out');
      rethrow;
    }
  }

  /// Update display name
  Future<void> updateDisplayName(String name) async {
    try {
      AppLogger.log(
        '✏️ Updating display name for user: ${_auth.currentUser?.uid}',
      );

      await _auth.currentUser!.updateDisplayName(name);
      await _firestore
          .collection(EndPointConstant.users)
          .doc(_auth.currentUser!.uid)
          .update({'fullName': name});

      AppLogger.log('✅ Display name updated: $name');
    } catch (e, stack) {
      AppLogger.error(
        e,
        stack,
        reason:
            '❌ Profile Manager Update Display Name Error (${_auth.currentUser?.uid})',
      );
      rethrow;
    }
  }

  /// Update profile image
  Future<void> updateProfileImage(String imageUrl) async {
    try {
      AppLogger.log(
        '🖼 Updating profile image for user: ${_auth.currentUser?.uid}',
      );

      await _auth.currentUser!.updatePhotoURL(imageUrl);
      await _firestore
          .collection(EndPointConstant.users)
          .doc(_auth.currentUser!.uid)
          .update({'profileImage': imageUrl});

      AppLogger.log('✅ Profile image updated: $imageUrl');
    } catch (e, stack) {
      AppLogger.error(
        e,
        stack,
        reason:
            '❌ Profile Manager Update Profile Image Error (${_auth.currentUser?.uid})',
      );
      rethrow;
    }
  }

  /// Update nick name
  Future<void> updateNickName(String nickName) async {
    try {
      AppLogger.log('✏️ Updating nickname for user: ${_auth.currentUser?.uid}');

      await _firestore
          .collection(EndPointConstant.users)
          .doc(_auth.currentUser!.uid)
          .update({'nickName': nickName});

      AppLogger.log('✅ Nickname updated: $nickName');
    } catch (e, stack) {
      AppLogger.error(
        e,
        stack,
        reason:
            '❌ Profile Manager Update Nickname Error (${_auth.currentUser?.uid})',
      );
      rethrow;
    }
  }
}
