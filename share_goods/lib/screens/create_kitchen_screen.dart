import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/models/kitchen.dart';
import 'package:share_goods/utils/Colors.dart';
import 'package:share_goods/widgets/app_bar.dart';

TextEditingController _myController = TextEditingController();

Map<String, bool> _defaultItems = {};

class CreateKitchen extends StatefulWidget {
  final GlobalKey<_CreateKitchenState> key = new GlobalKey();
  final Function selectTabFunc;

  CreateKitchen({this.selectTabFunc}) {
    _defaultItems = {
      'Alufolie': false,
      'Bagepapir': false,
      'Køkkenrulle': false,
      'Løg': false,
      'Opvasketabs': false,
      'Paprika': false,
      'Rødløg': false,
      'Skuresvampe': false,
      'Sæbe': false,
    };

    _myController.clear();
  }

  @override
  _CreateKitchenState createState() => _CreateKitchenState();
}


class _CreateKitchenState extends State<CreateKitchen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<Kitchen> createConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Bekræft'),
            content: Text(
                'Du er ved at oprette ${_myController.text
                    .toString()}. Er du sikker?'),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: Text('OK'),
                onPressed: () {
                  List<Map<String, Object>> items = [];
                  _defaultItems.forEach((k, v) {
                    if (v) {
                      items.add({
                        'name': k,
                        'shouldBuy': false,
                        'timesBought': 0,
                      });
                    }
                  });
                  Kitchen myKitchen = Kitchen(name: _myController.text.toString(), admin: dbref.collection('Users').doc(auth.currentUser.uid), items: items);

                  Navigator.of(context).pop(myKitchen);
                },
              ),
              MaterialButton(
                  elevation: 5.0,
                  child: Text('Annuller'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
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
                    child: CreateNameField(
                      myController: _myController,
                    ),
                  )),
              Expanded(
                  flex: 9,
                  child: Container(
                    child: CreateKitchenList(wantedItems: _defaultItems,),
                  )),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myDarkGreen,
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            createConfirmDialog(context).then((kitchen) {
              // If cancel is pressed just close the dialog otherwise go to MyHomePage
              print("HEEEEJ HEEEEEEEJ" + kitchen.name);
              print("HEEEEJ HEEEEEEEJ" + kitchen.name);
              if (kitchen.name.length > 0) {
                kitchen.save();
                Navigator.of(context).pop();
                widget.selectTabFunc('Kitchen', 1);
              }
            });
          });
        },
      ),
    );
  }
}

class CreateKitchenList extends StatefulWidget {
  final Map<String, bool> wantedItems;
  CreateKitchenList({this.wantedItems});

  @override
  _CreateKitchenListState createState() => _CreateKitchenListState();
}

class _CreateKitchenListState extends State<CreateKitchenList> {
  @override

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: ListView.builder(
          itemCount: widget.wantedItems.length,
          itemBuilder: (context, index) {
            return CheckListItem(itemTitle: widget.wantedItems.keys.elementAt(index));
          }),
    );
  }
}

class CheckListItem extends StatefulWidget {
  final String itemTitle;
  CheckListItem({this.itemTitle});

  @override
  _CheckListItemState createState() => _CheckListItemState();
}

class _CheckListItemState extends State<CheckListItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        contentPadding: EdgeInsets.all(10),
        checkColor: myDarkGreen,
        activeColor: myLightGreen,
        dense: true,
        title: Text(
          widget.itemTitle,
          style: TextStyle(fontSize: 15),
        ),
        value: _isSelected,
        onChanged: (bool isChecked) {
          _defaultItems[widget.itemTitle] = isChecked;
          setState(() {
            _isSelected = isChecked;
          });
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
    return Container(
      child: Column(
        children: [
          TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: widget.myController,
              style: TextStyle(color: myDarkGreen),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: myDarkGreen)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 15),
                prefixIcon: Icon(
                  Icons.shopping_cart,
                  color: myDarkGreen,
                ),
                hintText: 'Navn på køkken',
                hintStyle:
                TextStyle(color: myDarkGreen, fontFamily: 'OpenSans'),
              )),
        ],
      ),
    );
  }
}
