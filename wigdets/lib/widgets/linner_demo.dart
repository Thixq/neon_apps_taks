import 'package:flutter/material.dart';

class Task11Widget extends StatefulWidget {
  const Task11Widget({super.key});

  @override
  State<Task11Widget> createState() => _Task11WidgetState();
}

class _Task11WidgetState extends State<Task11Widget> {
  int _progress = 0;
  static const int _maxProgress = 10;

  void _incrementProgress() {
    setState(() {
      if (_progress < _maxProgress) {
        _progress++;
      } else {
        _progress = 0; // tekrar başa dön
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = _progress / _maxProgress;

    return Column(
      children: [
        LinearProgressIndicator(
          value: progressValue,
          backgroundColor: Colors.black,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          minHeight: 12,
        ),
        const SizedBox(height: 16),
        Text(
          "Progress: $_progress / $_maxProgress",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _incrementProgress,
          child: const Text("Complete a Task"),
        ),
      ],
    );
  }
}
