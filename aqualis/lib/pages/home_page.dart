import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../models/memory_fragment.dart';
import 'new_fragment_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MemoryFragment> fragments = [];

  @override
  void initState() {
    super.initState();
    loadFragments();
  }

  void loadFragments() {
    setState(() {
      fragments = objectBox.fragmentBox.getAll();
    });
  }

  void deleteFragment(int id) {
    objectBox.fragmentBox.remove(id);
    loadFragments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coral Memory Fragments")),
      body: fragments.isEmpty
          ? const Center(child: Text("Henüz kayıt yok."))
          : ListView.builder(
              itemCount: fragments.length,
              itemBuilder: (context, index) {
                final f = fragments[index];
                return ListTile(
                  title: Text(f.title),
                  subtitle: Text(
                    "${f.description}\n${DateFormat('dd/MM/yyyy').format(f.date)}",
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteFragment(f.id),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NewFragmentPage()),
          );
          loadFragments();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
