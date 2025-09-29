import 'package:clone_insta/feature/components/profile_avatar.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/init/dependency_injection/dependency_container.dart';
import 'package:clone_insta/feature/models/user_wtih_friendship.dart';
import 'package:clone_insta/feature/orchestration/friendship_orchestration.dart';
import 'package:clone_insta/feature/utils/enums/relationship_enums.dart';
import 'package:flutter/material.dart';

part 'widgets/friendship_list_tile.dart';

/// Friendship bottom sheet
class FriendshipBottomSheet extends StatefulWidget {
  const FriendshipBottomSheet._({required this.currentUserId, super.key});

  /// Current user id
  final String currentUserId;

  /// Show the bottom sheet
  static Future<void> show(
    BuildContext context, {
    required String currentUserId,
  }) async {
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      showDragHandle: true,
      useRootNavigator: true,
      builder: (context) => FriendshipBottomSheet._(
        currentUserId: currentUserId,
      ),
    );
  }

  @override
  State<FriendshipBottomSheet> createState() => _FriendshipBottomSheetState();
}

class _FriendshipBottomSheetState extends State<FriendshipBottomSheet> {
  late final FriendshipOrchestration? _orchestration;

  List<UserWithFriendship>? _users = [];

  @override
  void initState() {
    _orchestration = DependencyContainer.orchestration.friendshipOrchestration;
    _getUsers();
    super.initState();
  }

  Future<void> _getUsers() async {
    final users = await _orchestration!.getUsersWithFriendship(
      currentUserId: widget.currentUserId,
      pageSize: 20,
    );

    // burada async iş bitti, şimdi state güncelleyebiliriz
    if (mounted) {
      setState(() {
        _users = users;
      });
    }
  }

  Future<void> _toggleFollow(String targetUserId) async {
    await _orchestration!.toggleFollow(
      currentUserId: widget.currentUserId,
      targetUserId: targetUserId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: .9,
      builder: (context, scrollController) {
        return ListView.builder(
          shrinkWrap: true,
          controller: scrollController,
          itemCount: _users?.length,
          itemBuilder: (context, index) {
            final friend = _users![index];
            return _FriendshipListTile(
              userName: friend.user.fullName,
              userId: friend.user.id,
              userImageUrl: friend.user.profileImage,
              followStatus: friend.follow,
              onFollow: _toggleFollow,
            );
          },
        );
      },
    );
  }
}
