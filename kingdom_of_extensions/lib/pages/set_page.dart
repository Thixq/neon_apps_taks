import 'package:flutter/material.dart';
import 'package:kingdom_of_extensions/extensions.dart';

class SetPage extends StatefulWidget {
  const SetPage({super.key});

  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  final controllerA = TextEditingController(text: 'a,b,c');
  final controllerB = TextEditingController(text: 'b,c,d');
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set - Symmetric Difference')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controllerA,
              decoration: const InputDecoration(
                labelText: 'Set A (comma separated)',
              ),
            ),
            TextField(
              controller: controllerB,
              decoration: const InputDecoration(
                labelText: 'Set B (comma separated)',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final a = controllerA.text
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toSet();
                final b = controllerB.text
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toSet();
                final diff = a.symmetricDifference(b);
                setState(
                  () => result = 'Symmetric difference: ${diff.join(', ')}',
                );
              },
              child: const Text('Compute'),
            ),
            const SizedBox(height: 12),
            Text(result),
          ],
        ),
      ),
    );
  }
}
