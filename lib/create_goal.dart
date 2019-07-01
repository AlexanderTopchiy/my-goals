import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_goals/data/model/goal.dart';

class CreateGoal extends StatefulWidget {
  @override
  _CreateGoalState createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoal> {
  final _goalNameController = TextEditingController();
  String _goalName;
  String _goalDateText = 'Дата';
  DateTime _goalDate;
  DateTime _datePickerStartDate = DateTime.now();

  @override
  void dispose() {
    _goalNameController.dispose();
    super.dispose();
  }

  void _createGoal() {
    _goalName = _goalNameController.text;
    if (_goalName.isNotEmpty) {
      Navigator.of(context).pop(
          Goal(_goalName, _goalDate.millisecondsSinceEpoch)
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    _goalDate = await showDatePicker(
      context: context,
      initialDate: _datePickerStartDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2100),
    );

    _datePickerStartDate = _goalDate;

    setState(() {
      DateFormat dateFormat = DateFormat('dd.MM.yyyy');
      _goalDateText = dateFormat.format(_goalDate);
    });
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: GestureDetector(
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: _goalDateText,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                onTap: () => _selectDate(context),
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