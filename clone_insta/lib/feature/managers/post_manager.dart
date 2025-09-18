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
    final doc = _firestore.collection(EndPointConstant.posts).doc();
    final data = post.toJson()..['id'] = doc.id;
    await doc.set(data);
    return doc.id;
  }

  /// Get a post by id
  Future<FirebasePostModel?> getPost(String postId) async {
    final doc = await _firestore
        .collection(EndPointConstant.posts)
        .doc(postId)
        .get();
    if (!doc.exists) return null;
    return FirebasePostModel.fromJson(doc.data()!);
  }

  /// Get posts by user (with pagination)
  Future<List<FirebasePostModel?>> getUserPosts(
    String userId, {
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    var query = _firestore
        .collection(EndPointConstant.posts)
        .where(EndPointConstant.userId, isEqualTo: userId)
        .orderBy(EndPointConstant.createdAt, descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((e) => e.exists ? FirebasePostModel.fromJson(e.data()) : null)
        .toList();
  }

  /// Post update
  Future<void> updatePost(String postId, PostUpdateModel data) async {
    await _firestore
        .collection(EndPointConstant.posts)
        .doc(postId)
        .update(data.toJson());
  }

  /// Delete post
  Future<void> deletePost(String postId) async {
    await _firestore.collection(EndPointConstant.posts).doc(postId).delete();
    //! TODO: Delete comments and likes subcollections
  }
}
