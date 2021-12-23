// @dart=2.9
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/providers/tasks.dart';
import 'package:flutter_todo_app/screens/all_task_screen.dart';
import 'package:flutter_todo_app/screens/user_task_screen.dart';
import 'package:flutter_todo_app/widget/task_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockTasks extends Mock implements Tasks {}

class MockTask extends Mock implements Task {}

Widget wrapWithMaterial(Widget page, Tasks tasks) => MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => tasks,
        child: Scaffold(
          body: page,
        ),
      ),
    );

void main() {
  testWidgets('title or description is empty, can\'t create new task',
      (WidgetTester tester) async {
    MockTasks tasks = MockTasks();
    bool isSaved = false;
    UserTaskScreen createTask = new UserTaskScreen(
      onSaveData: () => isSaved = true,
    );

    await tester.pumpWidget(wrapWithMaterial(createTask, tasks));
    await tester.tap(find.byKey(Key('save')));
    verifyNever(tasks.addNewTask(null, null));
    expect(isSaved, false);
  });
  testWidgets('non-empty title and description, expect new task is created',
      (WidgetTester tester) async {
    MockTasks tasks = MockTasks();
    bool isSaved = false;
    UserTaskScreen createTasks = UserTaskScreen(
      onSaveData: () => isSaved = true,
    );
    await tester.pumpWidget(wrapWithMaterial(createTasks, tasks));
    Finder titleField = find.byKey(Key('title'));
    await tester.enterText(titleField, 'title');
    Finder descriptionField = find.byKey(Key('description'));
    await tester.enterText(descriptionField, 'description');
    await tester.tap(find.byKey(Key('save')));
    verify(tasks.addNewTask('title', 'description')).called(1);
    expect(isSaved, true);
  });
}
