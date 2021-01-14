import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_goods/bottom_navigator.dart';
import 'package:share_goods/models/user.dart';
import 'package:share_goods/screens/auth/register_screen.dart';
import 'package:share_goods/screens/auth/sign_in_screen.dart';

class AuthenticationHandler extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<AuthenticationHandler> {
  bool showSignIn = true;

  void togglePage() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser>(context);
    if (user == null) {
      if (showSignIn) {
        return SignIn(togglePage: togglePage);
      } else {
        return Register(togglePage: togglePage);
      }
    }

    return BottomNavigator();
  }
}
