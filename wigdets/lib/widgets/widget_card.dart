import 'package:flutter/material.dart';

/// Ortak kart yapısı - her widget örneği bu kart ile gösterilecek
class WidgetCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const WidgetCard({
    super.key,
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
