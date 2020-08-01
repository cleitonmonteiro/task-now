import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_now/data/database.dart';
import 'package:task_now/data/sqlite_todo_repo_impl.dart';
import 'package:task_now/todo_brain.dart';
import 'package:task_now/pages/home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoBrain>(
      create: (context) => TodoBrain(SqliteTodoRepoImpl(DatabaseProvider())),
      child: MaterialApp(
        title: 'Task Now',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonColor: Colors.green,
          buttonTheme: ButtonThemeData().copyWith(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            minWidth: 30.0,
            height: 30.0,
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
