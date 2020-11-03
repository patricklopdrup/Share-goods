import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_goods/models/user.dart';
import 'package:share_goods/services/auth.dart';
import 'package:share_goods/screens/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //root widget of the app
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
      ),
    );
  }
}

