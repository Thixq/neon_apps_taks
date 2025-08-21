part of '../create_room_dialog.dart';

class _Title extends StatelessWidget {
  const _Title({required this.onSubmitted});

  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hint: Text('Room Name'),
        border: OutlineInputBorder(),
      ),
    );
  }
}
