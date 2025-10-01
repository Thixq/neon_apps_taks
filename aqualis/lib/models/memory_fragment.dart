import 'package:objectbox/objectbox.dart';

@Entity()
class MemoryFragment {
  int id;

  String title;
  String description;
  DateTime date;

  MemoryFragment({
    this.id = 0,
    required this.title,
    required this.description,
    required this.date,
  });
}
