part of 'profile_view.dart';

mixin _ProfileMixin on State<ProfileView> {
  late final ProfileManager user;

  @override
  void initState() {
    user = DependencyContainer.manager.profileManager;
    super.initState();
  }
}
