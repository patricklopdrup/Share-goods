import 'package:flutter/material.dart';
import 'myColors.dart';

class MyActionButton extends StatelessWidget {
  final Function hej;

  MyActionButton({this.hej});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: hej,
      child: Icon(Icons.add),
      backgroundColor: myDartGreen,
    );
  }
}
