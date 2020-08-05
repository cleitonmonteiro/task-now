import 'package:task_now/data/models/todo.dart';

class Project {
  Project({this.id, this.name});

  int id;
  String name;
  List<Todo> todos;

  factory Project.fromJson(Map<String, dynamic> data) {
    return Project(
      id: data['id'],
      name: data['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Project {$name}';
  }
}
