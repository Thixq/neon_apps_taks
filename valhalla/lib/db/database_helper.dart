import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/person.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("asgard.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE people(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        surname TEXT NOT NULL,
        age INTEGER NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertPerson(Person person) async {
    final db = await instance.database;
    return await db.insert('people', person.toMap());
  }

  Future<List<Person>> getPeople() async {
    final db = await instance.database;
    final result = await db.query('people');
    return result.map((json) => Person.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
