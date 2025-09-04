part of 'post_card.dart';

final class _InfoBar extends StatelessWidget {
  const _InfoBar({
    this.onMorePressed,
    this.profile,
    this.onProfilePressed,
  });

  final VoidCallback? onMorePressed;
  final VoidCallback? onProfilePressed;
  final ProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: null,
              icon: ProfileAvatar(
                onPressed: onProfilePressed,
                imageUrl: profile?.profileImage,
              ),
            ),
            Text('${profile?.fullName}'),
          ],
        ),
        const Spacer(),
        IconButton(onPressed: onMorePressed, icon: const Icon(Icons.more_vert)),
      ],
    );
  }
}
