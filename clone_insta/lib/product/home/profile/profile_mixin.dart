part of 'profile_view.dart';

mixin _ProfileMixin on State<ProfileView> {
  late final ProfileManager user;

  @override
  void initState() {
    user = DependencyContainer.manager.profileManager;
    _getPosts();
    _getStatus();
    super.initState();
  }

  Future<void> _signOut(BuildContext context) async {
    await user.signOut();
    if (context.mounted) {
      await context.router.replaceAll([const SignShellRoute()]);
    }
  }

  Future<void> _getPosts() async {
    await context.read<ProfileViewModel>().getPosts();
  }

  Future<void> _getStatus() async {
    await context.read<ProfileViewModel>().getStatus();
  }
}
