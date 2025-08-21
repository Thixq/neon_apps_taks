import 'package:flutter/material.dart';
import 'package:kingdom_of_extensions/extensions.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  DateTime a = DateTime.now();
  DateTime b = DateTime.now().add(const Duration(days: 7));
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DateTime - Days Between')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Date A'),
              subtitle: Text(a.toLocal().toString().split(' ').first),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: a,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => a = picked);
              },
            ),
            ListTile(
              title: const Text('Date B'),
              subtitle: Text(b.toLocal().toString().split(' ').first),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: b,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => b = picked);
              },
            ),
            ElevatedButton(
              onPressed: () => setState(
                () => result = 'Aradaki gün sayısı: ${a.daysBetween(b)}',
              ),
              child: const Text('Hesapla'),
            ),
            const SizedBox(height: 12),
            Text(result),
          ],
        ),
      ),
    );
  }
}
