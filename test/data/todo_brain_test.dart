import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_now/data/models/project.dart';
import 'package:task_now/data/models/todo.dart';
import 'package:task_now/todo_brain.dart';
import 'package:task_now/data/todo_repo.dart';

class MockTodoRepo extends Mock implements TodoRepo {}

void main() {
  final tTodos = [
    Todo(description: 'Meet George', isDone: true, projectId: 1),
    Todo(description: 'Buy eggs', projectId: 1),
    Todo(description: 'Read a book', projectId: 1),
  ];

  final tProjects = [
    Project(name: 'Inbox'),
    Project(name: 'Task Now'),
    Project(name: 'Camali'),
  ];

  MockTodoRepo repo;
  TodoBrain brain;

  setUp(() {
    repo = MockTodoRepo();
    when(repo.getAllTodos()).thenAnswer((_) => Future.value(tTodos));
    when(repo.getAllProjects()).thenAnswer((_) => Future.value(tProjects));
    brain = TodoBrain(repo);
  });

  group('Projects', () {
    test('should get a list of projects', () async {
      final projects = brain.projects;

      verify(repo.getAllProjects());

      expect(projects, tProjects);
    });

    test('should insert a new project', () async {
      final newProject = Project(name: 'Inbox');
      when(repo.insertProject(newProject))
          .thenAnswer((_) => Future.value(true));

      final result = await brain.addProject(newProject);
      verify(repo.insertProject(newProject));
      expect(result, true);
    });

    test('should update a project', () async {
      final newProject = Project(name: 'Inbox');
      when(repo.updateProject(newProject))
          .thenAnswer((_) => Future.value(true));

      final result = await brain.updateProject(newProject);
      verify(repo.updateProject(newProject));
      expect(result, true);
    });

    test('should remove a project by id', () async {
      final newProject = Project(name: 'Inbox', id: 10);
      when(repo.updateProject(newProject))
          .thenAnswer((_) => Future.value(true));

      when(repo.deleteProjectById(newProject.id))
          .thenAnswer((_) => Future.value(true));

      final result = await brain.deleteProjectById(newProject.id);
      verify(repo.deleteProjectById(newProject.id));
      expect(result, true);
    });
  });

  group('Todos', () {
    test('should get a list of todos', () async {
      final todos = brain.todos;

      verify(repo.getAllTodos());

      expect(todos, tTodos);
    });

    test('should insert a new todo', () async {
      final newTodo = Todo(description: 'Organize office', projectId: 1);
      when(repo.insertTodo(newTodo)).thenAnswer((_) => Future.value(true));

      final result = await brain.addTodo(newTodo);
      verify(repo.insertTodo(newTodo));
      expect(result, true);
    });

    test('should update a todo', () async {
      final newTodo = Todo(description: 'Organize office', projectId: 1);
      when(repo.updateTodo(newTodo)).thenAnswer((_) => Future.value(true));

      final result = await brain.updateTodo(newTodo);
      verify(repo.updateTodo(newTodo));
      expect(result, true);
    });

    test('should remove a todo by id', () async {
      final newTodo = Todo(description: 'Organize office', id: 1, projectId: 1);
      when(repo.deleteTodoById(newTodo.id))
          .thenAnswer((_) => Future.value(true));

      final result = await brain.deleteTodoById(newTodo.id);
      verify(repo.deleteTodoById(newTodo.id));
      expect(result, true);
    });
  });
}
