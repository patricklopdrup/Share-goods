import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_goods/models/user.dart';

class AuthService{

  //_auth means it's private and can only be used in this class
  //gives access to methods and properties of the FirebaseAuth class
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user based on FirebaseUser
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // setup stream, so every time a user signs in / signs out we get a response, and map it to our user
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebase(user));
    .map(_userFromFirebase);
  }

  // method to sign in with email & password
  Future signInMail(String mail, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: mail, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  // method to register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  // method to sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}