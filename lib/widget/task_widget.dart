import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/providers/tasks.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatelessWidget {
  final int index;
  final Task task;
  TaskWidget({required this.index, required this.task});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(
        task.description,
      ),
      leading: Consumer<Task>(
        builder: (ctx, task, _) => task.isComplete!
            ? Icon(
                Icons.task_alt,
                color: Colors.green,
              )
            : Icon(
                Icons.unpublished_outlined,
                color: Colors.red,
              ),
      ),
      trailing: Consumer<Task>(
        builder: (ct, task, _) => Consumer<Tasks>(
          builder: (ctx, tasks, _) => Checkbox(
              key: Key('checkbox'),
              value: task.isComplete,
              onChanged: (_) async {
                try {
                  await task.setStatusOfTask();
                  tasks.showFilterTask(index);
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('ERROR'),
                            content:
                                Text('Update status failed, please try again!'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK'))
                            ],
                          ));
                }
              }),
        ),
      ),
    );
  }
}
