import 'package:clone_insta/feature/app_logger.dart';
import 'package:clone_insta/feature/constants/end_point_constant.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:clone_insta/feature/utils/enums/relationship_enums.dart';
import 'package:clone_insta/feature/utils/extension/extension_populated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      AppLogger.log('📥 Fetching feed for user: $currentUserId');

      // 1. Find the users you follow
      final followingIds = await _fetchFollowingIds(currentUserId);

      if (followingIds.isEmpty) {
        AppLogger.log('⚠️ No following users found for $currentUserId');
        return [];
      }

      // 2. Get posts from followed users
      final posts = await _fetchPostsByAuthors(followingIds);

      // 3. Fill in profile + latest comment
      final populated = await _populatePosts(posts);

      AppLogger.log('✅ Feed fetched successfully for $currentUserId');
      return populated;
    } catch (e, stackTrace) {
      AppLogger.error(
        e,
        stackTrace,
        reason: '❌ Error fetching feed for user $currentUserId',
      );
      rethrow;
    }
  }

  /// Get the user's follows
  Future<List<String>> _fetchFollowingIds(String userId) async {
    try {
      AppLogger.log('👥 Fetching following IDs for user: $userId');
      final snapshot = await _firestore
          .collectionGroup(EndPointConstant.sides)
          .where('id', isEqualTo: userId)
          .where('followStatus', isEqualTo: 'active')
          .get();
      final ids = <String>[];

      for (final doc in snapshot.docs) {
        if (doc.id == userId) {
          final relationshipDocRef = doc.reference.parent.parent;

          if (relationshipDocRef != null) {
            final relationshipSnap = await relationshipDocRef.get();
            final users = List<String>.from(
              relationshipSnap['users'] as List<dynamic>,
            );

            // ilişki dokümanındaki diğer userId'yi bul
            for (final id in users) {
              if (id != userId) {
                ids.add(id);
              }
            }
          }
        }
      }

      AppLogger.log('📌 Found ${ids.length} following IDs for user: $userId');
      return ids;
    } catch (e, stackTrace) {
      AppLogger.error(
        e,
        stackTrace,
        reason: '❌ Error fetching following IDs for user $userId',
      );
      rethrow;
    }
  }

  /// Get posts from followed users
  Future<List<FirebasePostModel>> _fetchPostsByAuthors(
    List<String> authorIds,
  ) async {
    try {
      AppLogger.log("📝 Fetching posts for authors: ${authorIds.join(", ")}");

      // Firestore `whereIn` max 10 ID ile sınırlı
      final snapshot = await _firestore
          .collection(EndPointConstant.posts)
          .where(EndPointConstant.userId, whereIn: authorIds.take(10).toList())
          .orderBy(EndPointConstant.createdAt, descending: true)
          .limit(30)
          .get();

      final posts = snapshot.docs
          .map((e) => FirebasePostModel.fromJson(e.data()))
          .toList();

      AppLogger.log('✅ Found ${posts.length} posts for authors');
      return posts;
    } catch (e, stackTrace) {
      AppLogger.error(
        e,
        stackTrace,
        reason: '❌ Error fetching posts for authors',
      );
      rethrow;
    }
  }

  /// Populate with profiles and latest comments
  Future<List<PopulatedPostModel>> _populatePosts(
    List<FirebasePostModel> posts,
  ) async {
    try {
      AppLogger.log(
        '✨ Populating ${posts.length} posts with profile + comments',
      );

      final populatedPosts = <PopulatedPostModel>[];

      for (final post in posts) {
        final populatedPost = await post.populateWithProfile(_firestore);

        populatedPosts.add(populatedPost);
      }

      AppLogger.log('✅ Successfully populated posts');
      return populatedPosts;
    } catch (e, stackTrace) {
      AppLogger.error(
        e,
        stackTrace,
        reason: '❌ Error populating posts',
      );
      rethrow;
    }
  }
}
