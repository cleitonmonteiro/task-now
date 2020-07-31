import 'package:task_now/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getAllTodos();
  Future<bool> insertTodo(Todo todo);
  Future<bool> deleteTodoById(int id);
  Future<bool> updateTodo(Todo todo);
  Future<bool> deleteAllTodos();
}
