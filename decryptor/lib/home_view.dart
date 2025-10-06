// ignore_for_file: use_build_context_synchronously

import 'package:decryptor/dialog.dart';
import 'package:decryptor/result_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                  MaterialPageRoute(builder: (context) => ResultView()),
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
