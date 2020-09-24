import 'package:flutter/material.dart';
import 'package:share_goods/pages_bottomnav/chat_page.dart';
import 'package:share_goods/pages_bottomnav/items_page.dart';
import 'package:share_goods/pages_bottomnav/profile_page.dart';
import 'package:share_goods/myColors.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // current index for bottomnavigation
  int _currentIndex = 1; 

  // Pages we move between via bottomnav
  final pages = [Chat(), Item(), Profile()];

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
  BottomNavigationBarItem(
    title: Text('Chat'),
    icon: Icon(Icons.chat),
  ),
  BottomNavigationBarItem(
    title: Text('Varer'),
    icon: Icon(Icons.shopping_cart),
  ),
  BottomNavigationBarItem(
    title: Text('Profil'),
    icon: Icon(Icons.account_circle),
  ),
];