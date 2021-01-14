import 'package:flutter/material.dart';
import 'package:share_goods/myColors.dart';
import 'package:flutter/foundation.dart';
import 'package:share_goods/services/auth.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;


  final AuthService _auth = AuthService();

  final GlobalKey _textKey = new GlobalKey();
  TextStyle defaultStyle = TextStyle(
      color: myDarkGreen,
      fontSize: 20.0,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0
  );

  // Title is required and icon is default the account_circle icon
  MyAppBar(
      {@required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        toolbarHeight: 100.0,
        centerTitle: true,

        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: myDarkGreen
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            createLogo(),
            SizedBox(height: 10.0,),
            Text(
              this.title,
              style: TextStyle(
                color: myDarkGreen,
                fontSize: 36,
              ),
            ),
            /*IconButton(
              icon: this.icon,
              color: myDarkGreen,
              onPressed: () async {
                await _auth.signOut();
              },
              iconSize: 36,
            )*/
          ],
        ),
      ),
    );
  }

  // Needs to be implementet to return an AppBar
  @override
  Size get preferredSize => const Size.fromHeight(100);

  RichText createLogo(){
    return RichText(
        key: _textKey,
        text: TextSpan(children: [
          TextSpan(
            text: 'Share ',
            style: defaultStyle,
          ),
          TextSpan(
            text: 'g',
            style: defaultStyle,
          ),
          TextSpan(text: ' ', style: TextStyle(fontSize: 5.0)),
          TextSpan(
              text: 'oo',
              style: TextStyle(
                  color: myLightGreen,
                  letterSpacing: -4.0,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans')
          ),
          TextSpan(
              text: ' ',
              style: TextStyle(fontSize: 5.0)
          ),
          TextSpan(
            text: 'ds',
            style: defaultStyle,
          )
        ])
    );
  }

}
