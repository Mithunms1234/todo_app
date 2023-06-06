import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    int currentMonth = currentDate.month;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Current Month Example'),
        ),
        body: Center(
          child: Text(
            'Current Month: $currentMonth',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
