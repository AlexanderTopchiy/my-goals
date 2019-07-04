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
  num _currentTime;

  @override
  void initState() {
    _currentTime = DateTime.now().millisecondsSinceEpoch;
    Duration fps = Duration(milliseconds: 50);
    Timer.periodic(
      fps,
      (Timer timer) => setState(() {
        _currentTime++;
      }),
    );
  }

  Widget _initGoalsListView() {
    return ListView.builder(
      itemCount: _goalsRepository.getGoalsList().length,
      itemBuilder: (context, position) {
        String _name = _goalsRepository.getGoalsList()[position].goalName;
        num _date = _goalsRepository.getGoalsList()[position].goalDate;
        return ListTile(
          title: Text('$_name'),
          subtitle: Text('${_date - _currentTime}'),
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