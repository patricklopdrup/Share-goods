import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/screens/shoppinglist_screen.dart';
import 'package:share_goods/utils/Colors.dart';
import 'package:share_goods/widgets/app_bar.dart';
import 'package:share_goods/widgets/route_slide_animation.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:share_goods/widgets/top_design.dart';

class KitchenOverview extends StatefulWidget {
  @override
  _KitchenOverviewState createState() => _KitchenOverviewState();
}

class _KitchenOverviewState extends State<KitchenOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: 'Mine Køkkener'),
      body: Column(
        children: [
          Stack(children: <Widget>[
            buildOpacityClipPath(context),
            buildClipPath(context),
          ]),
          Expanded(
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: _buildKitchenOverview(context)))
        ],
      ),
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
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    final ScrollController _scrollController = ScrollController();
    return Scrollbar(
      controller: _scrollController,
      child: Container(
        child: ListView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            controller: _scrollController,
            children: snapshot
                .map((data) => KitchenCard(
                      title: data.get('name'),
                      ref: data.get('kitchen'),
                    ))
                .toList()),
      ),
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
            SlidingPageChange(
                page: ShoppingList(
              kitchenDoc: value.reference,
              kitchenName: title,
            ))));
      },
      leading: Icon(Icons.kitchen),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
    );
  }
}
