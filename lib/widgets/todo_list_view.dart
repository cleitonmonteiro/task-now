import 'package:flutter/material.dart';
import 'package:task_now/data/todo.dart';
import 'package:task_now/widgets/todo_item.dart';

class TodoListView extends StatelessWidget {
  const TodoListView(this.todos);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (context, index) => TodoItem(todo: todos[index]),
    );
  }
}
