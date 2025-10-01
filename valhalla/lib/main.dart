import 'package:flutter/material.dart';
import 'screens/list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thor - Asgard Form',

      debugShowCheckedModeBanner: false,
      home: const ListPage(),
    );
  }
}
