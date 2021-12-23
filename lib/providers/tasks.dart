import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:http/http.dart' as http;

class Tasks extends ChangeNotifier {
  List<Task> _tasks = [];
  var _index = 0;

  List<Task> get tasks => _index == 0
      ? [...this._tasks]
      : _index == 1
          ? this._tasks.where((element) => element.isComplete == true).toList()
          : this
              ._tasks
              .where((element) => element.isComplete == false)
              .toList();

  void showFilterTask([int newIndex = 0]) {
    _index = newIndex;
    notifyListeners();
  }

  Future<void> fetchAndSetupTasks([int index = 0]) async {
    //final bool isComplete = index == 1 ? true : index == 2 ? false : ;
    final filterString = index == 1
        ? 'orderBy="isComplete"&equalTo=true'
        : index == 2
            ? 'orderBy="isComplete"&equalTo=false'
            : '';
    final url = Uri.parse(
        'https://to-do-app-ca628-default-rtdb.asia-southeast1.firebasedatabase.app/tasks.json?$filterString');
    try {
      final response = await http.get(url);
      // print(response.body);
      List<Task> _loadedData = [];
      final _responseData = json.decode(response.body) as Map<String, dynamic>;
      _responseData.forEach((key, value) {
        _loadedData.add(Task(
            id: key,
            title: value['title'],
            date: DateTime.parse(value['date']),
            description: value['description'],
            isComplete: value['isComplete']));
      });
      _tasks = _loadedData;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addNewTask(String title, String description) async {
    final url = Uri.parse(
        'https://to-do-app-ca628-default-rtdb.asia-southeast1.firebasedatabase.app/tasks.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': title,
            'description': description,
            'date': DateTime.now().toIso8601String(),
            'isComplete': false
          }));
      final newTask = Task(
          id: json.decode(response.body)['name'],
          title: title,
          date: DateTime.now(),
          description: description,
          isComplete: false);
      _tasks.add(newTask);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
