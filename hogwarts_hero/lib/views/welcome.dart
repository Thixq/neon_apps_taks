import 'package:flutter/material.dart';
import 'package:hogwarts_hero/views/maze.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Labirente Hoş Geldiniz!\nEğer başarırsanız, gerçek dünya için hazırsınız.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/hero.png"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MazePage()),
                );
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
