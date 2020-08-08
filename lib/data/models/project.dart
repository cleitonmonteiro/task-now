import 'dart:ui';

import 'package:task_now/data/models/todo.dart';

class Project {
  Project({this.id, this.name, this.color});

  int id;
  String name;
  Color color;
  List<Todo> todos;

  factory Project.fromJson(Map<String, dynamic> data) {
    return Project(
      id: data['id'],
      name: data['name'],
      color: Color(data['color']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
    };
  }

  @override
  String toString() {
    return 'Project {$name}';
  }
}
