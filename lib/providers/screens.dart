import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/incomplete_screen.dart';
import '../models/screen.dart';
import '../screens/all_task_screen.dart';
import '../screens/complete_screen.dart';

class Screens extends ChangeNotifier {
  int _currentIndex = 0;
  List<Screen> _screens = [
    Screen(icon: Icons.all_inclusive, title: 'All', page: new AllTaskScreen()),
    Screen(icon: Icons.task_alt, title: 'Complete', page: new CompleteScreen()),
    Screen(
        icon: Icons.unpublished_outlined,
        title: 'Incomplete',
        page: new IncompleteScreen())
  ];
  List<Screen> get screens => this._screens;
  get currentIndex => this._currentIndex;
  set index(int index) {
    this._currentIndex = index;
    notifyListeners();
  }

  get screen {
    return this._screens[currentIndex].page;
  }
}
