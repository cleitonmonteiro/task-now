import 'package:flutter/foundation.dart';
import 'package:task_now/todo.dart';
import 'package:task_now/todo_repo.dart';

class TodoBrain extends ChangeNotifier {
  TodoBrain(this.repo) {
    updateTodos();
  }

  final TodoRepo repo;
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void updateTodos() async {
    _todos = await repo.getAllTodos();
  }

  Future<bool> addTodo(Todo todo) async {
    final result = await repo.insertTodo(todo);

    updateTodos();
    return result;
  }

  Future<bool> deleteTodoById(int id) async {
    final result = await repo.deleteTodoById(id);

    updateTodos();
    return result;
  }

  Future<bool> updateTodo(Todo todo) async {
    final result = await repo.updateTodo(todo);

    updateTodos();
    return result;
  }
}
