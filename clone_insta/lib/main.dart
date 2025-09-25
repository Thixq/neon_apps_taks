import 'dart:ui';

import 'package:clone_insta/feature/init/dependency_injection/dependency_container.dart';
import 'package:clone_insta/feature/init/dependency_injection/dependency_manager.dart';
import 'package:clone_insta/feature/routing/app_router.dart';
import 'package:clone_insta/feature/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DependencyManager.instance.initialize();
  final themeColor =
      DependencyContainer.manager.firebaseRemoteConfig.themeColor;
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(_App(themeColor));
}

class _App extends StatelessWidget {
  const _App(this.seedColor);

  final Color seedColor;

  @override
  Widget build(BuildContext context) {
    final appRoute = AppRouter();

    return MaterialApp.router(
      routerConfig: appRoute.config(),
      darkTheme: NeonTheme.dark(seedColor: seedColor),
      theme: NeonTheme.light(seedColor: seedColor),
    );
  }
}
