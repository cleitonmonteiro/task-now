import 'package:task_now/core/utils.dart';
import 'package:meta/meta.dart';

class Todo {
  int id;
  String description;
  bool isDone;
  DateTime date;
  int projectId;

  Todo({
    this.id,
    this.description,
    this.isDone = false,
    this.date,
    @required this.projectId,
  }) : assert(projectId != null);

  factory Todo.fromJson(Map<String, dynamic> data) {
    return Todo(
      id: data['id'],
      description: data['description'],
      isDone: intToBool(data['is_done']),
      date: DateTime.parse(data['date']),
      projectId: data['project_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'description': this.description,
      'is_done': this.isDone ? 1 : 0,
      'date': this.date.toString(),
      'project_id': projectId,
    };
  }

  @override
  String toString() {
    return 'Todo {$description, $isDone, $projectId}';
  }

  void toggleDone() {
    isDone = !isDone;
  }
}
