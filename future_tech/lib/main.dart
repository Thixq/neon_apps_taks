import 'package:flutter/material.dart';
import 'package:future_tech/view/home_view/home_view.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeView());
  }
}
