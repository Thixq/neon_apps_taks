import 'package:clone_insta/feature/constants/end_point_constant.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:clone_insta/feature/utils/extension/extension_populated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// Manages the display of posts from people the user follows
final class FeedManager {
  /// Constructor
  FeedManager({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// Get the user's feed
  Future<List<PopulatedPostModel>> fetchFeed(String currentUserId) async {
    try {
      // 1. Find the users you follow
      final followingIds = await _fetchFollowingIds(currentUserId);

      if (followingIds.isEmpty) return [];

      // 2. Get posts from followed users
      final posts = await _fetchPostsByAuthors(followingIds);

      // 3. Fill in profile + latest comment
      final populated = await _populatePosts(posts);

      return populated;
    } catch (e, stackTrace) {
      debugPrintStack(label: e.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Get the user's follows
  Future<List<String>> _fetchFollowingIds(String userId) async {
    final snapshot = await _firestore
        .collection(EndPointConstant.relationships)
        .where(
          '${EndPointConstant.sides}.$userId.${EndPointConstant.followStatus}',
          isEqualTo: 'active',
        )
        .get();

    final ids = <String>[];

    for (final doc in snapshot.docs) {
      final sides = doc['sides'] as Map<String, dynamic>;
      for (final entry in sides.entries) {
        if (entry.key != userId) {
          ids.add(entry.key);
        }
      }
    }
    return ids;
  }

  /// Get posts from followed users
  Future<List<FirebasePostModel>> _fetchPostsByAuthors(
    List<String> authorIds,
  ) async {
    // Firestore `whereIn` max 10 ID ile sınırlı
    final snapshot = await _firestore
        .collection(EndPointConstant.posts)
        .where(EndPointConstant.userId, whereIn: authorIds.take(10).toList())
        .orderBy(EndPointConstant.createdAt, descending: true)
        .limit(30)
        .get();

    return snapshot.docs
        .map((e) => FirebasePostModel.fromJson(e.data()))
        .toList();
  }

  /// Populate with profiles and latest comments
  Future<List<PopulatedPostModel>> _populatePosts(
    List<FirebasePostModel> posts,
  ) async {
    final populatedPosts = <PopulatedPostModel>[];

    for (final post in posts) {
      final populatedPost = await post.populateWithProfile(_firestore);

      // 3. Model oluştur
      populatedPosts.add(
        populatedPost,
      );
    }

    return populatedPosts;
  }
}
