import 'package:flutter/material.dart';

class MovementSpell extends StatefulWidget {
  const MovementSpell({super.key});

  @override
  State<MovementSpell> createState() => _MovementSpellState();
}

class _MovementSpellState extends State<MovementSpell> {
  double _yOffset = 0;

  void _moveUp() => setState(() => _yOffset -= 30);
  void _moveDown() => setState(() => _yOffset += 30);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text("🪄 Hareket Büyüsü"),
          const SizedBox(height: 10),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            transform: Matrix4.translationValues(0, _yOffset, 0),
            child: const Text(
              "Ben yukarı ve aşağı hareket edebilirim!",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _moveUp, child: const Text("Yukarı")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: _moveDown, child: const Text("Aşağı")),
            ],
          ),
        ],
      ),
    );
  }
}
