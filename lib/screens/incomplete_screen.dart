import 'package:flutter/material.dart';
import 'package:flutter_todo_app/widget/task_widget.dart';
import '../providers/tasks.dart';
import 'package:provider/provider.dart';

class IncompleteScreen extends StatelessWidget {
  Future<void> _tasksFuture(BuildContext context) async {
    await Provider.of<Tasks>(context, listen: false).fetchAndSetupTasks();
    Provider.of<Tasks>(context, listen: false).showFilterTask(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Task'),
      ),
      body: FutureBuilder(
        future: _tasksFuture(context),
        builder: (context, snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshotData.error != null) {
              print(snapshotData.error);
              return Center(
                child: Text('Some error occur, please try again!'),
              );
            } else {
              return Consumer<Tasks>(
                  builder: (context, data, child) => data.tasks.length > 0
                      ? ListView.builder(
                          itemCount: data.tasks.length,
                          itemBuilder: (context, index) =>
                              ChangeNotifierProvider.value(
                                value: data.tasks[index],
                                child: TaskWidget(
                                  index: 2,
                                  task: data.tasks[index],
                                ),
                              ))
                      : Center(
                          child: Text('No incomplete tasks can be found!'),
                        ));
            }
          }
        },
      ),
    );
  }
}
