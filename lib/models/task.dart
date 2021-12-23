import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/providers/tasks.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Task extends ChangeNotifier {
  String id;
  String title;
  String description;
  DateTime date;
  bool? isComplete;

  Task(
      {required this.id,
      required this.title,
      required this.date,
      required this.description,
      this.isComplete});

  set complete(bool newValue) {
    this.isComplete = newValue;
    notifyListeners();
  }

  void _changeStatus(newStatus) {
    isComplete = newStatus;
    notifyListeners();
  }

  Future<void> setStatusOfTask() async {
    final url = Uri.parse(
        'https://to-do-app-ca628-default-rtdb.asia-southeast1.firebasedatabase.app/tasks/$id.json');
    final oldStatus = isComplete;
    isComplete = !isComplete!;
    notifyListeners();
    try {
      final response =
          await http.patch(url, body: json.encode({'isComplete': isComplete}));
      if (response.statusCode >= 400) {
        _changeStatus(oldStatus);
      }
    } catch (e) {
      _changeStatus(oldStatus);
    }
  }
}
