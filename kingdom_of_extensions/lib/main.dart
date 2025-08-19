import 'package:flutter/material.dart';
import 'package:kingdom_of_extensions/pages/bool_page.dart';
import 'package:kingdom_of_extensions/pages/datetime_page.dart';
import 'package:kingdom_of_extensions/pages/int_page.dart';
import 'package:kingdom_of_extensions/pages/map_page.dart';
import 'package:kingdom_of_extensions/pages/set_page.dart';
import 'package:kingdom_of_extensions/pages/string_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dartia Extensions',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      routes: {
        '/string': (_) => const StringPage(),
        '/int': (_) => const IntPage(),
        '/datetime': (_) => const DateTimePage(),
        '/bool': (_) => const BoolPage(),
        '/set': (_) => const SetPage(),
        '/map': (_) => const MapPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'String (isPalindrome)', 'route': '/string'},
      {'title': 'Int (isPrime)', 'route': '/int'},
      {'title': 'DateTime (daysBetween)', 'route': '/datetime'},
      {'title': 'Bool (logic)', 'route': '/bool'},
      {'title': 'Set (symmetricDifference)', 'route': '/set'},
      {'title': 'Map / List (groupBySurname)', 'route': '/map'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Dartia Extensions')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(items[i]['title']!),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => Navigator.pushNamed(context, items[i]['route']!),
        ),
      ),
    );
  }
}
