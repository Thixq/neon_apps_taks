import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../model/person.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      final person = Person(
        name: _nameController.text,
        surname: _surnameController.text,
        age: int.parse(_ageController.text),
        email: _emailController.text,
      );

      await DatabaseHelper.instance.insertPerson(person);

      if (mounted) {
        Navigator.pop(context, true); // başarıyla kaydedildi bilgisi dön
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thor'un Asgard Formu")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "İsim"),
                validator: (value) => value!.isEmpty ? "İsim boş olamaz" : null,
              ),
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: "Soyisim"),
                validator: (value) =>
                    value!.isEmpty ? "Soyisim boş olamaz" : null,
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: "Yaş"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Yaş boş olamaz" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Email boş olamaz" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _saveData, child: const Text("Kaydet")),
            ],
          ),
        ),
      ),
    );
  }
}
