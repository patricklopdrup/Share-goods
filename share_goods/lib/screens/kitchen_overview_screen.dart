import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/screens/shoppinglist_screen.dart';
import 'package:share_goods/widgets/app_bar.dart';
import 'package:share_goods/widgets/route_slide_animation.dart';
import 'package:loading_animations/loading_animations.dart';


class KitchenOverview extends StatefulWidget {
  @override
  _KitchenOverviewState createState() => _KitchenOverviewState();
}

class _KitchenOverviewState extends State<KitchenOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Mine Køkkener'),
      body: _buildKitchenOverview(context),
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

  Widget _buildKitchenOverview(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(auth.currentUser.uid)
          .collection('kitchens')
          .orderBy('name')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingFadingLine.circle();
        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  /// Build the list containing the info received from _buildPageViewBody
  Widget _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    final ScrollController _scrollController = ScrollController();
    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollController,
      child: ListView(
          controller: _scrollController,
          children: snapshot
              .map((data) => KitchenCard(title: data.get('name'), ref: data.get('kitchen'),)
              )
              .toList()),
    );
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
        hej.then((value) =>
            Navigator.push(context, SlidingPageChange(page: ShoppingList(kitchenDoc: value.reference, kitchenName: title,)))
        );
      },
      leading: Icon(Icons.kitchen),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
    );
  }
}
