import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

final dbref = FirebaseFirestore.instance;

class Kitchen {
  final String name;
  final List<String> items;
  final String admin;
  final DocumentReference reference;

  Kitchen({this.name, this.items, this.admin, this.reference});

  save() {
    if (reference == null) {
      dbref.collection('shoppingList').add({
        'name': name,
        'admin': admin,
      }).then(
        (ref) => {
          ref.collection('items').add(
            {
              'name': 'test',
              'shouldBuy': false,
              'timesBought': 0,
            },
          ),
          dbref.collection('Users').doc(admin).collection('kitchens').add({'kitchen': ref, 'name': name})
        },
      );
    } else {
      reference.update({'name': name, 'admin': admin});
    }
  }
}
