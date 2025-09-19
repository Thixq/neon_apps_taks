import 'package:clone_insta/feature/app_logger.dart';
import 'package:clone_insta/feature/constants/end_point_constant.dart';
import 'package:clone_insta/feature/utils/enums/relationship_enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Service that manages all relationship-related operations.
/// Single responsibility: follow, unfollow, block, unblock, status query.
final class RelationshipManager {
  /// Constructor
  RelationshipManager({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  /// DocId generation rule: min + "_" + max
  String _makeDocId(String userA, String userB) {
    final ids = [userA, userB]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  /// Follow user
  Future<void> followUser(String currentUserId, String targetUserId) async {
    try {
      final docId = _makeDocId(currentUserId, targetUserId);
      final relationshipRef = _firestore
          .collection(EndPointConstant.relationships)
          .doc(docId);

      await _firestore.runTransaction((txn) async {
        final relDoc = await txn.get(relationshipRef);

        if (!relDoc.exists) {
          txn.set(relationshipRef, {
            'users': [currentUserId, targetUserId]..sort(),
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        } else {
          txn.update(relationshipRef, {
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }

        // Update followStatus on currentUser side
        txn
          ..set(
            relationshipRef.collection('sides').doc(currentUserId),
            {
              'followStatus': FollowStatus.active.name,
              'updatedAt': FieldValue.serverTimestamp(),
              'muted': false,
              'blocked': BlockStatus.none.name,
            },
            SetOptions(merge: true),
          )
          // Update seed cache
          ..set(
            _firestore
                .collection(EndPointConstant.users)
                .doc(currentUserId)
                .collection(EndPointConstant.followingSeed)
                .doc(targetUserId),
            {'id': targetUserId, 'createdAt': FieldValue.serverTimestamp()},
          )
          ..set(
            _firestore
                .collection(EndPointConstant.users)
                .doc(targetUserId)
                .collection(EndPointConstant.followersSeed)
                .doc(currentUserId),
            {'id': currentUserId, 'createdAt': FieldValue.serverTimestamp()},
          );
      });
    } catch (e, stack) {
      AppLogger.error(
        'RelationshipManager followUser error: $e',
        stack,
      );
      rethrow;
    }
  }

  /// Unfollow
  Future<void> unfollowUser(String currentUserId, String targetUserId) async {
    try {
      final docId = _makeDocId(currentUserId, targetUserId);
      final relationshipRef = _firestore
          .collection(EndPointConstant.relationships)
          .doc(docId);

      await _firestore.runTransaction((txn) async {
        txn
          ..set(
            relationshipRef.collection('sides').doc(currentUserId),
            {
              'followStatus': FollowStatus.none.name,
              'updatedAt': FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true),
          )
          // Clear seed cache
          ..delete(
            _firestore
                .collection(EndPointConstant.users)
                .doc(currentUserId)
                .collection(EndPointConstant.followingSeed)
                .doc(targetUserId),
          )
          ..delete(
            _firestore
                .collection(EndPointConstant.users)
                .doc(targetUserId)
                .collection(EndPointConstant.followersSeed)
                .doc(currentUserId),
          );
      });
    } catch (e, stack) {
      AppLogger.error(
        'RelationshipManager unfollowUser error: $e',
        stack,
      );
      rethrow;
    }
  }

  /// Block the user
  Future<void> blockUser(String currentUserId, String targetUserId) async {
    try {
      final docId = _makeDocId(currentUserId, targetUserId);
      final relationshipRef = _firestore
          .collection(EndPointConstant.relationships)
          .doc(docId);

      await relationshipRef.collection('sides').doc(currentUserId).set(
        {
          'blocked': BlockStatus.blocked.name,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    } catch (e, stack) {
      AppLogger.error(
        'RelationshipManager blockUser error: $e',
        stack,
      );
      rethrow;
    }
  }

  /// Remove the block
  Future<void> unblockUser(String currentUserId, String targetUserId) async {
    try {
      final docId = _makeDocId(currentUserId, targetUserId);
      final relationshipRef = _firestore
          .collection(EndPointConstant.relationships)
          .doc(docId);

      await relationshipRef.collection('sides').doc(currentUserId).set(
        {
          'blocked': BlockStatus.none.name,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    } catch (e, stack) {
      AppLogger.error(
        'RelationshipManager unblockUser error: $e',
        stack,
      );
      rethrow;
    }
  }

  /// Relationship status query (follow + block)
  Future<(FollowStatus, BlockStatus)> getRelationshipStatus(
    String currentUserId,
    String targetUserId,
  ) async {
    try {
      final docId = _makeDocId(currentUserId, targetUserId);
      final relationshipRef = _firestore
          .collection(EndPointConstant.relationships)
          .doc(docId);

      final currentSide = await relationshipRef
          .collection('sides')
          .doc(currentUserId)
          .get();
      final otherSide = await relationshipRef
          .collection('sides')
          .doc(targetUserId)
          .get();

      // Default values
      var follow = FollowStatus.none;
      var block = BlockStatus.none;

      if (currentSide.exists) {
        final data = currentSide.data() ?? {};
        follow = FollowStatus.values.firstWhere(
          (e) => e.name == data['followStatus'],
          orElse: () => FollowStatus.none,
        );
        final blockVal = BlockStatus.values.firstWhere(
          (e) => e.name == data['blocked'],
          orElse: () => BlockStatus.none,
        );
        if (blockVal == BlockStatus.blocked) block = BlockStatus.blocked;
      }

      if (otherSide.exists) {
        final data = otherSide.data() ?? {};
        final blockVal = BlockStatus.values.firstWhere(
          (e) => e.name == data['blocked'],
          orElse: () => BlockStatus.none,
        );
        if (blockVal == BlockStatus.blocked) block = BlockStatus.blocked;
      }

      return (follow, block);
    } catch (e, stack) {
      AppLogger.error(
        'RelationshipManager getRelationshipStatus error: $e',
        stack,
      );
      rethrow;
    }
  }

  /// Get followers (fast via seed)
  Stream<List<String>> getFollowers(String userId) {
    return _firestore
        .collection(EndPointConstant.users)
        .doc(userId)
        .collection(EndPointConstant.followersSeed)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((d) => d.id).toList());
  }

  /// Get following (fast via seed)
  Stream<List<String>> getFollowing(String userId) {
    return _firestore
        .collection(EndPointConstant.users)
        .doc(userId)
        .collection(EndPointConstant.followingSeed)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((d) => d.id).toList());
  }
}
