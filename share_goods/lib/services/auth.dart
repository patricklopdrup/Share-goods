import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_goods/models/user.dart';

class AuthService {
  //_auth means it's private and can only be used in this class
  //gives access to methods and properties of the FirebaseAuth class
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user based on FirebaseUser
  LocalUser _userFromFirebase(User user, {String name}) {
    return user != null
        ? LocalUser(uid: user.uid, name: name, email: user.email)
        : null;
  }

  // setup stream, so every time a user signs in / signs out we get a response, and map it to our user
  Stream<LocalUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
    //.map((FirebaseUser user) => _userFromFirebase(user));
  }

  // method to sign in with email & password
  Future signInMail(String mail, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      )).user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // method to register with email & password
  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .set({'name': name, 'e-mail': email});
      return _userFromFirebase(user, name: name);
    } catch (e) {
      print(e.toString());
      throw e.code;
    }
  }

  // method to sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}