import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_now/core/utils.dart';
import 'package:task_now/data/todo.dart';
import 'package:task_now/todo_brain.dart';
import 'package:task_now/widgets/datetime_picker_dialog.dart';

class AddTodoBottomSheet extends StatefulWidget {
  @override
  _AddTodoBottomSheetState createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  String _description;
  DateTime _date;
  bool _enableSave = false;

  @override
  void initState() {
    super.initState();
    _date = _defaultDate;
  }

  DateTime get _defaultDate => DateTime.now().add(Duration(hours: 2));

  String get _dateButtomText => isToday(_date) ? 'Today' : formatDate(_date);

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
                  setState(() => _enableSave = !_enableSave);
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
                  onPressed: _showDateTimeDialog,
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
                          _dateButtomText,
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
    final newTodo = Todo(description: _description, date: _date);
    final brain = Provider.of<TodoBrain>(context, listen: false);
    await brain.addTodo(newTodo);
    Navigator.pop(context);
  }

  void _showDateTimeDialog() async {
    final now = DateTime.now();
    final selectedDate = await showDatetimePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
    );

    if (selectedDate != null) {
      setState(() => _date = selectedDate);
    }
  }
}
