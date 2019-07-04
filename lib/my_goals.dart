import 'dart:async' show Future, Timer;

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
  int _currentTime;

  @override
  void initState() {
    _currentTime = DateTime.now().millisecondsSinceEpoch;
    Duration fps = Duration(milliseconds: 50);
    Timer.periodic(
      fps,
      (Timer timer) => setState(() {
        _currentTime += 50;
      }),
    );
  }

  Widget _initGoalsListView() {
    return ListView.builder(
      itemCount: _goalsRepository.getGoalsList().length,
      itemBuilder: (context, position) {
        String timeRemaining;
        String name = _goalsRepository.getGoalsList()[position].goalName;
        int date = _goalsRepository.getGoalsList()[position].goalDate;
        int expiryTime = date - _currentTime;
        if (expiryTime < 100) {
          timeRemaining = 'Дата цели достигнута!';
        } else {
          int seconds = expiryTime ~/ 1000;
          int minutes = seconds ~/ 60;
          int hours = minutes ~/ 60;
          int days = hours ~/ 24;
          timeRemaining = 'Осталось $days дн. и '
              '${hours % 24}'
              ':${minutes % 60}'
              ':${seconds % 60}'
              ':${expiryTime % 1000}';
        }
        return ListTile(
          title: Text('$name'),
          subtitle: Text('$timeRemaining'),
        );
      }
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