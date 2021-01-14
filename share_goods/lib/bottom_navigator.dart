// Credits for stack management: https://www.youtube.com/watch?v=qj7jcuU2Z10&t=190s

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/tab_navigator.dart';
import 'package:share_goods/utils/Colors.dart';
import 'dart:io' show Platform;

GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

class BottomNavigator extends StatefulWidget {
  @override
  BottomNavigatorState createState() => BottomNavigatorState();
}
class BottomNavigatorState extends State<BottomNavigator> {
  String _currentPage = "Kitchen";
  List<String> pageKeys = ["Profile", "Kitchen", "Join/Create"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Profile": GlobalKey<NavigatorState>(),
    "Kitchen": GlobalKey<NavigatorState>(),
    "Join/Create": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 1;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Kitchen") {
            _selectTab("Kitchen", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Profile"),
          _buildOffstageNavigator("Kitchen"),
          _buildOffstageNavigator("Join/Create"),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          key: globalKey,
          backgroundColor: myLightGreen,
          selectedItemColor: myDarkGreen,
          unselectedItemColor: Colors.white,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedIconTheme: IconThemeData(color: myDarkGreen),
          unselectedIconTheme: IconThemeData(color: Colors.white),
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          items: [
            profileBarItem(),
            shoppingCartBarItem(),
            createJoinBarItem(),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
        selectTabFunc: _selectTab,
      ),
    );
  }
}

BottomNavigationBarItem createJoinBarItem() {
  IconData icon = Platform.isAndroid
      ? Icons.add_circle_outline
      : CupertinoIcons.add_circled;
  return BottomNavigationBarItem(
    label: 'Tilmeld/Opret',
    icon: Icon(icon),
  );
}

BottomNavigationBarItem profileBarItem() {
  IconData icon = Platform.isAndroid
      ? Icons.account_circle
      : CupertinoIcons.profile_circled;
  return BottomNavigationBarItem(
    label: 'Profil',
    icon: Icon(icon),
  );
}

BottomNavigationBarItem shoppingCartBarItem() {
  IconData icon =
      Platform.isAndroid ? Icons.shopping_cart : CupertinoIcons.shopping_cart;
  return BottomNavigationBarItem(
    label: 'Køkken',
    icon: Icon(icon),
  );
}

BottomNavigationBarItem chatBarItem() {
  IconData icon = Platform.isAndroid
      ? Icons.chat_bubble
      : CupertinoIcons.conversation_bubble;
  return BottomNavigationBarItem(
    label: 'Chat',
    icon: Icon(icon),
  );
}
