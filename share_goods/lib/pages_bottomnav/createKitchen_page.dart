import 'package:flutter/material.dart';
import 'package:share_goods/data/testData.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/myColors.dart';

class CreateKitchen extends StatefulWidget {
  @override
  _CreateKitchenState createState() => _CreateKitchenState();
}

class _CreateKitchenState extends State<CreateKitchen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Opret køkken',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Expanded(
               flex: 2,
                 child: Container(
                   child: _createNameField(),
                 )
             ),
             Expanded(
                 flex: 9,
                 child: Container(
                   child: CreateKitchenList(),
                 )
             ),
           ],
         )
        )
      );
  }
}

class CreateKitchenList extends StatefulWidget {
  @override
  _CreateKitchenListState createState() => _CreateKitchenListState();
}

class _CreateKitchenListState extends State<CreateKitchenList> {
  List<String> _inventory = [
    'Løg',
    'Køkkenrulle',
    'Opvasketabs',
    'Alufolie',
    'Bagepapir',
    'Skuresvampe',
    'Sæbe',
    'Paprika',
    'Rødløg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 45),
      child: ListView.builder(
            itemCount: _inventory.length,
            itemBuilder: (context,index){
              return CheckListItem(itemTitle: _inventory[index]);
            }
            ),
    );
  }
}

class CheckListItem extends StatefulWidget {
  @override
  _CheckListItemState createState() => _CheckListItemState();
  String itemTitle;
  CheckListItem({this.itemTitle});
}

class _CheckListItemState extends State<CheckListItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        contentPadding: EdgeInsets.all(10),
        checkColor: myDarkGreen,
        dense: true,
        title: Text(widget.itemTitle, style: TextStyle(fontSize: 15),),
        value: _isSelected,
        onChanged: (bool hej){
          setState(() {
            _isSelected = hej;
          });
          print("HEJ");
        },
      ),
    );
  }
}

Widget _createNameField() {
  return Container(
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: myDarkGreen),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: myDarkGreen)
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15),
              prefixIcon: Icon(
                Icons.shopping_cart,
                color: myDarkGreen,
              ),
              hintText: 'Navn på køkken',
              hintStyle:
                  TextStyle(color: myDarkGreen, fontFamily: 'OpenSans'),
            )
          ),
        ],
      ),
  );
}
