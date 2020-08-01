import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_now/data/todo.dart';
import 'package:task_now/todo_brain.dart';
import 'package:task_now/data/todo_repo.dart';

class MockTodoRepo extends Mock implements TodoRepo {}

void main() {
  final mTodos = [
    Todo(description: 'Meet George', isDone: true),
    Todo(description: 'Buy eggs'),
    Todo(description: 'Read a book'),
  ];

  MockTodoRepo repo;
  TodoBrain brain;

  setUp(() {
    repo = MockTodoRepo();
    when(repo.getAllTodos()).thenAnswer((_) => Future.value(mTodos));
    brain = TodoBrain(repo);
  });

  test('should get a list of todos', () async {
    final todos = brain.todos;

    verify(repo.getAllTodos());

    expect(todos, mTodos);
  });

  test('should insert a new todo', () async {
    final newTodo = Todo(description: 'Organize office');
    when(repo.insertTodo(newTodo)).thenAnswer((_) => Future.value(true));

    final result = await brain.addTodo(newTodo);
    verify(repo.insertTodo(newTodo));
    expect(result, true);
  });

  test('should update a todo', () async {
    final newTodo = Todo(description: 'Organize office');
    when(repo.updateTodo(newTodo)).thenAnswer((_) => Future.value(true));

    final result = await brain.updateTodo(newTodo);
    verify(repo.updateTodo(newTodo));
    expect(result, true);
  });

  test('should remove a todo by id', () async {
    final newTodo = Todo(description: 'Organize office', id: 1);
    when(repo.deleteTodoById(newTodo.id)).thenAnswer((_) => Future.value(true));

    final result = await brain.deleteTodoById(newTodo.id);
    verify(repo.deleteTodoById(newTodo.id));
    expect(result, true);
  });
}
