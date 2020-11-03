import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_goods/models/user.dart';
import 'package:share_goods/screens/authenticate/authenticate.dart';
import 'package:share_goods/screens/authenticate/register.dart';
import 'package:share_goods/screens/authenticate/sign_in.dart';
import 'file:///Y:/DTU/5.%20Semester/Appudvikling/Sharegoods/share_goods/lib/screens/home/home.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   // Specify we need user from Stream//accessing user data from Provider in main.dart
    final user = Provider.of<User>(context);
    print(user);
    //return either Home or Authenticate based on if user is signed in or not.
    if(user == null){
      return Authenticate();
    } else {
      return MyHomePage();
    }

  }
}