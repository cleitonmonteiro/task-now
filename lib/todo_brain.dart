import 'package:flutter/foundation.dart';
import 'package:task_now/data/models/project.dart';
import 'package:task_now/data/models/todo.dart';
import 'package:task_now/data/todo_repo.dart';

class TodoBrain extends ChangeNotifier {
  TodoBrain(this.repo) {
    updateTodos();
    updateProjects();
  }

  final TodoRepo repo;
  List<Todo> _todos = [];
  List<Project> _projects;

  List<Todo> get todos => _todos;
  List<Project> get projects => _projects;

  void updateTodos() async {
    _todos = await repo.getAllTodos();
    notifyListeners();
  }

  void updateProjects() async {
    _projects = await repo.getAllProjects();
    notifyListeners();
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

  Future<bool> addProject(Project project) async {
    final result = await repo.insertProject(project);

    updateProjects();
    return result;
  }

  Future<bool> deleteProjectById(int id) async {
    final result = await repo.deleteProjectById(id);

    updateProjects();
    updateTodos();
    return result;
  }

  Future<bool> updateProject(Project project) async {
    final result = await repo.updateProject(project);

    updateProjects();
    return result;
  }
}
