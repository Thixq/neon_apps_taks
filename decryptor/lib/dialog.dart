import 'package:flutter/material.dart';

Future<String?> showTextFieldDialog(BuildContext context) async {
  final text = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Enter Password'),
        content: TextField(
          controller: text,
          decoration: InputDecoration(hint: Text('Enter Here')),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text('Back'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, text.text),
            child: Text('Confrim'),
          ),
        ],
      );
    },
  );
}
