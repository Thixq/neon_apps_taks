import 'package:flutter/material.dart';
import '../main.dart';
import '../models/memory_fragment.dart';

class NewFragmentPage extends StatefulWidget {
  const NewFragmentPage({super.key});

  @override
  State<NewFragmentPage> createState() => _NewFragmentPageState();
}

class _NewFragmentPageState extends State<NewFragmentPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  void saveFragment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final fragment = MemoryFragment(
        title: title,
        description: description,
        date: DateTime.now(),
      );
      objectBox.fragmentBox.put(fragment);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Fragment Ekle")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Başlık"),
                onSaved: (val) => title = val!,
                validator: (val) =>
                    val == null || val.isEmpty ? "Boş bırakılamaz" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Açıklama"),
                onSaved: (val) => description = val!,
                validator: (val) =>
                    val == null || val.isEmpty ? "Boş bırakılamaz" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveFragment,
                child: const Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
