import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../models/memory_fragment.dart';
import 'objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<MemoryFragment> fragmentBox;

  ObjectBox._create(this.store) {
    fragmentBox = Box<MemoryFragment>(store);
  }

  static Future<ObjectBox> create() async {
    // iOS ve Android'de yazılabilir dizin alıyoruz
    final dir = await getApplicationDocumentsDirectory();
    final store = openStore(directory: p.join(dir.path, "objectbox"));
    return ObjectBox._create(store);
  }
}
