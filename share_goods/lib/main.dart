import 'package:flutter/material.dart';
import 'package:share_goods/screens/bottomnav.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Run screen with bottomnav as homepage
      home: MyHomePage(),
    );
  }
}

