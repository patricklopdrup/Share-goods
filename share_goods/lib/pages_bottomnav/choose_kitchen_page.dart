import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/myColors.dart';

class ChooseKitchen extends StatefulWidget {
  @override
  _ChooseKitchenState createState() => _ChooseKitchenState();
}

class _ChooseKitchenState extends State<ChooseKitchen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Mine Køkkener'),
      body: KitchenList(),
    );
  }
}

class KitchenList extends StatefulWidget {
  @override
  _KitchenListState createState() => _KitchenListState();
}

getKitchens() async {
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

class _KitchenListState extends State<KitchenList> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getKitchens(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<String, Object>> kitchens = snapshot.data;
            return Container(
              child: ListView.builder(
                  itemCount: kitchens.length,
                  itemBuilder: (context, index) {
                    return KitchenCard(title: kitchens[index]['name']);
                  }),
            );
          }
          return SizedBox(
            height: 100,
          );
        },
      );
}

// Single card for a kitchen
class KitchenCard extends StatelessWidget {
  final String title;

  KitchenCard({this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Icon(Icons.kitchen),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
    );
  }
}
