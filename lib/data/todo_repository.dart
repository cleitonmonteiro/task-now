import 'package:task_now/data/models/project.dart';
import 'package:task_now/data/models/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getAllTodos();
  Future<bool> insertTodo(Todo todo);
  Future<bool> deleteTodoById(int id);
  Future<bool> updateTodo(Todo todo);
  Future<bool> deleteAllTodos();

  Future<List<Project>> getAllProjects();
  Future<bool> insertProject(Project project);
  Future<bool> deleteProjectById(int id);
  Future<bool> updateProject(Project project);
  Future<bool> deleteAllProjects();

  Future<List<Todo>> getTodosByProjectId(int projectId);
}
