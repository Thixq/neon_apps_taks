import 'package:auto_route/auto_route.dart';
import 'package:clone_insta/feature/constants/app_constant.dart';
import 'package:clone_insta/feature/routing/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
/// Splash view
class SplashView extends StatefulWidget {
  /// Splash view
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) await context.router.replaceAll([const SignShellRoute()]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppConstant.appIcon),
      ),
    );
  }
}
