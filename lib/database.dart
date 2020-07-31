import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const kTodoTable = 'todo';

class DatabaseProvider {
  DatabaseProvider({this.name = 'todo'});

  final String name;
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, '$name.db');

    final db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database database, int version) async {
    await database.execute("CREATE TABLE $kTodoTable ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "description TEXT, "
        "is_done INTEGER "
        ")");
  }
}
