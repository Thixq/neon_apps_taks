import 'package:auto_route/auto_route.dart';

import 'package:clone_insta/feature/routing/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
/// Router
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page),
    AutoRoute(
      page: SignShellRoute.page,
      children: [
        AutoRoute(initial: true, page: SignInRoute.page),
        AutoRoute(page: SignUpRoute.page),
      ],
    ),
    AutoRoute(
      initial: true,
      page: HomeShellRoute.page,
      children: [
        AutoRoute(initial: true, page: FeedRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
    AutoRoute(page: CreatePostRoute.page),
  ];
}
