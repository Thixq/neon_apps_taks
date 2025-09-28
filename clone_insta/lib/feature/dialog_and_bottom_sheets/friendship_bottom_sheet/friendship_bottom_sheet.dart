import 'package:clone_insta/feature/components/profile_avatar.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:flutter/material.dart';

part 'widgets/friendship_list_tile.dart';

class FriendshipBottomSheet extends StatelessWidget {
  const FriendshipBottomSheet._({super.key});

  static Future<void> show(
    BuildContext context,
  ) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      showDragHandle: true,
      useRootNavigator: true,
      builder: (context) => const FriendshipBottomSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: .9,
      builder: (context, scrollController) {
        return Material(
          child: ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            itemCount: 30,
            itemBuilder: (context, index) => _FriendshipListTile(
              onFollow: () {},
            ),
          ),
        );
      },
    );
  }
}
