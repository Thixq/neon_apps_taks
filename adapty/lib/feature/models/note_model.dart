// ignore_for_file: public_member_api_docs, sort_constructors_first
final class NoteModel {
  final String id;
  final String title;
  final String content;
  final DateTime time;
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? time,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      time: time ?? this.time,
    );
  }
}
