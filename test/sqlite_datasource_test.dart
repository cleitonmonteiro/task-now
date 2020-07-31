import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_now/database.dart';
import 'package:task_now/sqlite_todo_repo_impl.dart';
import 'package:task_now/todo.dart';

class TestDatabaseProvider extends DatabaseProvider {
  TestDatabaseProvider() : super(name: 'test');

  @override
  Future<Database> createDatabase() async {
    sqfliteFfiInit();
    final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath,
        options: OpenDatabaseOptions(onCreate: super.onCreate, version: 1));
    return db;
  }
}

void main() {
  SqliteTodoRepoImpl datasource;
  DatabaseProvider databaseProvider;

  setUp(() {
    databaseProvider = TestDatabaseProvider();
    datasource = SqliteTodoRepoImpl(databaseProvider);
  });

  tearDown(() async {
    await datasource.deleteAllTodos();
  });

  test('should add a new todo', () async {
    final tTodo = Todo(description: 'Read many book');

    final result = await datasource.insertTodo(tTodo);

    expect(result, true);
  });

  test('should get all todos', () async {
    final tTodos = [
      Todo(description: 'Read many book'),
      Todo(description: 'Read another book'),
      Todo(description: 'Start linux shell')
    ];

    for (var todo in tTodos) {
      final inserted = await datasource.insertTodo(todo);
      expect(inserted, true);
    }

    final result = await datasource.getAllTodos();

    expect(result.length, isNonZero);
    //TODO: vericicar todos sem id se sao iguais
  });

  test('should delete a todo by id', () async {
    final tTodo = Todo(description: 'Read many book');

    final inserted = await datasource.insertTodo(tTodo);

    expect(inserted, true);

    final todos = await datasource.getAllTodos();
    final id = todos.first.id;
    final result = await datasource.deleteTodoById(id);

    expect(result, true);
  });

  test('should dont delete a todo by wrong id', () async {
    final tTodo = Todo(description: 'Read many book');

    final inserted = await datasource.insertTodo(tTodo);

    expect(inserted, true);

    final todos = await datasource.getAllTodos();
    final fakeId = todos.first.id + 1;
    final result = await datasource.deleteTodoById(fakeId);

    expect(result, false);
  });
}
