import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String name;
  final int timesBought;
  final DocumentReference reference;

  Item.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['name'] != null),
      assert(map['timesBought'] != null),
      name = map['name'],
      timesBought = map['timesBought'];

  Item.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name>";
}