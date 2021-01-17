import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:share_goods/screens/shoppinglist_screen.dart';
import 'package:share_goods/screens/widgets/kitchen_overview_leave_dialog.dart';
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
                .map((data) => _adminMenu(
                      context,
                      KitchenCard(
                        title: data.get('name'),
                        ref: data.get('kitchen'),
                      ),
                    ))
                .toList()),
      ),
    );
  }

  /// Wrap a Card with an adminMenu given access to edit and delete item
  /// [card] is the card to be wrapped
  Widget _adminMenu(BuildContext context, KitchenCard card) {
    return FocusedMenuHolder(
      menuItems: [
        FocusedMenuItem(
          title: Text(
            'Forlad køkken',
            style: TextStyle(color: Colors.redAccent),
          ),
          trailingIcon: Icon(
            Icons.exit_to_app_rounded,
            color: Colors.redAccent,
          ),
          onPressed: () {
            _leaveKitchen(card);
          },
        ),
      ],
      menuWidth: MediaQuery.of(context).size.width * 0.60,
      animateMenuItems: true,
      duration: Duration(milliseconds: 100),
      openWithTap: false,
      blurSize: 3,
      onPressed: () {},
      child: card,
    );
  }

  _leaveKitchen(KitchenCard kitchen) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentReference userKitchen = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('kitchens')
        .doc(kitchen.ref.id);

    buildLeaveKitchenDialog(context, kitchen.title).then(
      (value) => {
        if (value != null && value) {userKitchen.delete()}
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
    return Card(
      child: ListTile(
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
      ),
    );
  }
}
