import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/models/item.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:listview_utils/listview_utils.dart';

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Varer",
      ),
      body: _buildBody(context),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
  
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('shoppingList')
          .doc('heh')
          .collection('need')
          .orderBy('name')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        snapshot.data.docs.forEach((QueryDocumentSnapshot doc) => print(doc.id));
        return LinearProgressIndicator()
      },
    );
  }

}