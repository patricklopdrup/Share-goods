import 'package:flutter/material.dart';
import 'package:share_goods/myColors.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Drawer width 70% of screen
      width: MediaQuery.of(context).size.width * 0.7,
      color: Colors.red,
      child: Drawer(
        child: ListView(
          children: drawerSections,
        ),
      ),
    );
  }
}

// Sections in the drawer
List<Widget> drawerSections = [
  // Header
  DrawerHeader(
    child: Text('Hej'),
  ),
  // Settings
  DrawerElement(
    title: 'Indstillinger',
    icon: Icon(Icons.settings),
  ),
  DrawerElement(
    title: 'Om',
    icon: Icon(Icons.feedback),
  ),
];

class DrawerElement extends StatelessWidget {
  final String title;
  final Icon icon;

  DrawerElement({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: FlatButton.icon(
              icon: icon,
              label: Text(
                this.title,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );

    // return ListTile(
    //   title: this.title,
    //   leading: icon,
    // );
  }
}
