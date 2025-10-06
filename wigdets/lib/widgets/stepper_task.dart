import 'package:flutter/material.dart';

class StepperTask extends StatefulWidget {
  const StepperTask({super.key});

  @override
  State<StepperTask> createState() => _StepperTaskState();
}

class _StepperTaskState extends State<StepperTask> {
  int value = 0;

  void increment() {
    setState(() {
      if (value < 50) {
        value += 5;
      }
    });
  }

  void decrement() {
    setState(() {
      if (value > 0) {
        value -= 5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pink[100], // Arka plan pembe
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "🎀 Barbie's Magical Stepper",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Divider
            Container(
              height: 3,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.white],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Stepper controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrement Button
                IconButton(
                  onPressed: decrement,
                  iconSize: 48,
                  icon: const Icon(Icons.remove_circle, color: Colors.pink),
                ),
                const SizedBox(width: 20),

                // Value Display
                Text(
                  "$value",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 20),

                // Increment Button
                IconButton(
                  onPressed: increment,
                  iconSize: 48,
                  icon: const Icon(Icons.add_circle, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 10),

            const Text(
              "Min: 0, Max: 50, Step: 5",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
