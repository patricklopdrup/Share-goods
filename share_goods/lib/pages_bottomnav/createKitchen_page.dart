import 'package:flutter/material.dart';
import 'package:share_goods/data/testData.dart';
import 'package:share_goods/models/kitchen.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/myColors.dart';
import 'package:share_goods/pages_bottomnav/choose_kitchen_page.dart';

class CreateKitchen extends StatefulWidget {
  final GlobalKey<_CreateKitchenState> key = new GlobalKey();
  @override
  _CreateKitchenState createState() => _CreateKitchenState();
}

class _CreateKitchenState extends State<CreateKitchen> {

  Future<Kitchen> createConfirmDialog(BuildContext context){

    return showDialog(context: context, barrierDismissible: false, builder: (context) {
      return AlertDialog(
        title: Text('Bekræft'),
        content: Text('Du er ved at oprette ${myController.text.toString()}. Er du sikker?'),
        actions: [
          MaterialButton(
            elevation: 5.0,
            child: Text('OK'),
            onPressed: () {
              Kitchen myKitchen = Kitchen(navn, null, null);
              Navigator.of(context).pop(myKitchen);

             // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChooseKitchen()));
            },
          ),
          MaterialButton(
            elevation: 5.0,
            child: Text('Annuller'),
            onPressed: (){
              Navigator.of(context).pop();
            }),
        ],
      );
    });
  }

  String navn = "";
  TextEditingController myController = TextEditingController();

  getText() { // this is new
    return myController.text;
  }

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
                   child: CreateNameField(myController: myController,),
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
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.arrow_forward, color: myDarkGreen,),
          onPressed: () {
            setState(() {
              createConfirmDialog(context).then((kitchen) {
                // Routes to ChooseKitchen while removing the underlying stack so the back-button doesn't appear.   https://stackoverflow.com/questions/45889341/flutter-remove-all-routes
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ChooseKitchen()), (Route<dynamic> route) => route is ChooseKitchen);

                // TODO: Gem køkken i database
              });
            });
          },
        ),
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
      padding: EdgeInsets.symmetric(horizontal: 0),
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

class CreateNameField extends StatefulWidget {

  @override
  _CreateNameFieldState createState() => _CreateNameFieldState();
  final TextEditingController myController;
  CreateNameField({this.myController});
}

class _CreateNameFieldState extends State<CreateNameField> {

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: [
        TextFormField(
          controller: widget.myController,
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
}
