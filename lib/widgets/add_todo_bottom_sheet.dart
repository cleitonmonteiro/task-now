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
  DateTime date;
  bool _enableSave = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
              cursorColor: Theme.of(context).accentColor,
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
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: 'New task',
              ),
            ),
            Row(
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    showMD(context);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.event_available,
                        size: 18.0,
                        color: Theme.of(context).accentColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.0),
                        child: Text(
                          'Today',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: OutlineButton(
                    onPressed: () {
                      //TODO: Selecionar projeto da tarefa
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.brightness_1,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 7.0),
                          child: Text('Inbox'),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  onPressed: _enableSave ? _save : null,
                  child: Text(
                    'Save',
                  ),
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

  Future<DateTime> showMD(BuildContext context) async {
    final now = DateTime.now();
    date = now;
    final dialog = Dialog(
      child: CalendarDatePicker(
        initialDate: date,
        firstDate: DateTime(now.year - 2),
        lastDate: DateTime(now.year + 2),
        onDateChanged: (value) {
          setState(() {
            date = value;
          });
        },
      ),
    );

    return await showDialog<DateTime>(
      context: context,
      builder: (context) => dialog,
    );
  }
}
