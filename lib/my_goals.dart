import 'package:flutter/material.dart';

class MyGoals extends StatefulWidget {
  MyGoals({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyGoalsState createState() => _MyGoalsState();
}

class _MyGoalsState extends State<MyGoals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Create goal',
        child: Icon(Icons.add),
      ),
    );
  }
}