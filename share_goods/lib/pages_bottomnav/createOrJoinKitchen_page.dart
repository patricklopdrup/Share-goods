import 'package:flutter/material.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/myColors.dart';
import 'package:share_goods/mySlideAnimation.dart';
import 'package:share_goods/pages_bottomnav/createKitchen_page.dart';



class CreateJoin extends StatefulWidget {
  @override
  _CreateJoinState createState() => _CreateJoinState();
}

class _CreateJoinState extends State<CreateJoin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            title: 'Kom i gang!'
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: createButtons(),
          ),
    );
  }

  Widget createButtons() {
    return Column(
      children: [
        SizedBox(height: 150,),
        RaisedButton(
          onPressed: () {},
          color: myLightGreen,
          child: Text(
            'Tilmeld køkken',
            style: TextStyle(fontSize: 15.0, fontFamily: 'OpenSans', fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.white),
          ),
        ),
        SizedBox(height: 15.0,),
        RaisedButton(
          onPressed: () {
            Navigator.push(context,
                MySlideRoute(page: CreateKitchen())
            );
          },
          color: myLightGreen,
          child: Text(
            'Opret køkken',
            style: TextStyle(fontSize: 15.0, fontFamily: 'OpenSans', fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.white),
          ),
        ),
      ],
    );
  }

}
