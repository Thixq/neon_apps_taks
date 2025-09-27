import 'package:auto_route/auto_route.dart';
import 'package:clone_insta/feature/init/dependency_injection/dependency_container.dart';
import 'package:clone_insta/feature/routing/app_router.gr.dart';
import 'package:clone_insta/product/home/feed/feed_view_model/feed_view_model.dart';
import 'package:clone_insta/product/home/profile/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeedViewModel(
            profileManager: DependencyContainer.manager.profileManager,
            feedManager: DependencyContainer.manager.feedManager,
          ),
        ),
        BlocProvider(
          create: (context) => ProfileViewModel(
            profileManager: DependencyContainer.manager.profileManager,
            postManager: DependencyContainer.manager.postManager,
            firestoreService: DependencyContainer.service.firestore,
          ),
        ),
      ],
      child: AutoTabsScaffold(
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
      ),
    );
  }
}
