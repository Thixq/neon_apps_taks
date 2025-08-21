import 'package:flutter/material.dart';

void main() {
  runApp(const TravelEaseApp());
}

class TravelEaseApp extends StatelessWidget {
  const TravelEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TravelEase - Popüler Destinasyonlar'),
          backgroundColor: Colors.teal,
        ),
        body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            TravelDestinationCard(
              title: 'Londra, İngiltere',
              imagePath: 'assets/london.jpeg',
            ),
            TravelDestinationCard(
              title: 'Tokyo, Japonya',
              imagePath: 'assets/tokyo.jpeg',
            ),
            TravelDestinationCard(
              title: 'Kyoto, Japonya',
              imagePath: 'assets/kyoto.jpeg',
            ),
            TravelDestinationCard(
              title: 'New York, U.S.A',
              imagePath: 'assets/new_york.jpeg',
            ),
          ],
        ),
      ),
    );
  }
}

class TravelDestinationCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const TravelDestinationCard({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 12.0,
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
