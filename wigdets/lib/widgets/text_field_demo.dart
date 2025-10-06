import 'package:flutter/material.dart';

class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({super.key});

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;

  void _validateEmail(String value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value.isNotEmpty && !emailRegex.hasMatch(value)) {
      setState(() {
        _emailError = "Geçerli bir email formatı giriniz.";
      });
    } else {
      setState(() {
        _emailError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Ad-Soyad TextField
        TextField(
          textInputAction:
              TextInputAction.done, // Enter'a basınca klavye kapanır
          onSubmitted: (_) => FocusScope.of(context).unfocus(),
          decoration: const InputDecoration(hintText: "Enter Name-Surname"),
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Email TextField
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Enter Email",
            errorText: _emailError,
          ),
          onChanged: _validateEmail,
          style: const TextStyle(
            color: Colors.blue,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),

        // Telefon Numarası TextField
        TextField(
          maxLength: 10,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: "Enter Phone Number"),
          style: const TextStyle(
            color: Colors.green,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
