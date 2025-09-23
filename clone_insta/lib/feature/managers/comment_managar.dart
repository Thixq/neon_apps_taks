import 'package:clone_insta/feature/app_logger.dart';
import 'package:clone_insta/feature/constants/end_point_constant.dart';
import 'package:clone_insta/feature/models/comment_model/comment_models.dart';
import 'package:clone_insta/feature/utils/extension/extension_populated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Manages comment-related operations
final class CommentManager {
  /// Constructor
  CommentManager({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// Add a new comment to a post
  Future<void> addComment({
    required String postId,
    required FirebaseCommentModel comment,
  }) async {
    try {
      final postRef = _firestore.collection(EndPointConstant.posts).doc(postId);

      final commentRef = postRef
          .collection(EndPointConstant.comments)
          .doc(); // Firestore auto ID

      final newComment = comment.copyWith(
        id: commentRef.id,
        commentedAt: DateTime.now(),
      );

      final batch = _firestore.batch()
        // 1️⃣ Yorum ekle
        ..set(commentRef, newComment.toJson())
        // 2️⃣ Post dokümanındaki son yorum ID'sini güncelle
        ..update(postRef, {
          'lastCommentId': newComment.id,
        });

      await batch.commit();

      AppLogger.log(
        '💬 Comment added and lastCommentId updated for post $postId',
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        e,
        stackTrace,
        reason: '❌ Error adding comment to post $postId',
      );
      rethrow;
    }
  }

  /// Fetch comments for a specific post
  Future<List<PopulatedCommentModel>> fetchComments(String postId) async {
    try {
      final snapshot = await _firestore
          .collection(EndPointConstant.posts)
          .doc(postId)
          .collection(EndPointConstant.comments)
          .orderBy(EndPointConstant.createdAt, descending: true)
          .get();

      final comments = await Future.wait(
        snapshot.docs.map(
          (doc) async {
            final populated = await FirebaseCommentModel.fromJson(
              doc.data(),
            ).populateWithProfile(_firestore);
            return populated;
          },
        ),
      );

      AppLogger.log('✅ Fetched ${comments.length} comments for post $postId');

      return comments;
    } catch (e, stackTrace) {
      AppLogger.error(
        e,
        stackTrace,
        reason: '❌ Error fetching comments for post $postId',
      );
      rethrow;
    }
  }
}
