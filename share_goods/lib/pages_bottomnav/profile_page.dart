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
        appBar: MyAppBar(
          title: 'Profil',
        ),
        body: Container(
          child: Column(
            children: [
              ProfileInfo(Icons.account_circle, "Mit navnfkldsjf"),
              SizedBox(
                height: sizedBoxHeight,
              ),
              ProfileInfo(
                  Icons.email, "rasmusstrangejoKodsfkjhfdslkjbsen@gmail.com"),
              SizedBox(
                height: sizedBoxHeight,
              ),
              ProfileInfo(Icons.lock_rounded, '********'),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                    onPressed: () {
                      _auth.signOut();
                    },
                    child:
                        Text('Log ud', style: TextStyle(color: myLightGreen)),
                    color: Colors.purple),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData().then((value) => print("hej " + data.toString()));
  }
}

class ProfileInfo extends StatelessWidget {
  IconData icon;
  String info;

  ProfileInfo(this.icon, this.info);

  @override
  Widget build(BuildContext context) {
    double hej = MediaQuery.of(context).size.width / 20;
    return Container(
      padding: EdgeInsets.fromLTRB(hej, 0, hej, 0),
      child: ListTile(
        leading: Container(
          child: Icon(icon),
        ),
        title: Container(
          child: Text(
            info,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}

Widget _profileInfo(IconData icon, String info) {
  return ListTile(
    leading: Container(
      child: Icon(icon),
    ),
    title: Container(
      width: double.infinity,
      child: Text(
        info,
      ),
    ),
    tileColor: Colors.amber,
  );
}
