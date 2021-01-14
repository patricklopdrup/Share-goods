// Credits for stack management: https://www.youtube.com/watch?v=qj7jcuU2Z10&t=190s
import 'package:flutter/material.dart';
import 'package:share_goods/pages_bottomnav/choose_kitchen_page.dart';
import 'package:share_goods/pages_bottomnav/createOrJoinKitchen_page.dart';
import 'package:share_goods/pages_bottomnav/profile_page.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Profile")
      child = Profile();
    else if (tabItem == "Kitchen")
      child = ChooseKitchen();
    else if (tabItem == "Join/Create") child = CreateJoin();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}
