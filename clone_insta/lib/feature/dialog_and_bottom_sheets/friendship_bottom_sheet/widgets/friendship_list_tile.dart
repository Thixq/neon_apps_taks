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
    this.followStatus,
  });

  final ValueChanged<String>? onFollow;
  final String? userName;
  final String? userImageUrl;
  final String? userId;
  final FollowStatus? followStatus;

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
        onPressed: (widget.followStatus == FollowStatus.active)
            ? null
            : () => widget.onFollow?.call(widget.userId ?? ''),
        child: Text(
          widget.followStatus == FollowStatus.none
              ? _follow
              : widget.followStatus == FollowStatus.pending
              ? _pending
              : _followed,
        ),
      ),
    );
  }
}
