import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const kTodoTable = 'todo';
const kTodoTableSql = "$kTodoTable ("
    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
    "description TEXT, "
    "is_done INTEGER, "
    "date TEXT,"
    "project_id INTEGER NOT NULL, "
    "FOREIGN KEY (project_id) "
    "REFERENCES $kProjectTable (id) "
    "ON UPDATE CASCADE "
    "ON DELETE CASCADE "
    ")";

const kProjectTable = 'project';
const kProjectTableSql = "$kProjectTable ("
    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
    "name TEXT"
    ")";

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

    final db = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
      onOpen: onOpen,
      onConfigure: onConfigure,
    );
    return db;
  }

  void onConfigure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON;');
  }

  void onOpen(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS $kProjectTableSql');
    await database.execute('CREATE TABLE IF NOT EXISTS $kTodoTableSql');
  }

  void onCreate(Database database, int version) async {
    await database.execute('CREATE TABLE $kProjectTableSql');
    await database.execute('CREATE TABLE $kTodoTableSql');
  }
}
