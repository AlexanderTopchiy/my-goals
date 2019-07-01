import 'dart:async' show Future;

import 'package:flutter/material.dart';

import 'create_goal.dart';
import 'package:my_goals/data/goals_repository.dart';
import 'package:my_goals/data/model/goal.dart';

final _goalsRepository = GoalsRepository();

class MyGoals extends StatefulWidget {
  @override
  _MyGoalsState createState() => _MyGoalsState();
}

class _MyGoalsState extends State<MyGoals> {
  bool _isListEmpty = true;

  Widget _initGoalsListView() {
    return ListView.builder(
      itemCount: _goalsRepository.getGoalsList().length,
      itemBuilder: (context, position) => ListTile(
        title: Text(_goalsRepository.getGoalsList()[position].goalName),
      ),
    );
  }

  Future _createNewGoal() async {
    Goal goal =  await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return CreateGoal();
      },
    ));

    if (goal != null) {
      setState(() {
        _isListEmpty = false;
        _goalsRepository.addNewGoalToList(goal.goalName, goal.goalDate);
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
      body: Stack(
        children: <Widget>[
          Center(
            child: Visibility(
              child: Text('Тут пусто :с'),
              visible: _isListEmpty,
            ),
          ),
          _initGoalsListView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewGoal(),
        tooltip: 'Создать цель',
        child: Icon(Icons.add),
      ),
    );
  }
}