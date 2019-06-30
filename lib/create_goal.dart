import 'package:flutter/material.dart';

class CreateGoal extends StatefulWidget {
  @override
  _CreateGoalState createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Создать цель'
        ),
      ),
    );
  }
}