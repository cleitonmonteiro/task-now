import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_now/data/models/project.dart';
import 'package:task_now/data/models/todo.dart';
import 'package:task_now/data/todo_repo.dart';

class TodoBrain extends ChangeNotifier {
  TodoBrain(this.repo) {
    updateProjects();
  }

  final TodoRepo repo;
  List<Project> projects = [];
  Project selectedProject;

  void updateProjects() async {
    projects = await repo.getAllProjects();

    if (projects.isEmpty) {
      final inbox = Project(name: 'Inbox', color: Colors.blue);
      await repo.insertProject(inbox);
      projects = await repo.getAllProjects();
    }

    if (selectedProject == null) {
      selectedProject = projects.first;
    }

    notifyListeners();
  }

  void updateSelectedProject(Project project) {
    if (selectedProject != project) {
      selectedProject = project;
      notifyListeners();
    }
  }

  Future<bool> addTodo(Todo todo) async {
    final result = await repo.insertTodo(todo);

    updateProjects();
    return result;
  }

  Future<bool> deleteTodoById(int id) async {
    final result = await repo.deleteTodoById(id);

    updateProjects();
    return result;
  }

  Future<bool> updateTodo(Todo todo) async {
    final result = await repo.updateTodo(todo);

    updateProjects();
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
    return result;
  }

  Future<bool> updateProject(Project project) async {
    final result = await repo.updateProject(project);

    updateProjects();
    return result;
  }
}
