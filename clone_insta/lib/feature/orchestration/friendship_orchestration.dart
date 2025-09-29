import 'package:clone_insta/feature/app_logger.dart';
import 'package:clone_insta/feature/managers/relationship_manager.dart';
import 'package:clone_insta/feature/managers/users_manager.dart';
import 'package:clone_insta/feature/models/user_wtih_friendship.dart';
import 'package:clone_insta/feature/utils/enums/relationship_enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// High-level orchestration layer for user friendships.
/// Combines user fetching with relationship status (follow/block),
/// and provides convenient methods to toggle follow/block actions.
final class FriendshipOrchestration {
  /// Constructor
  const FriendshipOrchestration({
    required UsersManager usersManager,
    required RelationshipManager relationshipManager,
  }) : _usersManager = usersManager,
       _relManager = relationshipManager;

  final UsersManager _usersManager;
  final RelationshipManager _relManager;

  /// Fetch users with their friendship status (paginated).
  Future<List<UserWithFriendship>> getUsersWithFriendship({
    required String currentUserId,
    required int pageSize,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      AppLogger.log(
        '🔎 Fetching users with friendship (pageSize=$pageSize, startAfter=${startAfter?.id})',
      );

      // 1) Fetch users
      final users = await _usersManager.getUsers(
        pageSize: pageSize,
        startAfter: startAfter,
      );

      // 🔥 filter out current user
      final filteredUsers = users.where((u) => u.id != currentUserId).toList();

      // 2) Fetch relationship status for each user in parallel
      final futures = filteredUsers.map((u) async {
        final (follow, block) = await _relManager.getRelationshipStatus(
          currentUserId,
          u.id,
        );
        return UserWithFriendship(user: u, follow: follow, block: block);
      }).toList();

      final result = await Future.wait(futures);

      AppLogger.log('✅ Users fetched: ${result.length}');
      return result;
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Failed to fetch users with friendship');
      rethrow;
    }
  }

  /// Toggle follow/unfollow for a given user.
  Future<void> toggleFollow({
    required String currentUserId,
    required String targetUserId,
  }) async {
    try {
      AppLogger.log('🔄 Toggling follow: $currentUserId -> $targetUserId');

      final (follow, _) = await _relManager.getRelationshipStatus(
        currentUserId,
        targetUserId,
      );

      if (follow == FollowStatus.active) {
        await _relManager.unfollowUser(currentUserId, targetUserId);
        AppLogger.log('👋 Unfollowed $targetUserId');
      } else {
        await _relManager.followUser(currentUserId, targetUserId);
        AppLogger.log('➕ Followed $targetUserId');
      }
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Failed to toggle follow');
      rethrow;
    }
  }

  /// Toggle block/unblock for a given user.
  Future<void> toggleBlock({
    required String currentUserId,
    required String targetUserId,
  }) async {
    try {
      AppLogger.log('🔄 Toggling block: $currentUserId -> $targetUserId');

      final (_, block) = await _relManager.getRelationshipStatus(
        currentUserId,
        targetUserId,
      );

      if (block == BlockStatus.blocked) {
        await _relManager.unblockUser(currentUserId, targetUserId);
        AppLogger.log('🚪 Unblocked $targetUserId');
      } else {
        await _relManager.blockUser(currentUserId, targetUserId);
        AppLogger.log('⛔ Blocked $targetUserId');
      }
    } catch (e, s) {
      AppLogger.error(e, s, reason: 'Failed to toggle block');
      rethrow;
    }
  }
}
