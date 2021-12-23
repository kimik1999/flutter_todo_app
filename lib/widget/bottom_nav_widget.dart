import 'package:flutter/material.dart';

class BottomNavWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  BottomNavWidget(
      {required this.icon, required this.title, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Theme.of(context).primaryColor : Colors.black45,
          ),
          Text(
            isSelected ? title : '',
            style: TextStyle(color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
