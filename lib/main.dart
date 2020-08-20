import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_now/app_theme_notifier.dart';
import 'package:task_now/app_theme.dart';
import 'package:task_now/pages/home.dart';
import 'package:task_now/todo_state_notifier.dart';

import 'injection_container.dart' as di;

void main() async {
  await di.setup();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppThemeNotifier>(create: (context) => di.sl()),
        ChangeNotifierProvider<TodoStateNotifier>(create: (context) => di.sl())
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Now',
        theme: AppTheme.getLightTheme(context),
        darkTheme: AppTheme.getDarkTheme(context),
        themeMode: Provider.of<AppThemeNotifier>(context).isDarkModeOn
            ? ThemeMode.dark
            : ThemeMode.light,
        home: HomePage(),
      ),
    );
  }
}
