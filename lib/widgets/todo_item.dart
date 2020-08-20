import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_now/core/utils.dart';
import 'package:task_now/data/models/todo.dart';
import 'package:task_now/todo_state_notifier.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    @required this.todo,
  }) : assert(todo != null);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final brain = Provider.of<TodoStateNotifier>(context, listen: false);

    final Decoration decoration = BoxDecoration(
      border: Border(bottom: Divider.createBorderSide(context)),
    );

    final _descriptionTextStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w800,
      decoration: todo.isDone ? TextDecoration.lineThrough : null,
    );

    final _detailsTextStyle = TextStyle(
      decoration: todo.isDone ? TextDecoration.lineThrough : null,
    );

    final todoIcon = todo.isDone
        ? Icon(Icons.done, color: Colors.green)
        : Icon(Icons.radio_button_unchecked);

    final body = Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(todo.description, style: _descriptionTextStyle),
          SizedBox(height: 5.0),
          Row(
            children: <Widget>[
              Icon(
                Icons.event,
                size: 18.0,
                color: Theme.of(context).textTheme.headline6.color,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Text(
                  formatDateTime(todo.date, context),
                  style: _detailsTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: const Text("Completed"),
          ),
        ),
        color: Colors.green,
      ),
      onDismissed: (_) {
        todo.isDone = true;
        brain.saveTodo(todo);
      },
      key: ObjectKey(todo),
      child: Container(
        decoration: decoration,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: todoIcon,
              onTap: () {
                todo.toggleDone();
                brain.saveTodo(todo);
              },
            ),
            body
          ],
        ),
      ),
    );
  }
}
