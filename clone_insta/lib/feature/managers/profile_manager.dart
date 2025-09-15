import 'package:clone_insta/feature/constants/end_point_constant.dart';
import 'package:clone_insta/feature/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  /// The class that manages user profile operations.
  /// This class handles user authentication with Firebase Auth and
  /// manages user profile data with Firestore.
  static Future<ProfileManager> initialize({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) async {
    ProfileManager._(firestore: firestore, auth: auth);
    final manager = ProfileManager._(firestore: firestore, auth: auth);

    // Mevcut kullanıcı varsa, profil verisini çekiyoruz.
    if (auth.currentUser != null) {
      manager._profileModel = await firestore
          .collection(EndPointConstant.users)
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) => ProfileModel.fromJson(value.data()!));
    }
    // Tamamen başlatılmış nesneyi döndürüyoruz.
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
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
            .set(
              currentProfile.toJson(),
            );
        _profileModel = currentProfile;
      }
    } catch (e, stackTrace) {
      debugPrintStack(
        label: 'Profile Manager Sign Up With Email Error: $e',
        stackTrace: stackTrace,
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
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _profileModel = await _firestore
          .collection(EndPointConstant.users)
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) => ProfileModel.fromJson(value.data()!));
    } catch (e, stackTrace) {
      debugPrintStack(
        label: 'Profile Manager Sign In With Email Error: $e',
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Update display name
  Future<void> updateDisplayName(String name) async {
    try {
      await _auth.currentUser!.updateDisplayName(name);
      await _firestore
          .collection(EndPointConstant.users)
          .doc(_auth.currentUser!.uid)
          .update(
            {'fullName': name},
          );
    } catch (e, stackTrace) {
      debugPrintStack(
        label: 'Profile Manager Update Display Name Error: $e',
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Update profile image
  Future<void> updateProfileImage(String imageUrl) async {
    try {
      await _auth.currentUser!.updatePhotoURL(imageUrl);
      await _firestore
          .collection(EndPointConstant.users)
          .doc(_auth.currentUser!.uid)
          .update(
            {'profileImage': imageUrl},
          );
    } catch (e, stackTrace) {
      debugPrintStack(
        label: 'Profile Manager Update Profile Image Error: $e',
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Update nick name
  Future<void> updateNickName(String nickName) async {
    await _firestore
        .collection(EndPointConstant.users)
        .doc(_auth.currentUser!.uid)
        .update({'nickName': nickName});
  }
}
