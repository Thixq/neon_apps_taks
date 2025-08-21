part of '../create_room_dialog.dart';

class _Actions extends StatelessWidget {
  const _Actions({required this.isDoneAction});

  final VoidCallback isDoneAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: Text('Close'),
        ),
        FilledButton(onPressed: isDoneAction, child: Text('Done')),
      ],
    );
  }
}
