import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../model/person.dart';
import 'form_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<Person>> _people;

  @override
  void initState() {
    super.initState();
    _refreshPeople();
  }

  void _refreshPeople() {
    _people = DatabaseHelper.instance.getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asgard Halkı")),
      body: FutureBuilder<List<Person>>(
        future: _people,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          }
          if (snapshot.hasData) {
            final people = snapshot.data!;
            if (people.isEmpty) {
              return const Center(child: Text("Kayıtlı kişi yok"));
            }
            return ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                final person = people[index];
                return ListTile(
                  title: Text("${person.name} ${person.surname}"),
                  subtitle: Text("Yaş: ${person.age}, Email: ${person.email}"),
                  leading: CircleAvatar(child: Text(person.id.toString())),
                );
              },
            );
          }
          return const Center(child: Text("Veri bulunamadı"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormPage()),
          );
          if (result == true) {
            setState(() {
              _refreshPeople();
            });
          }
        },
      ),
    );
  }
}
