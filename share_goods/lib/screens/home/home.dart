import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/pages_bottomnav/chat_page.dart';
import 'package:share_goods/pages_bottomnav/choose_kitchen_page.dart';
import 'package:share_goods/pages_bottomnav/items_page.dart';
import 'package:share_goods/pages_bottomnav/profile_page.dart';
import 'package:share_goods/myColors.dart';
import 'package:share_goods/screens/itemScreen/screen.dart';
import 'package:share_goods/services/auth.dart';
import 'dart:io' show Platform;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // current index for bottomnavigation
  int _currentIndex = 1;

  // Pages we move between via bottomnav
  final pages = [Profile(), ItemScreen(), Chat()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: myLightGreen,
        selectedItemColor: myDarkGreen,
        unselectedItemColor: Colors.white,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedIconTheme: IconThemeData(color: myDarkGreen),
        unselectedIconTheme: IconThemeData(color: Colors.white),
        currentIndex: _currentIndex,
        items: bottomNavItems,
        onTap: (int index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

// List of icon and title for bottomNav
final bottomNavItems = [
  profileBarItem(),
  shoppingCartBarItem(),
  chatBarItem(),
];

BottomNavigationBarItem profileBarItem() {
  IconData icon = Platform.isAndroid
      ? Icons.account_circle
      : CupertinoIcons.profile_circled;
  return BottomNavigationBarItem(
    title: Text('Profil'),
    icon: Icon(icon),
  );
}

BottomNavigationBarItem shoppingCartBarItem() {
  IconData icon =
      Platform.isAndroid ? Icons.shopping_cart : CupertinoIcons.shopping_cart;
  return BottomNavigationBarItem(
    title: Text('Varer'),
    icon: Icon(icon),
  );
}

BottomNavigationBarItem chatBarItem() {
  IconData icon = Platform.isAndroid
      ? Icons.chat_bubble
      : CupertinoIcons.conversation_bubble;
  return BottomNavigationBarItem(
    title: Text('Chat'),
    icon: Icon(icon),
  );
}
