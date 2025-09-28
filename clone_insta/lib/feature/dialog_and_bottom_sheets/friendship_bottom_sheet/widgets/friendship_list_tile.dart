part of '../friendship_bottom_sheet.dart';

const String _follow = 'Follow';
const String _pending = 'Pending';
const String _followed = 'Followed';

class _FriendshipListTile extends StatefulWidget {
  const _FriendshipListTile({
    this.onFollow,
    super.key,
    this.userName,
    this.userImageUrl,
    this.userId,
  });

  final VoidCallback? onFollow;
  final String? userName;
  final String? userImageUrl;
  final String? userId;

  @override
  State<_FriendshipListTile> createState() => _FriendshipListTileState();
}

class _FriendshipListTileState extends State<_FriendshipListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileAvatar(
        imageUrl: widget.userImageUrl,
        size: AppSizes.extraLarge * 1.5,
      ),
      title: Text('${widget.userName}'),

      trailing: FilledButton.tonal(
        onPressed: widget.onFollow,
        child: const Text('Follow'),
      ),
    );
  }
}
