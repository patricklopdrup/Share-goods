import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/screens/shoppinglist_screen.dart';
import 'package:share_goods/utils/Colors.dart';
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

  Widget buildClipPath(BuildContext context) {
    return ClipPath(
      clipper: ClippingClass(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.6,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.centerRight,
            stops: [0.1, 0.9],
            colors: [
              myGradientGreen1,
              myGradientGreen2,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOpacityClipPath(BuildContext context) {
    return Opacity(
      opacity: 0.75,
      child: ClipPath(
        clipper: ClippingClass(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.centerRight,
              stops: [0.1, 0.9],
              colors: [
                myGradientGreen1,
                myGradientGreen2,
              ],
            ),
          ),
        ),
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
            padding: EdgeInsets.fromLTRB(0, 1, 0, 20),
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

  Widget _buildFuture(BuildContext context) {
    return FutureBuilder(
      future: _getKitchens(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Map<String, Object>> kitchens = snapshot.data;
          return Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: kitchens.length,
                itemBuilder: (context, index) {
                  return KitchenCard(
                    title: kitchens[index]['name'],
                    ref: kitchens[index]['kitchen'],
                  );
                }),
          );
        }
        return Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
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

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(
      0,
      size.height / 1.75,
    ); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.2, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
      firstStart.dx,
      firstStart.dy,
      firstEnd.dx,
      firstEnd.dy,
    );

    var secondStart = Offset(
      size.width - (size.width / 3.5),
      size.height - 105,
    );
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height / 1.4);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
      secondStart.dx,
      secondStart.dy,
      secondEnd.dx,
      secondEnd.dy,
    );

    path.lineTo(
      size.width,
      0,
    ); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
    // TODO: implement shouldReclip
  }
}
