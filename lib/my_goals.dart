import 'dart:async' show Future;

import 'package:flutter/material.dart';

import 'create_goal.dart';

class MyGoals extends StatefulWidget {
  @override
  _MyGoalsState createState() => _MyGoalsState();
}

class _MyGoalsState extends State<MyGoals> {
  bool _isListEmpty = true;

  Future _createNewGoal() async {
    Map goal =  await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return CreateGoal();
      },
    ));

    if (goal != null) {
      setState(() {
        _isListEmpty = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Мои цели',
        ),
      ),
      body: Center(
        child: Visibility(
          child: Text(
            'Тут пусто :с',
          ),
          visible: _isListEmpty,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNewGoal();
        },
        tooltip: 'Create goal',
        child: Icon(Icons.add),
      ),
    );
  }
}