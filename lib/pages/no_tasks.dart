import 'package:flutter/material.dart';

class NoTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 8;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0.1,
          child: Image.asset(
            'images/coffee_cup.png',
            fit: BoxFit.contain,
            height: height,
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
