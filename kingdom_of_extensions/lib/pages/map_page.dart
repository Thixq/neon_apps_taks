import 'package:flutter/material.dart';
import 'package:kingdom_of_extensions/extensions.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final people = [
      {'name': 'Ali', 'surname': 'Kaya'},
      {'name': 'Ayşe', 'surname': 'Yılmaz'},
      {'name': 'Mehmet', 'surname': 'Kaya'},
      {'name': 'Fatma', 'surname': 'Yıldız'},
      {'name': 'Can', 'surname': 'Yılmaz'},
    ];

    final grouped = people.groupBySurname();

    return Scaffold(
      appBar: AppBar(title: const Text('Map / List - Group by Surname')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: grouped.entries.map((e) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.key,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...e.value.map((p) => Text(p['name'] ?? '')),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
