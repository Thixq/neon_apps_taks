// ignore_for_file: use_build_context_synchronously

import 'package:decryptor/dialog.dart';
import 'package:decryptor/result.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Decryptor')),
      body: Center(
        child: FilledButton(
          onPressed: () async {
            final password = await showTextFieldDialog(context);
            if (password == 'neon') {
              if (mounted) {
                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Result()),
                );
              }
            }
          },
          child: Text('Decrypt'),
        ),
      ),
    );
  }
}
