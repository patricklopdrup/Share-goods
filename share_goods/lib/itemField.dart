import 'package:flutter/material.dart';
import 'package:share_goods/myColors.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class ItemField extends StatefulWidget {
  final String displayText;
  final bool isNeeded;
  final int index;
  final Function moveFunc;

  ItemField({this.displayText, this.isNeeded, this.index, this.moveFunc});

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
          Conditional.single(
            context: context,
            conditionBuilder: (context) => widget.isNeeded,
            widgetBuilder: (context) {
              return Expanded(
                flex: 2,
                child: Container(
                  child: OutlineButton(
                    borderSide: BorderSide(color: Colors.red),
                    onPressed: widget.moveFunc,
                    child: Text(
                      'Mangler',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            },
            fallbackBuilder: (context) {
              return Expanded(
                flex: 2,
                child: Container(
                  child: OutlineButton(
                    borderSide: BorderSide(color: myLightGreen),
                    onPressed: widget.moveFunc,
                    child: Text(
                      'Køb',
                      style: TextStyle(
                        color: myLightGreen,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

// Titles that break the list
class ItemTitle extends StatelessWidget {
  final String title;
  final Function searchFunc;

  ItemTitle({this.title, this.searchFunc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: myDarkGreen,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Søg',
                    icon: Icon(Icons.search, color: myDarkGreen),
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: myDarkGreen,
                    ),
                  ),
                  onChanged: this.searchFunc,
                ),
              ),
            ],
          ),
          Divider(
            color: myDarkGreen,
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}
