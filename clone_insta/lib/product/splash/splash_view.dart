import 'package:auto_route/auto_route.dart';
import 'package:clone_insta/feature/constants/app_constant.dart';
import 'package:clone_insta/feature/init/dependency_injection/dependency_container.dart';
import 'package:clone_insta/feature/routing/app_router.gr.dart';
import 'package:flutter/material.dart';

part 'splash_mixin.dart';

@RoutePage()
/// Splash view
class SplashView extends StatefulWidget {
  /// Splash view
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with _SplashMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppConstant.appIcon),
      ),
    );
  }
}
