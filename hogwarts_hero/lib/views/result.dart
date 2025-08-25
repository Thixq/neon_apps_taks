import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tebrikler Doğru Hamle")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("assets/hero.png"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Geri"),
            ),
          ],
        ),
      ),
    );
  }
}
