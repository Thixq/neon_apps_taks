import 'package:flutter/material.dart';
import 'package:kingdom_of_extensions/extensions.dart';

class StringPage extends StatefulWidget {
  const StringPage({super.key});

  @override
  State<StringPage> createState() => _StringPageState();
}

class _StringPageState extends State<StringPage> {
  final controller = TextEditingController(text: 'kayak');
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('String - Palindrome')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Enter string'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final text = controller.text;
                final isPal = text.isPalindrome;
                setState(
                  () => result =
                      '"$text" ${isPal ? 'bir palindromdur' : 'palindrom değildir'}',
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
