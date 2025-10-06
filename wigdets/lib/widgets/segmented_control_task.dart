import 'package:flutter/material.dart';

class SegmentedControlTask extends StatefulWidget {
  const SegmentedControlTask({super.key});

  @override
  State<SegmentedControlTask> createState() => _SegmentedControlTaskState();
}

class _SegmentedControlTaskState extends State<SegmentedControlTask> {
  int _selectedIndex = 0;

  final List<String> _labels = ["Neon Academy 2023", "Neon", "Apps"];

  final List<Color> _colors = [
    Colors.greenAccent,
    Colors.pinkAccent,
    Colors.cyanAccent,
  ];

  double get _height {
    switch (_selectedIndex) {
      case 0:
        return 70; // en büyük
      case 1:
        return 55; // orta
      case 2:
        return 45; // küçük
      default:
        return 55;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _height,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ToggleButtons(
          isSelected: List.generate(
            _labels.length,
            (index) => index == _selectedIndex,
          ),
          onPressed: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          borderRadius: BorderRadius.circular(10),
          selectedColor: Colors.black,
          color: Colors.white,
          fillColor: _colors[_selectedIndex],
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          children: _labels
              .map(
                (label) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(label),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
