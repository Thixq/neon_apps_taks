import 'package:flutter/material.dart';
import '../core/hive_manager.dart';
import '../model/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _saveTask() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) return;

    final task = Task(title: title, description: description);
    HiveManager.taskBox.add(task);

    Navigator.pop(context); // Geri dön
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Görev Ekle")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Görev Başlığı"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Görev Açıklaması"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveTask, child: const Text("Kaydet")),
          ],
        ),
      ),
    );
  }
}
