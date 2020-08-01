import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_now/data/todo.dart';
import 'package:task_now/todo_brain.dart';

class AddTodoBottomSheet extends StatefulWidget {
  @override
  _AddTodoBottomSheetState createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  String _description;
  bool _enableSave = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                //TODO: implementar vericacao de mudanca antes de alterar
                _description = value;

                if (_description.isNotEmpty != _enableSave) {
                  setState(() {
                    _enableSave = !_enableSave;
                  });
                }
              },
              maxLines: 3,
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
                border: InputBorder.none,
                hintText: 'New task',
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    //TODO: Selecionar date e hora
                  },
                  child: Icon(Icons.event_available),
                ),
                Spacer(),
                FlatButton(
                  onPressed: _enableSave ? _save : null,
                  child: const Text('Save'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _save() async {
    final newTodo = Todo(description: _description);
    final brain = Provider.of<TodoBrain>(context, listen: false);
    await brain.addTodo(newTodo);
    Navigator.pop(context);
  }
}
