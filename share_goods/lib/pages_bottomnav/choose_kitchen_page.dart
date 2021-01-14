import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/myColors.dart';
import 'package:share_goods/pages_bottomnav/items_page.dart';
import 'package:share_goods/screens/itemScreen/screen.dart';

import '../mySlideAnimation.dart';

class ChooseKitchen extends StatefulWidget {
  @override
  _ChooseKitchenState createState() => _ChooseKitchenState();
}

class _ChooseKitchenState extends State<ChooseKitchen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Mine Køkkener'),
      body: _buildFuture(context),
    );
  }

  Future _getKitchens() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    CollectionReference ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser.uid)
        .collection('kitchens');

    QuerySnapshot userKitchens = await ref.get();
    List<Map<String, Object>> kitchens = [];
    userKitchens.docs.forEach((data) {
      kitchens.add({'name': data.get('name'), 'kitchen': data.get('kitchen')});
    });
    return kitchens;
  }


  Widget _buildFuture(BuildContext context) {
    return FutureBuilder(
      future: _getKitchens(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Map<String, Object>> kitchens = snapshot.data;
          return Container(
            child: ListView.builder(
                itemCount: kitchens.length,
                itemBuilder: (context, index) {
                  return KitchenCard(title: kitchens[index]['name'], ref: kitchens[index]['kitchen'],);
                }),
          );
        }
        return Align(
          alignment: Alignment.center,
          child:  CircularProgressIndicator(),
        );
      },
    );
  }
}

// Single card for a kitchen
class KitchenCard extends StatelessWidget {
  final String title;
  final DocumentReference ref;

  KitchenCard({this.title, this.ref});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Future<DocumentSnapshot> hej = ref.get();
        hej.then((value) => Navigator.push(
            context,
            MySlideRoute(
                page: ItemScreen(
              kitchenDoc: value.reference,
            ))));
      },
      leading: Icon(Icons.kitchen),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
    );
  }
}
