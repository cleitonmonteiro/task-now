import 'package:task_now/core/utils.dart';

class Todo {
  int id;
  String description;
  bool isDone;
  DateTime date;

  Todo({
    this.id,
    this.description,
    this.isDone = false,
    this.date,
  });

  factory Todo.fromJson(Map<String, dynamic> data) {
    return Todo(
      id: data['id'],
      description: data['description'],
      isDone: intToBool(data['is_done']),
      date: DateTime.parse(data['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'description': this.description,
      'is_done': this.isDone ? 1 : 0,
      'date': this.date.toString(),
    };
  }

  @override
  String toString() {
    return 'Todo {$description, $isDone}';
  }

  void toggleDone() {
    isDone = !isDone;
  }
}
