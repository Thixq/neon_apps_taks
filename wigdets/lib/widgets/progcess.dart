import 'package:flutter/material.dart';

class Task10Widget extends StatefulWidget {
  const Task10Widget({super.key});

  @override
  State<Task10Widget> createState() => _Task10WidgetState();
}

class _Task10WidgetState extends State<Task10Widget> {
  bool _isRunning = false;
  int _counter = 0;
  Color _indicatorColor = Colors.blue;

  Future<void> _startCounter() async {
    setState(() {
      _isRunning = true;
      _counter = 0;
      _indicatorColor = Colors.blue;
    });

    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 50));

      setState(() {
        _counter = i;
        if (i % 10 == 0) {
          _indicatorColor = Colors.primaries[i ~/ 10 % Colors.primaries.length];
        }
      });
    }

    // Bittiğinde indicator kaybolsun
    setState(() {
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _isRunning ? null : _startCounter,
          child: const Text("Start Counter"),
        ),
        const SizedBox(height: 20),
        if (_isRunning) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(_indicatorColor),
              ),
              const SizedBox(width: 16),
              Text(
                "$_counter",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
