part of '../home_view.dart';

class _TodoList extends StatelessWidget {
  const _TodoList({required this.notes});

  final List<NoteModel> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteCard(note: note);
      },
    );
  }
}
