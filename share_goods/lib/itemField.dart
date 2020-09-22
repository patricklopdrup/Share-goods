import 'package:flutter/material.dart';
import 'package:share_goods/myColors.dart';

class ItemField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              // skal ikke være en knap
              child: FlatButton(
                color: myLightGreen,
                onPressed: () {},
                child: Text(
                  'Løg',
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
                    backgroundColor: Colors.white,
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
