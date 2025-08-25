part of '../home_view.dart';

class _Profile extends StatelessWidget {
  const _Profile({
    required this.profileOnPressed,
    required this.offterOnPressed,
  });

  final VoidCallback profileOnPressed;
  final VoidCallback offterOnPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        spacing: 16,
        children: [
          ProfileAvatar(
            onPressed: profileOnPressed,
            imageUrl: ImageConst.profile,
          ),
          Text('Kaan', style: Theme.of(context).textTheme.titleMedium),
          Expanded(child: SizedBox.expand()),
          TextButton(onPressed: offterOnPressed, child: Text('Upgrade')),
        ],
      ),
    );
  }
}
