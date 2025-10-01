import 'package:flutter/material.dart';

class InvisibilitySpell extends StatefulWidget {
  const InvisibilitySpell({super.key});

  @override
  State<InvisibilitySpell> createState() => _InvisibilitySpellState();
}

class _InvisibilitySpellState extends State<InvisibilitySpell> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text("🪄 Görünmezlik Büyüsü"),
          const SizedBox(height: 10),
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: const Text(
              "Ben görünmez olabilirim!",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => _isVisible = false),
                child: const Text("Hide"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => setState(() => _isVisible = true),
                child: const Text("Show"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
