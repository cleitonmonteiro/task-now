import 'package:flutter/material.dart';
import 'package:task_now/data/models/project.dart';
import 'package:task_now/widgets/project_item.dart';

class ProjectListView extends StatelessWidget {
  const ProjectListView({
    @required this.projects,
    @required this.selectedProject,
    @required this.onTapCallback,
  })  : assert(projects != null),
        assert(onTapCallback != null);

  final List<Project> projects;
  final Function onTapCallback;
  final Project selectedProject;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];

        return ProjectItem(
          project: project,
          onTap: () => onTapCallback(project),
          selected: project.id == selectedProject.id,
        );
      },
    );
  }
}
