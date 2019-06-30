import 'package:my_goals/data/model/goal.dart';

class GoalsRepository {
  List<Goal> _goalsList;

  static final GoalsRepository _instance = GoalsRepository._privateConstructor();
  factory GoalsRepository() => _instance;

  GoalsRepository._privateConstructor() {
    _goalsList = <Goal>[];
  }

  List<Goal> getGoalsList() => _goalsList;

  void addNewGoalToList(String goalName, num goalDate) {
    _goalsList.add(Goal(goalName, goalDate));
  }
}