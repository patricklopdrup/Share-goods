import 'package:flutter/material.dart';
import 'package:share_goods/screens/create_kitchen_screen.dart';
import 'package:share_goods/screens/join_kitchen_screen.dart';
import 'package:share_goods/utils/Colors.dart';
import 'package:share_goods/widgets/app_bar.dart';
import 'package:share_goods/widgets/route_slide_animation.dart';



class CreateJoinKitchen extends StatefulWidget {
  final Function selectTabFunc;
  CreateJoinKitchen({this.selectTabFunc});

  @override
  _CreateJoinKitchenState createState() => _CreateJoinKitchenState();
}

class _CreateJoinKitchenState extends State<CreateJoinKitchen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
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
          onPressed: () {
            Navigator.push(context,
                SlidingPageChange(page: JoinKitchen(selectTabFunc: widget.selectTabFunc,))
            );
          },
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
                SlidingPageChange(page: CreateKitchen(selectTabFunc: widget.selectTabFunc,))
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
