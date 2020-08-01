import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_now/data/todo.dart';
import 'package:task_now/todo_brain.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    @required this.todo,
  }) : assert(todo != null);

  final Todo todo;

  TextStyle _descriptionTextStyle() {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w800,
      decoration: todo.isDone ? TextDecoration.lineThrough : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final brain = Provider.of<TodoBrain>(context, listen: false);

    final Decoration decoration = BoxDecoration(
      border: Border(
        bottom: Divider.createBorderSide(context),
      ),
    );

    final todoIcon = todo.isDone
        ? Icon(Icons.check_box)
        : Icon(Icons.check_box_outline_blank);

    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Completed",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        color: Colors.green,
      ),
      onDismissed: (_) {
        todo.isDone = true;
        brain.updateTodo(todo);
      },
      key: ObjectKey(todo),
      child: Container(
        decoration: decoration,
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            InkWell(
              child: todoIcon,
              onTap: () {
                todo.toggleDone();
                brain.updateTodo(todo);
              },
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              todo.description,
              style: _descriptionTextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
