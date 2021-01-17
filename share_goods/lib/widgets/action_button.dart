import 'package:flutter/material.dart';
import 'package:share_goods/utils/Colors.dart';

class ActionButton extends StatelessWidget {
  final Function action;

  ActionButton({this.action});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: action,
      child: Icon(Icons.add),
      backgroundColor: myDarkGreen,
    );
  }
}
