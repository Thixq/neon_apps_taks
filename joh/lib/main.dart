import 'package:flutter/material.dart';
import 'package:joh/product/home/home_view.dart';

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
