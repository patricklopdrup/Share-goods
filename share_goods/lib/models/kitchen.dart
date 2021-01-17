import 'package:cloud_firestore/cloud_firestore.dart';

final dbref = FirebaseFirestore.instance;

class Kitchen {
  final String name;
  final List<Map<String, Object>> items;
  final DocumentReference admin;
  final DocumentReference reference;

  Kitchen({this.name, this.items, this.admin, this.reference});

  save() {
    var batch = dbref.batch();

    if (reference == null) {
      dbref.collection('shoppingList').add({
        'name': name,
        'admin': admin,
      }).then(
        (ref) => {
          items.forEach((doc) {
            var docRef = ref.collection('items').doc();
            batch.set(docRef, doc);
          }),
          batch.commit(),
          dbref.collection('Users').doc(admin.id).collection('kitchens').doc(ref.id).set({'kitchen': ref, 'name': name})
        },
      );
    } else {
      reference.update({'name': name, 'admin': admin});
    }
  }
}
