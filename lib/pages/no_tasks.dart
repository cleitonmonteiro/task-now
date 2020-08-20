import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_now/app_theme_notifier.dart';

class NoTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 8;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<AppThemeNotifier>(
          builder: (context, appState, child) => Opacity(
            opacity: appState.isDarkModeOn ? 0.4 : 0.1,
            child: Image.asset(
              'images/coffee_cup.png',
              fit: BoxFit.contain,
              height: height,
            ),
          ),
        ),
        SizedBox(height: height / 3),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'All done. Perfect job!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text('Take a break and have a coffee.'),
              SizedBox(height: 10.0),
              Text('Tap + to add a new task.'),
            ],
          ),
        ),
      ],
    );
  }
}
