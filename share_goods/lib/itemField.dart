import 'package:flutter/material.dart';
import 'package:share_goods/myColors.dart';

class ItemField extends StatefulWidget {
  String displayText;

  ItemField({this.displayText});

  @override
  _ItemFieldState createState() => _ItemFieldState();
}

class _ItemFieldState extends State<ItemField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              color: myLightGreen,
              child: Center(
                heightFactor: 1.5,
                child: Text(
                  widget.displayText,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: OutlineButton(
                borderSide: BorderSide(color: Colors.red),
                onPressed: () {},
                child: Text(
                  'Mangler',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  final String title;

  ItemTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              color: myDartGreen,
            ),
          ),
          Divider(color: myDartGreen,),
        ],
      ),
    );
  }
}
