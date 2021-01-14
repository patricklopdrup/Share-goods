import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/myColors.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User user = _auth.currentUser;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic data;
  String uid = user.uid;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<dynamic> getData() async {
    final ref = db.collection('Users').doc(uid).get();
  }

  double sizedBoxHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MyAppBar(
          title: 'Profil',
        ),
        body: Stack(
          children: <Widget>[
            buildOpacityClipPath(context),
            buildClipPath(context),
            buildUserInfo(),
          ],
        ));
  }

  Widget buildClipPath(BuildContext context) {
    return ClipPath(
      clipper: ClippingClass(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
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
          height: MediaQuery.of(context).size.height / 2.8,
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

  Widget buildUserInfo() {
    return Column(
      children: [
        SizedBox(height: 250),
        ProfileInfo(Icons.account_circle, "Rasmus Strange Jakobsen"),
        SizedBox(
          height: sizedBoxHeight,
        ),
        ProfileInfo(Icons.email, "rasmusstrangejakobsen@gmail.com"),
        SizedBox(
          height: sizedBoxHeight,
        ),
        ProfileInfo(Icons.lock_rounded, '********'),
        SizedBox(
          height: 45.0,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
              onPressed: () {
                _auth.signOut();
              },
              child: Text('Log ud', style: TextStyle(color: Colors.white)),
              color: Colors.grey),
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData().then((value) => print("hej " + data.toString()));
  }
}

class ProfileInfo extends StatelessWidget {
  final IconData icon;
  final String info;

  ProfileInfo(this.icon, this.info);

  @override
  Widget build(BuildContext context) {
    double hej = MediaQuery.of(context).size.width / 20;
    return Container(
      padding: EdgeInsets.fromLTRB(hej, 0, hej, 0),
      child: ListTile(
        leading: Container(
          child: Icon(
            icon,
            color: myDarkGreen,
          ),
        ),
        title: Container(
          child: Text(
            info,
            style: TextStyle(letterSpacing: 2),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
      0,
      size.height,
    ); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
      firstStart.dx,
      firstStart.dy,
      firstEnd.dx,
      firstEnd.dy,
    );

    var secondStart = Offset(
      size.width - (size.width / 3.24),
      size.height - 105,
    );
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
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
    throw UnimplementedError();
  }
}
