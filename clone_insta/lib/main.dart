import 'package:clone_insta/feature/dependency_injection/dependency_manager.dart';
import 'package:clone_insta/feature/routing/app_router.dart';
import 'package:clone_insta/feature/theme.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyManager.instance.initialize();
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    final appRoute = AppRouter();

    return MaterialApp.router(
      routerConfig: appRoute.config(),
      darkTheme: NeonTheme.dark(),
      theme: NeonTheme.light(),
    );
  }
}
