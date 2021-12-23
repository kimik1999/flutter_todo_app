import 'package:flutter/material.dart';
import 'package:flutter_todo_app/providers/screens.dart';
import 'package:flutter_todo_app/screens/all_task_screen.dart';
import 'package:flutter_todo_app/widget/bottom_nav_widget.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<Screens>(builder: (ctx, data, _) {
      return Scaffold(
        body: data.screen,
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 12,
          child: Row(
            children: List.generate(data.screens.length, (index) {
              isSelected = data.currentIndex == index;
              return GestureDetector(
                onTap: () {
                  data.index = index;
                },
                child: BottomNavWidget(
                  icon: data.screens[index].icon,
                  title: data.screens[index].title,
                  isSelected: isSelected,
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
