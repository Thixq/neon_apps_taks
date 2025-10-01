part of '../feed_view.dart';

class _FeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _FeedAppBar({
    required this.currentUserId,
    super.key,
    this.addPostPressed,
  });

  final VoidCallback? addPostPressed;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text('Neon Academy Social'),
      actions: [
        IconButton(
          onPressed: () {
            FriendshipBottomSheet.show(context, currentUserId: currentUserId);
          },
          icon: const Icon(Icons.person),
        ),
        IconButton(
          onPressed: addPostPressed,
          icon: const Icon(Icons.add_a_photo),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
