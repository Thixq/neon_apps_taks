import 'package:flutter/material.dart';
import 'package:kingdom_of_extensions/extensions.dart';

class BoolPage extends StatefulWidget {
  const BoolPage({super.key});

  @override
  State<BoolPage> createState() => _BoolPageState();
}

class _BoolPageState extends State<BoolPage> {
  bool a = true;
  bool b = false;
  String op = 'AND';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bool - Logic')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('A'),
              value: a,
              onChanged: (v) => setState(() => a = v),
            ),
            SwitchListTile(
              title: const Text('B'),
              value: b,
              onChanged: (v) => setState(() => b = v),
            ),
            DropdownButton<String>(
              value: op,
              items: const [
                DropdownMenuItem(value: 'AND', child: Text('AND')),
                DropdownMenuItem(value: 'OR', child: Text('OR')),
                DropdownMenuItem(value: 'XOR', child: Text('XOR')),
              ],
              onChanged: (v) => setState(() => op = v ?? 'AND'),
            ),
            ElevatedButton(
              onPressed: () =>
                  setState(() => result = 'Result: ${a.evaluate(op, b)}'),
              child: const Text('Evaluate'),
            ),
            const SizedBox(height: 12),
            Text(result),
          ],
        ),
      ),
    );
  }
}
