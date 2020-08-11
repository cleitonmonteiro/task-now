import 'package:flutter/material.dart';
import 'package:task_now/data/models/project.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    @required this.project,
    @required this.onTap,
    this.selected = false,
  })  : assert(project != null),
        assert(onTap != null);

  final Project project;
  final Function onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).selectedRowColor
        : Theme.of(context).backgroundColor;

    var trailing = <Widget>[];
    if (project.todos.isNotEmpty) {
      trailing = [
        Spacer(),
        Text(project.todos.length.toString()),
      ];
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        color: color,
        child: Row(
          children: [
            Icon(
              Icons.brightness_1,
              color: project.color,
              size: 18.0,
            ),
            SizedBox(width: 16.0),
            Text(project.name),
            ...trailing,
          ],
        ),
      ),
    );
  }
}
