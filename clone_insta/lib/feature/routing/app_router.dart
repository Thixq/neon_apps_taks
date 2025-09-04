import 'package:auto_route/auto_route.dart';

import 'package:clone_insta/feature/routing/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SignShellRoute.page,
      initial: true,
      children: [
        AutoRoute(initial: true, page: SignInRoute.page),
        AutoRoute(page: SignUpRoute.page),
      ],
    ),
  ];
}
