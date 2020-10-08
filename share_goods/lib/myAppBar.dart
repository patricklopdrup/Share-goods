import 'package:flutter/material.dart';
import 'package:share_goods/myColors.dart';
import 'package:flutter/foundation.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Icon icon;

  // Title is required and icon is default the account_circle icon
  MyAppBar(
      {@required this.title, this.icon = const Icon(Icons.account_circle)});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white10,
      elevation: 0,
      iconTheme: IconThemeData(
        color: myDarkGreen,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.title,
            style: TextStyle(
              color: myDarkGreen,
              fontSize: 36,
            ),
          ),
          IconButton(
            icon: this.icon,
            color: myDarkGreen,
            onPressed: () {},
            iconSize: 36,
          )
        ],
      ),
    );
  }

  // Needs to be implementet to return an AppBar
  @override
  Size get preferredSize => const Size.fromHeight(65);
}
