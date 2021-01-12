import 'package:flutter/material.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              )),
          ],
        ),
      ),
    );
  }
}
