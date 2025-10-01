import 'package:flutter/material.dart';

class SizeSpell extends StatefulWidget {
  const SizeSpell({super.key});

  @override
  State<SizeSpell> createState() => _SizeSpellState();
}

class _SizeSpellState extends State<SizeSpell> {
  double _size = 100;

  void _grow() => setState(() => _size += 30);
  void _shrink() => setState(() => _size = (_size - 30).clamp(50, 300));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text("🪄 Boyut Büyüsü"),
          const SizedBox(height: 10),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: _size,
            height: _size,
            color: Colors.orange,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _grow, child: const Text("Büyüt")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: _shrink, child: const Text("Küçült")),
            ],
          ),
        ],
      ),
    );
  }
}
