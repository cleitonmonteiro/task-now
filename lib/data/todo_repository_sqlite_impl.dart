import 'package:sqflite/utils/utils.dart';
import 'package:task_now/data/database_sqlite.dart';
import 'package:task_now/data/models/project.dart';
import 'package:task_now/data/models/todo.dart';
import 'package:task_now/data/todo_repository.dart';
import 'package:task_now/core/utils.dart';

class TodoRepositorySqliteImpl implements TodoRepository {
  TodoRepositorySqliteImpl(this.dbProvider);

  final DatabaseProviderSqlite dbProvider;

  @override
  Future<List<Todo>> getAllTodos() async {
    final db = await dbProvider.database;

    final result = await db.query(kTodoTable);
    final todos = result.map((todoJson) => Todo.fromJson(todoJson)).toList();

    return todos;
  }

  @override
  Future<bool> deleteTodoById(int id) async {
    final db = await dbProvider.database;

    final result =
        await db.delete(kTodoTable, where: 'id = ?', whereArgs: [id]);

    return intToBool(result);
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

  @override
  Future<bool> deleteAllProjects() async {
    final db = await dbProvider.database;

    final result = await db.delete(kProjectTable);

    return intToBool(result);
  }

  @override
  Future<bool> deleteProjectById(int id) async {
    final db = await dbProvider.database;

    final result =
        await db.delete(kProjectTable, where: 'id = ?', whereArgs: [id]);

    return intToBool(result);
  }

  @override
  Future<List<Project>> getAllProjects() async {
    final db = await dbProvider.database;

    final result = await db.query(kProjectTable);
    final projects = result.map((projectJson) => Project.fromJson(projectJson));

    List<Project> fullProjects = [];
    for (var project in projects) {
      final count = await db.rawQuery(
          'SELECT COUNT(*) FROM $kTodoTable WHERE id = ${project.id}');

      project.length = firstIntValue(count);
      fullProjects.add(project);
    }

    return fullProjects;
  }

  @override
  Future<bool> insertProject(Project project) async {
    final db = await dbProvider.database;

    final result = await db.insert(kProjectTable, project.toJson());
    return intToBool(result);
  }

  @override
  Future<bool> updateProject(Project project) async {
    final db = await dbProvider.database;

    final result = await db.update(kProjectTable, project.toJson(),
        where: 'id = ?', whereArgs: [project.id]);

    return intToBool(result);
  }

  @override
  Future<List<Todo>> getTodosByProjectId(int projectId) async {
    final db = await dbProvider.database;

    final result = await db
        .query(kTodoTable, where: 'project_id = ?', whereArgs: [projectId]);

    final todos = result.map((todoJson) => Todo.fromJson(todoJson)).toList();
    return todos;
  }
}
