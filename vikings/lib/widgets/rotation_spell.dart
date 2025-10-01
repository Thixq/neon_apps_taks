import 'package:flutter/material.dart';
import 'dart:math';

class RotationSpell extends StatefulWidget {
  const RotationSpell({super.key});

  @override
  State<RotationSpell> createState() => _RotationSpellState();
}

class _RotationSpellState extends State<RotationSpell>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _rotation = Tween<double>(begin: 0, end: pi / 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rotateLeft() {
    _controller.reverse(from: 1);
  }

  void _rotateRight() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text("🪄 Dönüş Büyüsü"),
          const SizedBox(height: 10),
          AnimatedBuilder(
            animation: _rotation,
            builder: (_, child) {
              return Transform.rotate(angle: _rotation.value, child: child);
            },
            child: const Icon(Icons.shield, size: 60, color: Colors.blue),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _rotateLeft, child: const Text("Sola")),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _rotateRight,
                child: const Text("Sağa"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
