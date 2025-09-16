import 'package:clone_insta/feature/models/comment_model/comment_models.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:clone_insta/feature/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Extensions for populating a [FirebaseCommentModel] or [FirebasePostModel] with a user profile.
extension FirebaseCommentModelX on FirebaseCommentModel {
  /// Populates a [FirebaseCommentModel] with the user profile.
  Future<PopulatedCommentModel> populateWithProfile(
    FirebaseFirestore firestore,
  ) async {
    if (userId == null) {
      throw Exception('userId is null, cannot populate profile.');
    }

    final userDoc = await firestore.collection('users').doc(userId).get();

    if (!userDoc.exists) {
      throw Exception('User not found for id $userId');
    }

    final profile = ProfileModel.fromJson(userDoc.data()!..['id'] = userDoc.id);

    return PopulatedCommentModel(
      id: id,
      profile: profile,
      comment: comment,
      commentedAt: commentedAt,
    );
  }
}

/// Extensions for populating a [FirebaseCommentModel] or [FirebasePostModel] with a user profile.
extension FirebasePostModelX on FirebasePostModel {
  /// Populates a [FirebasePostModel] with the user profile.
  Future<PopulatedPostModel> populateWithProfile(
    FirebaseFirestore firestore,
  ) async {
    final userDoc = await firestore.collection('users').doc(userId).get();

    if (!userDoc.exists) {
      throw Exception('User not found for id $userDoc');
    }

    final profile = ProfileModel.fromJson(userDoc.data()!..['id'] = userDoc.id);

    PopulatedCommentModel? lastCommentPopulated;

    if (lastCommentId != null) {
      final lastCommentDoc = await firestore
          .collection('posts')
          .doc(id)
          .collection('comments')
          .doc(lastCommentId)
          .get();
      lastCommentPopulated = await FirebaseCommentModel.fromJson(
        lastCommentDoc.data()!,
      ).populateWithProfile(firestore);
    }

    return PopulatedPostModel(
      id: id,
      profile: profile,
      userId: userId,
      caption: caption,
      createdAt: createdAt,
      likeCount: likeCount,
      contentImageUrl: contentImageUrl,
      lastComment: lastCommentPopulated,
    );
  }
}
