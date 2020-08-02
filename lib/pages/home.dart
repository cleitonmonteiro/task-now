import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:task_now/todo_brain.dart';
import 'package:task_now/widgets/add_todo_bottom_sheet.dart';
import 'package:task_now/widgets/todo_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Today',
          style: TextStyle().copyWith(color: Colors.white),
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Username'),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<TodoBrain>(
          builder: (context, brain, _) => TodoListView(brain.todos),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
