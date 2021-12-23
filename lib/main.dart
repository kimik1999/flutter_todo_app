import 'package:flutter/material.dart';
import '../providers/tasks.dart';
import '../screens/user_task_screen.dart';
import '../providers/screens.dart';
import '../widget/main_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Tasks()),
        ChangeNotifierProvider(create: (context) => Screens())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter To Do',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainWidget(),
        routes: {UserTaskScreen.routeName: (context) => UserTaskScreen()},
      ),
    );
  }
}
