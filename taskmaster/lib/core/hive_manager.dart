import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../model/task.dart';

class HiveManager {
  static const String taskBoxName = "tasks";

  static Future<void> initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    // Register Task model adapter
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }

    await Hive.openBox<Task>(taskBoxName);
  }

  static Box<Task> get taskBox => Hive.box<Task>(taskBoxName);
}
