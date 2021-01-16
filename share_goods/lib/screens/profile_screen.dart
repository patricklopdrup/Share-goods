import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/utils/Colors.dart';
import 'package:share_goods/widgets/app_bar.dart';
import 'package:share_goods/widgets/top_design.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User user = _auth.currentUser;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double sizedBoxHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
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


  // Get the userInfo from firestore
  dynamic getUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    DocumentReference ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser.uid);
    DocumentSnapshot userInfo = await ref.get();
    var data = userInfo.data();
    return data;
  }

  // Build the profile page from firestore data.
  Widget buildUserInfo() {
    return FutureBuilder(
      future: getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> userInfo = snapshot.data;
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 3.8 + 10),
              ProfileInfo(Icons.account_circle, userInfo['name']),
              SizedBox(
                height: sizedBoxHeight,
              ),
              ProfileInfo(Icons.email, userInfo['e-mail']),
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
                    color: myDarkGreen),
              ),
            ],
          );
        } else {
          return SizedBox(height: 50,);
        }
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            style: TextStyle(letterSpacing: 1.5),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}