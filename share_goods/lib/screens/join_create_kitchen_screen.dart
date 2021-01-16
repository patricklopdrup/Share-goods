import 'package:flutter/material.dart';
import 'package:share_goods/screens/create_kitchen_screen.dart';
import 'package:share_goods/screens/join_kitchen_screen.dart';
import 'package:share_goods/utils/Colors.dart';
import 'package:share_goods/widgets/app_bar.dart';
import 'package:share_goods/widgets/route_slide_animation.dart';
import 'package:share_goods/widgets/top_design.dart';

class CreateJoinKitchen extends StatefulWidget {
  final Function selectTabFunc;
  final TextStyle defaultStyle = TextStyle(
      color: myDarkGreen,
      fontSize: 16.0,
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0
  );

  CreateJoinKitchen({this.selectTabFunc});

  @override
  _CreateJoinKitchenState createState() => _CreateJoinKitchenState();
}

class _CreateJoinKitchenState extends State<CreateJoinKitchen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: 'Kom i gang!'),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              buildOpacityClipPath(context),
              buildClipPath(context),
            ],
          ),
          Container(
            child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Bruger I allerede ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: 0.5,
                      )
                    ),
                    TextSpan(
                      text: 'Share',
                      style: widget.defaultStyle,
                    ),
                    TextSpan(
                      text: 'G',
                      style: widget.defaultStyle,
                    ),
                    TextSpan(text: ' ', style: TextStyle(fontSize: 5.0)),
                    TextSpan(
                        text: 'oo',
                        style: TextStyle(
                            color: myLightGreen,
                            letterSpacing: -4.0,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans')
                    ),
                    TextSpan(
                        text: ' ',
                        style: TextStyle(fontSize: 5.0)
                    ),
                    TextSpan(
                      text: 'ds',
                      style: widget.defaultStyle,
                    ),
                    TextSpan(
                      text: '?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      )
                    )
                  ]
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                'Tilmeld eksisterende køkken\neller opret et nyt.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  letterSpacing: 0.5,
                  color: Colors.black,
                ),
              )),
          createButtons(),
        ],
      ),
    );
  }

  Widget createButtons() {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        ButtonTheme(
          minWidth: 200,
          height: 40,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  SlidingPageChange(
                      page: JoinKitchen(
                    selectTabFunc: widget.selectTabFunc,
                  )));
            },
            color: myDarkGreen,
            child: Text(
              'Tilmeld køkken',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          'eller',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        ButtonTheme(
          minWidth: 200,
          height: 40,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  SlidingPageChange(
                      page: CreateKitchen(
                    selectTabFunc: widget.selectTabFunc,
                  )));
            },
            color: myDarkGreen,
            child: Text(
              'Opret køkken',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
