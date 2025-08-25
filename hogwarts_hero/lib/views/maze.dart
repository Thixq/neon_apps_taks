import 'package:flutter/material.dart';
import 'package:hogwarts_hero/utils/page_animations.dart';
import 'package:hogwarts_hero/views/result.dart';
import 'package:hogwarts_hero/views/success.dart';
import 'package:hogwarts_hero/views/welcome.dart';

class MazePage extends StatefulWidget {
  const MazePage({super.key});

  @override
  State<MazePage> createState() => _MazePageState();
}

class _MazePageState extends State<MazePage> {
  final List<String> correctPath = [
    "up",
    "right",
    "right",
    "down",
    "left",
    "up",
    "left",
  ];
  final List<String> playerMoves = [];
  String? message;

  void _attemptMove(String direction) {
    setState(() {
      playerMoves.add(direction);

      final int idx = playerMoves.length - 1;
      if (playerMoves[idx] != correctPath[idx]) {
        message = "Tuzaklandın, tekrar dene!";
        playerMoves.clear();
        return;
      }

      if (playerMoves.length == correctPath.length) {
        message = "Tebrikler, başardın!";
        // Başarı sayfasına animasyonla git
        Future.microtask(() {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              pageBuilder: (_, __, ___) => const Success(),
              transitionsBuilder: (_, anim, __, child) {
                final fade = Tween<double>(begin: 0, end: 1).animate(anim);
                final scale = Tween<double>(begin: 0.9, end: 1).animate(anim);
                return FadeTransition(
                  opacity: fade,
                  child: ScaleTransition(scale: scale, child: child),
                );
              },
            ),
          );
        });
        return;
      }

      PageRoute route;
      switch (direction) {
        case "up":
          route = PageAnimations.pageRouteBuilderSlide(const Result());
          break;
        case "right":
          route = PageAnimations.pageRouteBuilderZoom(const Result());
          break;
        case "left":
          route = PageAnimations.pageRouteBuilderPush(const Result());
          break;
        case "down":
          route = PageAnimations.pageRouteBuilderCover(const Result());
          break;
        default:
          route = MaterialPageRoute(builder: (context) => WelcomePage());
      }

      Future.microtask(() => Navigator.push(context, route));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Maze")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/hero.png"),
            ),
            const SizedBox(height: 24),
            const Text("Yönünü Seç", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            if (message != null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  message!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            // Yön Butonları
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_upward, size: 40),
                        onPressed: () => _attemptMove("up"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Left - Right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 40),
                        onPressed: () => _attemptMove("left"),
                      ),
                      const SizedBox(width: 50),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward, size: 40),
                        onPressed: () => _attemptMove("right"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Down
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_downward, size: 40),
                        onPressed: () => _attemptMove("down"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                "Hamleler: ${playerMoves.join(", ")}",
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
