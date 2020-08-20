import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_now/data/models/project.dart';
import 'package:task_now/data/models/todo.dart';
import 'package:task_now/data/todo_repository.dart';

class TodoStateNotifier extends ChangeNotifier {
  TodoStateNotifier(this._repository) {
    _updateProjects();
  }

  final TodoRepository _repository;

  List<Project> _projects = [];
  List<Todo> _todos = [];
  Project _selectedProject;

  List<Project> get projects => _projects;
  List<Todo> get todos => _todos;
  Project get selectedProject => _selectedProject;

  void _updateTodos() async {
    _todos = await _repository.getTodosByProjectId(_selectedProject.id);

    notifyListeners();
  }

  void _updateProjects() async {
    _projects = await _repository.getAllProjects();

    if (_projects.isEmpty) {
      _addDefaultProject();
      _projects = await _repository.getAllProjects();
    }

    if (_selectedProject == null) {
      updateSelectedProject(_projects.first);
    } else {
      notifyListeners();
    }
  }

  void _addDefaultProject() async {
    final inbox = Project(name: 'Inbox', color: Colors.blue);
    await _repository.insertProject(inbox);
  }

  void updateSelectedProject(Project project) {
    if (_selectedProject != project) {
      _selectedProject = project;

      _updateTodos();
      notifyListeners();
    }
  }

  Future<bool> saveProject(Project project) async {
    var result;
    if (project.id == null) {
      result = await _repository.insertProject(project);
    } else {
      result = await _repository.updateProject(project);
    }

    _updateProjects();
    return result;
  }

  Future<bool> saveTodo(Todo todo) async {
    var result;
    if (todo.id == null) {
      result = await _repository.insertTodo(todo);
    } else {
      result = await _repository.updateTodo(todo);
    }

    _updateProjects();
    return result;
  }

  Future<bool> deleteTodoById(int id) async {
    final result = await _repository.deleteTodoById(id);

    _updateProjects();
    return result;
  }

  Future<bool> deleteProjectById(int id) async {
    final result = await _repository.deleteProjectById(id);

    _updateProjects();
    return result;
  }
}
