import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Başarı")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.celebration_rounded, size: 64),
            const SizedBox(height: 12),
            const Text("Tebrikler, başardın!", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Ana sayfaya dön"),
            ),
          ],
        ),
      ),
    );
  }
}
