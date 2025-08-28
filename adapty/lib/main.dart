import 'package:adapty/feature/profile/profile.dart';
import 'package:adapty/feature/services/subscription_local_sync_service.dart';
import 'package:adapty/product/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final profile = Profile.createDemoProfile();

  final subLocal = SubscriptionLocalSyncService.instance(
    FlutterSecureStorage(),
  );
  if (await subLocal.subscriptionSync()) {
    profile.updateSubscriptionInfo(
      TempSubInfo(
        isActiveSubscription: true,
        subscriptionStatus: SubscriptionBundle.standard,
      ),
    );
  }
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeView());
  }
}
