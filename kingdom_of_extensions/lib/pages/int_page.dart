import 'package:flutter/material.dart';
import 'package:kingdom_of_extensions/extensions.dart';

class IntPage extends StatefulWidget {
  const IntPage({super.key});

  @override
  State<IntPage> createState() => _IntPageState();
}

class _IntPageState extends State<IntPage> {
  final controller = TextEditingController(text: '17');
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Int - Prime check')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter integer'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final n = int.tryParse(controller.text);
                if (n == null) {
                  setState(() => result = 'Geçerli bir tamsayı girin');
                  return;
                }
                setState(
                  () =>
                      result = '$n ${n.isPrime ? 'asaldır' : 'asal değildir'}',
                );
              },
              child: const Text('Kontrol et'),
            ),
            const SizedBox(height: 12),
            Text(result),
          ],
        ),
      ),
    );
  }
}
