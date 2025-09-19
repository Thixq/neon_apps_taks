import 'package:clone_insta/feature/app_logger.dart';
import 'package:clone_insta/feature/constants/end_point_constant.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:clone_insta/feature/models/post_model/post_update_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// The manager for posts
final class PostManager {
  /// Constructor
  PostManager({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// Create a new post
  Future<String?> createPost(FirebasePostModel post) async {
    try {
      final doc = _firestore.collection(EndPointConstant.posts).doc();
      final data = post.toJson()..['id'] = doc.id;

      await doc.set(data);

      AppLogger.log('✅ Post created successfully with id: ${doc.id}');
      return doc.id;
    } catch (e, stack) {
      AppLogger.error(e, stack, reason: '❌ Error creating post');
      rethrow;
    }
  }

  /// Get a post by id
  Future<FirebasePostModel?> getPost(String postId) async {
    try {
      AppLogger.log('📥 Fetching post with id: $postId');

      final doc = await _firestore
          .collection(EndPointConstant.posts)
          .doc(postId)
          .get();

      if (!doc.exists) {
        AppLogger.log('⚠️ Post not found: $postId');
        return null;
      }

      final post = FirebasePostModel.fromJson(doc.data()!);
      AppLogger.log('✅ Post fetched successfully: $postId');
      return post;
    } catch (e, stack) {
      AppLogger.error(e, stack, reason: '❌ Error fetching post: $postId');
      rethrow;
    }
  }

  /// Get posts by user (with pagination)
  Future<List<FirebasePostModel?>> getUserPosts(
    String userId, {
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      AppLogger.log('📥 Fetching posts for user: $userId (limit $limit)');

      var query = _firestore
          .collection(EndPointConstant.posts)
          .where(EndPointConstant.userId, isEqualTo: userId)
          .orderBy(EndPointConstant.createdAt, descending: true)
          .limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
        AppLogger.log('⏭ Pagination applied for user: $userId');
      }

      final snapshot = await query.get();

      final posts = snapshot.docs
          .map((e) => e.exists ? FirebasePostModel.fromJson(e.data()) : null)
          .toList();

      AppLogger.log(
        '✅ Found ${posts.length} posts for user: $userId (limit $limit)',
      );
      return posts;
    } catch (e, stack) {
      AppLogger.error(
        e,
        stack,
        reason: '❌ Error fetching posts for user: $userId',
      );
      rethrow;
    }
  }

  /// Post update
  Future<void> updatePost(String postId, PostUpdateModel data) async {
    try {
      await _firestore
          .collection(EndPointConstant.posts)
          .doc(postId)
          .update(data.toJson());

      AppLogger.log('✅ Post updated successfully: $postId');
    } catch (e, stack) {
      AppLogger.error(e, stack, reason: '❌ Error updating post: $postId');
      rethrow;
    }
  }

  /// Delete post (TODO: delete comments & likes)
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection(EndPointConstant.posts).doc(postId).delete();

      AppLogger.log('🗑 Post deleted successfully: $postId');

      //! TODO: Delete comments and likes subcollections
    } catch (e, stack) {
      AppLogger.error(e, stack, reason: '❌ Error deleting post: $postId');
      rethrow;
    }
  }
}
