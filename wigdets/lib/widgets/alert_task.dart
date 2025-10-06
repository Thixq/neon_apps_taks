import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AlertTask extends StatefulWidget {
  const AlertTask({super.key});

  @override
  State<AlertTask> createState() => _AlertTaskState();
}

class _AlertTaskState extends State<AlertTask> {
  final TextEditingController _textController = TextEditingController();

  void _showNoButtonAlert() {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text("No Button Alert"),
        content: Text("This alert has no buttons. Just a title and subtitle."),
      ),
    );
  }

  void _showOneButtonAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("One Button Alert"),
        content: const Text("This alert has one button."),
        actions: [
          TextButton(
            onPressed: () {
              debugPrint("One Button Pressed");
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showTwoButtonAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Two Button Alert"),
        content: const Text("This alert has two buttons."),
        actions: [
          TextButton(
            onPressed: () {
              debugPrint("Cancel Pressed");
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              debugPrint("Confirm Pressed");
              Navigator.pop(context);
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void _showTextFieldAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("TextField Alert"),
        content: TextField(
          controller: _textController,
          decoration: const InputDecoration(hintText: "Enter something..."),
        ),
        actions: [
          TextButton(
            onPressed: () {
              debugPrint("Entered: ${_textController.text}");
              Navigator.pop(context);
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  void _showActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text("Action Sheet"),
            subtitle: Text("Choose an option"),
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Gallery"),
            onTap: () {
              debugPrint("Gallery selected");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Camera"),
            onTap: () {
              debugPrint("Camera selected");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Delete"),
            onTap: () {
              debugPrint("Delete selected");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showActivityController() async {
    await Share.share("This is a shared message from Pinocchio!");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _showNoButtonAlert,
          child: const Text("Show No Button Alert"),
        ),
        ElevatedButton(
          onPressed: _showOneButtonAlert,
          child: const Text("Show One Button Alert"),
        ),
        ElevatedButton(
          onPressed: _showTwoButtonAlert,
          child: const Text("Show Two Button Alert"),
        ),
        ElevatedButton(
          onPressed: _showTextFieldAlert,
          child: const Text("Show TextField Alert"),
        ),
        ElevatedButton(
          onPressed: _showActionSheet,
          child: const Text("Show Action Sheet"),
        ),
        ElevatedButton(
          onPressed: _showActivityController,
          child: const Text("Show Activity Controller (Share)"),
        ),
      ],
    );
  }
}
