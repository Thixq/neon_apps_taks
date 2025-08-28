part of '../home_view.dart';

class _Profile extends StatelessWidget {
  const _Profile({
    required this.profileOnPressed,
    required this.offterOnPressed,
    required this.profile,
  });

  final VoidCallback profileOnPressed;
  final VoidCallback offterOnPressed;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        spacing: 16,
        children: [
          ProfileAvatar(
            onPressed: profileOnPressed,
            imageUrl: profile.profileImage,
          ),
          Text(
            profile.fullName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Expanded(child: SizedBox.expand()),
          TextButton(
            onPressed: profile.subscriptionInfo.isActiveSubscription
                ? null
                : offterOnPressed,
            child: Text('Upgrade'),
          ),
        ],
      ),
    );
  }
}
