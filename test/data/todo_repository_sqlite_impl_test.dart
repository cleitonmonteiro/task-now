import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_now/data/database_sqlite.dart';
import 'package:task_now/data/models/project.dart';
import 'package:task_now/data/todo_repository_sqlite_impl.dart';
import 'package:task_now/data/models/todo.dart';

class TestDatabaseProvider extends DatabaseProviderSqlite {
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
  TodoRepositorySqliteImpl repo;
  DatabaseProviderSqlite databaseProvider;

  setUp(() async {
    databaseProvider = TestDatabaseProvider();
    repo = TodoRepositorySqliteImpl(databaseProvider);
  });

  final tProjects = [
    Project(name: 'Inbox', color: Colors.red),
    Project(name: 'Task Now', color: Colors.blue),
    Project(name: 'Camali', color: Colors.green),
  ];

  group('Projects', () {
    tearDown(() async {
      await repo.deleteAllProjects();
    });

    test('should add a new project', () async {
      final result = await repo.insertProject(tProjects.first);

      expect(result, true);
    });

    test('should get all projects', () async {
      for (var project in tProjects) {
        final inserted = await repo.insertProject(project);
        expect(inserted, true);
      }

      final result = await repo.getAllProjects();

      expect(result.length, tProjects.length);
      expect(
        tProjects.map((e) => e.toString()),
        result.map((e) => e.toString()),
      );
    });

    test('should delete all projects', () async {
      for (var project in tProjects) {
        final inserted = await repo.insertProject(project);
        expect(inserted, true);
      }

      final result = await repo.deleteAllProjects();

      expect(result, true);

      final projects = await repo.getAllProjects();

      expect(projects.length, isZero);
    });

    test('should delete a project by id', () async {
      final inserted = await repo.insertProject(tProjects.first);

      expect(inserted, true);

      final projects = await repo.getAllProjects();
      expect(projects.length, 1);

      final id = projects.first.id;

      final result = await repo.deleteProjectById(id);

      expect(result, true);
    });

    test('should dont delete a project by wrong id', () async {
      final inserted = await repo.insertProject(tProjects.first);

      expect(inserted, true);

      final projects = await repo.getAllProjects();
      expect(projects.length, 1);

      final fakeId = projects.first.id + 1;

      final result = await repo.deleteProjectById(fakeId);

      expect(result, false);
    });

    test('should update a project', () async {
      var tProject = Project(name: 'Mail', color: Colors.blueAccent);

      final insertedOk = await repo.insertProject(tProject);
      expect(insertedOk, true);

      var projects = await repo.getAllProjects();
      final inserted = projects.first;

      final newName = 'Mail 2';

      inserted.name = newName;
      final updatedOk = await repo.updateProject(inserted);

      expect(updatedOk, true);

      projects = await repo.getAllProjects();

      expect(projects.first.name, newName);
    });
  });

  group('Todos', () {
    Project tInsertedProject;
    List<Todo> tTodos;

    List<Todo> initTodos(int projectId, DateTime date) {
      return [
        Todo(
          projectId: projectId,
          description: 'Read many book',
          date: date,
        ),
        Todo(
          projectId: projectId,
          description: 'Read another book',
          date: date,
        ),
        Todo(
          projectId: projectId,
          description: 'Start linux shell',
          date: date,
        )
      ];
    }

    setUp(() async {
      await repo.insertProject(tProjects.first);
      final projects = await repo.getAllProjects();
      tInsertedProject = projects.first;

      final date = DateTime.now().add(Duration(hours: 2));
      tTodos = initTodos(tInsertedProject.id, date);
    });

    tearDown(() async {
      await repo.deleteAllTodos();
    });

    test('should add a new todo', () async {
      final tTodo = Todo(
        description: 'Read many book',
        projectId: tInsertedProject.id,
      );

      final result = await repo.insertTodo(tTodo);

      expect(result, true);
    });

    test('should delete all todos', () async {
      for (var todo in tTodos) {
        final inserted = await repo.insertTodo(todo);
        expect(inserted, true);
      }

      final result = await repo.deleteAllTodos();

      expect(result, true);

      final todos = await repo.getAllTodos();

      expect(todos.length, 0);
    });

    test('should delete a todo by id', () async {
      final inserted = await repo.insertTodo(tTodos.first);

      expect(inserted, true);

      final todos = await repo.getAllTodos();
      final id = todos.first.id;
      final result = await repo.deleteTodoById(id);

      expect(result, true);
    });

    test('should dont delete a todo by wrong id', () async {
      final inserted = await repo.insertTodo(tTodos.first);

      expect(inserted, true);

      final todos = await repo.getAllTodos();
      final fakeId = todos.first.id + 1;
      final result = await repo.deleteTodoById(fakeId);

      expect(result, false);
    });

    test('should update a todo', () async {
      final insertedOk = await repo.insertTodo(tTodos.first);
      expect(insertedOk, true);

      var todos = await repo.getAllTodos();
      final inserted = todos.first;

      final newDescription = 'make it works';

      inserted.description = newDescription;
      final updatedOk = await repo.updateTodo(inserted);

      expect(updatedOk, true);

      todos = await repo.getAllTodos();

      expect(todos.first.description, newDescription);
    });

    test('should get all todos by project id', () async {
      for (var todo in tTodos) {
        final inserted = await repo.insertTodo(todo);
        expect(inserted, true);
      }

      final todos = await repo.getTodosByProjectId(tInsertedProject.id);

      expect(todos.length, tTodos.length);

      for (var i = 0; i < todos.length; i++) {
        expect(todos[i].description, tTodos[i].description);
        expect(todos[i].date, tTodos[i].date);
        expect(todos[i].isDone, tTodos[i].isDone);
        expect(todos[i].projectId, tTodos[i].projectId);
      }
    });
  });
}
