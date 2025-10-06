import 'package:flutter/material.dart';

class Task12Widget extends StatelessWidget {
  const Task12Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // kare görünüm, hem yatay hem dikeyde uyumlu
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            child: _spellLabel("Expelliarmus", Colors.redAccent),
          ),
          Positioned(
            bottom: 20,
            child: _spellLabel("Stupefy", Colors.blueAccent),
          ),
          Positioned(
            left: 20,
            child: _spellLabel("Expecto Patronum", Colors.green),
          ),
          Positioned(
            right: 20,
            child: _spellLabel("Avada Kedavra", Colors.purple),
          ),
        ],
      ),
    );
  }

  Widget _spellLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis, // Taşmayı engeller
      ),
    );
  }
}
