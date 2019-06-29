import 'package:flutter/material.dart';

import 'my_goals.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Goals',
      home: MyGoals(title: 'Мои цели'),
    );
  }
}
