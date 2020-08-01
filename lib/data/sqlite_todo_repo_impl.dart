import 'package:task_now/data/database.dart';
import 'package:task_now/data/todo.dart';
import 'package:task_now/data/todo_repo.dart';
import 'package:task_now/core/utils.dart';

class SqliteTodoRepoImpl implements TodoRepo {
  SqliteTodoRepoImpl(this.dbProvider);

  final DatabaseProvider dbProvider;

  @override
  Future<bool> deleteTodoById(int id) async {
    final db = await dbProvider.database;

    final result =
        await db.delete(kTodoTable, where: 'id = ?', whereArgs: [id]);

    return intToBool(result);
  }

  @override
  Future<List<Todo>> getAllTodos() async {
    final db = await dbProvider.database;

    final result = await db.query(kTodoTable);
    final todos = result.map((todoJson) => Todo.fromJson(todoJson));
    return todos.toList();
  }

  @override
  Future<bool> insertTodo(Todo todo) async {
    final db = await dbProvider.database;

    final result = await db.insert(kTodoTable, todo.toJson());
    return intToBool(result);
  }

  @override
  Future<bool> updateTodo(Todo todo) async {
    final db = await dbProvider.database;

    final result = await db.update(kTodoTable, todo.toJson(),
        where: 'id = ?', whereArgs: [todo.id]);

    return intToBool(result);
  }

  @override
  Future<bool> deleteAllTodos() async {
    final db = await dbProvider.database;

    final result = await db.delete(kTodoTable);

    return intToBool(result);
  }
}
