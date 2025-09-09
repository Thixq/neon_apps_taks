import 'package:auto_route/auto_route.dart';
import 'package:clone_insta/feature/routing/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
/// HomeShellView
class HomeShellView extends StatefulWidget {
  /// HomeShellView
  const HomeShellView({super.key});

  @override
  State<HomeShellView> createState() => _HomeShellViewState();
}

class _HomeShellViewState extends State<HomeShellView> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [FeedRoute(), ProfileRoute()],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) {
            tabsRouter.setActiveIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}
