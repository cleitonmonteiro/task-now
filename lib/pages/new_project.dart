import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_now/data/models/project.dart';
import 'package:task_now/todo_brain.dart';

class NewProjectPage extends StatefulWidget {
  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final projectsColors = [
    _CustomColor(Colors.blueAccent, 'Blue Accent'),
    _CustomColor(Colors.red, 'Red'),
    _CustomColor(Colors.orange, 'Orange'),
    _CustomColor(Colors.amber, 'Amber'),
    _CustomColor(Colors.brown, 'Brown'),
    _CustomColor(Colors.green, 'Green'),
  ];

  String _projectName;
  _CustomColor _projectColor;
  bool _enableSave = false;

  @override
  void initState() {
    super.initState();
    _projectColor = projectsColors.first;
  }

  void _save() async {
    final newProject = Project(name: _projectName, color: _projectColor.color);
    final brain = Provider.of<TodoBrain>(context, listen: false);

    await brain.addProject(newProject);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add project'),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _enableSave ? _save : null,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              cursorColor: Theme.of(context).accentColor,
              onChanged: (value) {
                _projectName = value;

                if (_projectName.isNotEmpty != _enableSave) {
                  setState(() => _enableSave = !_enableSave);
                }
              },
              autofocus: true,
              style: TextStyle(height: 1.6),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 10.0),
            DropdownButton<_CustomColor>(
              isExpanded: true,
              value: _projectColor,
              onChanged: (color) {
                if (color != _projectColor) {
                  setState(() => _projectColor = color);
                }
              },
              items: projectsColors.map((color) {
                return DropdownMenuItem<_CustomColor>(
                  value: color,
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.brightness_1,
                          color: color.color,
                          size: 18.0,
                        ),
                        SizedBox(width: 16.0),
                        Text(color.name),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomColor {
  _CustomColor(this.color, this.name);

  final Color color;
  final String name;
}
