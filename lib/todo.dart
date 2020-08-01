import 'package:task_now/utils.dart';

class Todo {
  int id;
  String description;
  bool isDone;

  Todo({
    this.id,
    this.description,
    this.isDone = false,
  });

  factory Todo.fromJson(Map<String, dynamic> data) {
    return Todo(
      id: data['id'],
      description: data['description'],
      isDone: intToBool(data['is_done']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "description": this.description,
      "is_done": this.isDone ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'Todo {$description, $isDone}';
  }
}
