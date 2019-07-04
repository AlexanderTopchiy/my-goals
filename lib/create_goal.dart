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
  final _goalDateController = TextEditingController();
  DateTime _goalDate;
  DateTime _datePickerStartDate = DateTime.now();

  @override
  void dispose() {
    _goalNameController.dispose();
    _goalDateController.dispose();
    super.dispose();
  }

  void _createGoal(BuildContext context) {
    _goalName = _goalNameController.text;
    if (_goalName.isNotEmpty && _goalDate != null) {
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

    if (_goalDate != null) {
      _datePickerStartDate = _goalDate;

      setState(() {
        _goalDateController.text = DateFormat('dd.MM.yyyy').format(_goalDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                autovalidate: true,
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
                    controller: _goalDateController,
                    decoration: InputDecoration(
                      labelText: 'Дата',
                      border: OutlineInputBorder(),
                    ),
                    autovalidate: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Выберите дату';
                      }
                      return null;
                    },
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
                  onPressed: () => _createGoal(context),
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