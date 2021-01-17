// Credits for stack management: https://www.youtube.com/watch?v=qj7jcuU2Z10&t=190s
import 'package:flutter/material.dart';
import 'package:share_goods/screens/join_create_kitchen_screen.dart';
import 'package:share_goods/screens/kitchen_overview_screen.dart';
import 'package:share_goods/screens/profile_screen.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.selectTabFunc});

  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final Function selectTabFunc;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Profile")
      child = Profile();
    else if (tabItem == "Kitchen")
      child = KitchenOverview();
    else if (tabItem == "Join/Create") child = CreateJoinKitchen(selectTabFunc: selectTabFunc,);

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
