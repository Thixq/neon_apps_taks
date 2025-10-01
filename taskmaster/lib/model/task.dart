import 'package:hive/hive.dart';

part 'task.g.dart'; // Hive adapter için gerekli

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isDone;

  Task({required this.title, required this.description, this.isDone = false});
}
