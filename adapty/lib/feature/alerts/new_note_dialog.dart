import 'package:adapty/feature/models/note_model.dart';
import 'package:flutter/material.dart';

final class NewNoteDialog {
  NewNoteDialog._();

  static String? _title;
  static String? _content;
  static Future<NoteModel?> show(BuildContext context) async {
    return showDialog<NoteModel?>(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('New Note', style: Theme.of(context).textTheme.titleMedium),
              TextFormField(
                decoration: InputDecoration(hintText: 'Title'),
                onChanged: (value) {
                  _title = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'content'),
                maxLines: 2,
                onChanged: (value) {
                  _content = value;
                },
              ),
              _buildAction(context),
            ],
          ),
        ),
      ),
    );
  }

  static Row _buildAction(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final note = NoteModel(
              id: DateTime.now().toIso8601String(),
              title: _title!,
              content: _content!,
              time: DateTime.now(),
            );
            Navigator.pop(context, note);
          },
          child: Text('Add Note'),
        ),
      ],
    );
  }
}
