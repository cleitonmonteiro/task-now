import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:task_now/app_theme_notifier.dart';
import 'package:task_now/data/models/project.dart';
import 'package:task_now/pages/loading.dart';
import 'package:task_now/pages/new_project.dart';
import 'package:task_now/pages/no_tasks.dart';
import 'package:task_now/todo_state_notifier.dart';
import 'package:task_now/widgets/add_todo_bottom_sheet.dart';
import 'package:task_now/widgets/project_list_view.dart';
import 'package:task_now/widgets/todo_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoStateNotifier>(
      builder: (context, controller, child) {
        if (controller.selectedProject == null) {
          return LoadingPage();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(controller.selectedProject.name),
            actions: <Widget>[
              Consumer<AppThemeNotifier>(
                builder: (context, theme, child) => Switch(
                  value: theme.isDarkModeOn,
                  onChanged: (value) {
                    theme.updateTheme(value);
                  },
                ),
              ),
              Icon(Icons.brightness_3),
            ],
          ),
          drawer: Drawer(
            child: DecoratedBox(
              decoration:
                  BoxDecoration(color: Theme.of(context).backgroundColor),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).padding.top,
                    color: Theme.of(context).primaryColor,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.list,
                          size: 28.0,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                        const SizedBox(width: 16.0),
                        const Text(
                          'Projects',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.add, size: 28.0),
                          onPressed: () => _addNewProject(context),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 0.0),
                  ProjectListView(
                    projects: controller.projects,
                    selectedProject: controller.selectedProject,
                    onTapCallback: (project) async {
                      controller.updateSelectedProject(project);
                      Navigator.pop(context);
                    },
                  ),
                  _RowButton(
                    onTap: () => _addNewProject(context),
                    children: const [
                      Icon(Icons.add, size: 18.0),
                      SizedBox(width: 16.0),
                      Text('Add project'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: controller.todos.isEmpty
              ? NoTasksPage()
              : SingleChildScrollView(
                  child: TodoListView(controller.todos),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              _showAddTodoSheet(context, controller.projects.first);
            },
            child: Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }

  void _addNewProject(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewProjectPage(),
      ),
    );
  }

  void _showAddTodoSheet(BuildContext context, Project defaultProject) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => AddTodoBottomSheet(defaultProject),
    );
  }
}

class _RowButton extends StatelessWidget {
  const _RowButton({
    @required this.onTap,
    @required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
    this.backgroundColor,
  })  : assert(onTap != null),
        assert(children != null);

  final Function onTap;
  final List<Widget> children;
  final EdgeInsets padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        color: backgroundColor ?? Theme.of(context).backgroundColor,
        child: Row(
          children: children,
        ),
      ),
    );
  }
}
