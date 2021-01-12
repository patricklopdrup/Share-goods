import 'package:flutter/material.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/myColors.dart';



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
    return Container(
      child: Column(
        children: [
          SizedBox(height: 150,),
          RaisedButton(
            onPressed: null,
            child: Text(
              'Tilmeld køkken',
              style: TextStyle(fontSize: 15.0, fontFamily: 'OpenSans', fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.white),
            ),
          ),
          SizedBox(height: 15.0,),
          RaisedButton(
            onPressed: null,
            child: Text(
              'Opret køkken',
              style: TextStyle(fontSize: 15.0, fontFamily: 'OpenSans', fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

}
