part of 'splash_view.dart';

mixin _SplashMixin on State<SplashView> {
  @override
  void initState() {
    _routing();
    super.initState();
  }

  void _routing() {
    if (DependencyContainer.manager.profileManager.profile == null) {
      context.router.replaceAll([const SignShellRoute()]);
    } else {
      context.router.replaceAll([const HomeShellRoute()]);
    }
  }
}
