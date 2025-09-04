import 'package:auto_route/auto_route.dart';
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
    return const AutoRouter();
  }
}
