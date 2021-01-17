import 'package:share_goods/models/kitchen.dart';

class LocalUser{

  final String uid;
  final String name;
  final String email;
  List<Kitchen> kitchens;

  LocalUser({this.name, this.email, this.uid});

  void deleteUser(){

  }

  String getUid() {
    return this.uid;
  }

  String getName() {
    return this.name;
  }

  String getEmail() {
    return this.email;
  }

  List<Kitchen> getKitchens() {
    return this.kitchens;
  }

}
