import 'package:flutter/material.dart';
import 'myColors.dart';

class MyActionButton extends StatelessWidget {
  final Function action;

  MyActionButton({this.action});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: action,
      child: Icon(Icons.add),
      backgroundColor: myDarkGreen,
    );
  }
}
