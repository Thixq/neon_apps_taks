import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const VikingAnimationsApp());
}

class VikingAnimationsApp extends StatelessWidget {
  const VikingAnimationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viking Animations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
