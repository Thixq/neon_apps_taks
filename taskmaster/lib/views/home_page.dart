import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/hive_manager.dart';
import '../model/task.dart';
import 'add_task_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBox = HiveManager.taskBox;

    return Scaffold(
      appBar: AppBar(title: const Text("TaskMaster")),
      body: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, Box<Task> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("Henüz görev eklenmedi."));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final task = box.getAt(index);
              return ListTile(
                title: Text(task!.title),
                subtitle: Text(task.description),
                trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (val) {
                    task.isDone = val ?? false;
                    task.save(); // Hive objesi güncellenir
                  },
                ),
                onLongPress: () => box.deleteAt(index), // Silmek için uzun bas
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
