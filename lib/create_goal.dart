import 'package:flutter/material.dart';

import 'package:my_goals/data/model/goal.dart';

class CreateGoal extends StatefulWidget {
  @override
  _CreateGoalState createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoal> {
  final _goalNameController = TextEditingController();

  @override
  void dispose() {
    _goalNameController.dispose();
    super.dispose();
  }

  void _createGoal() {
    String _goalName = _goalNameController.text;
    if (_goalName.isNotEmpty) {
      Navigator.of(context).pop(
          Goal(_goalName, 10)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Создать цель'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _goalNameController,
                decoration: InputDecoration(
                  labelText: 'Название твоей цели',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите название цели';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: ButtonTheme(
                minWidth: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed: () => _createGoal(),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    'СОЗДАТЬ',
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}