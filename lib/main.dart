import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_now/app_state_notifier.dart';
import 'package:task_now/app_theme.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateNotifier>(
          create: (_) => AppStateNotifier(),
        ),
        ChangeNotifierProvider<TodoBrain>(
          create: (_) => TodoBrain(SqliteTodoRepoImpl(DatabaseProvider())),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Now',
        theme: AppTheme.getLightTheme(context),
        darkTheme: AppTheme.getDarkTheme(context),
        themeMode: Provider.of<AppStateNotifier>(context).isDarkModeOn
            ? ThemeMode.dark
            : ThemeMode.light,
        home: HomePage(),
      ),
    );
  }
}
