import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:task_now/pages/new_project.dart';
import 'package:task_now/pages/no_tasks.dart';
import 'package:task_now/todo_brain.dart';
import 'package:task_now/widgets/add_todo_bottom_sheet.dart';
import 'package:task_now/widgets/project_item.dart';
import 'package:task_now/widgets/todo_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBrain>(
      builder: (context, brain, child) {
        if (brain.selectedProject == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              brain.selectedProject.name,
              style: TextStyle().copyWith(color: Colors.white),
            ),
            iconTheme: Theme.of(context).iconTheme,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                // TODO: DrawerHeader
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                // TODO: button para adicionar um novo porjeto
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.list,
                        size: 28.0,
                        color: Colors.black,
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
                        icon: Icon(
                          Icons.add,
                          size: 28.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewProjectPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Divider(height: 0.0),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: brain.projects.length,
                  itemBuilder: (context, index) {
                    final project = brain.projects[index];
                    return ProjectItem(
                      project: project,
                      onTap: () async {
                        brain.updateSelectedProject(project);
                        Navigator.pop(context);
                      },
                      selected: project == brain.selectedProject,
                    );
                  },
                ),
              ],
            ),
          ),
          body: brain.selectedProject.todos.length == 0
              ? NoTasksPage()
              : SingleChildScrollView(
                  child: TodoListView(brain.selectedProject.todos),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              _showAddTodoSheet(context);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  void _showAddTodoSheet(BuildContext context) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => AddTodoBottomSheet(),
    );
  }
}
