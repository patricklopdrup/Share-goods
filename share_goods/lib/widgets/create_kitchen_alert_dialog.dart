import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/models/kitchen.dart';
import 'package:share_goods/utils/Colors.dart';

Future<Kitchen> createConfirmDialog(BuildContext context, TextEditingController controller, Map<String, bool> defaultItem, FirebaseAuth auth) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Bekræft'),
          content: RichText(
            // Change dialog text if no name is provided
            text: controller.text.length > 0
                ? TextSpan(
                text: 'Du er ved at oprette ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
                ),
                children: [
                  TextSpan(
                    text: "'${controller.text.toString()}'",
                    style: TextStyle(color: myGradientGreen2, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '. Er du sikker?')
                ]
            )
                : TextSpan(text: 'Du skal give køkkenet et navn.', style: TextStyle(color: Colors.black)),
          ),
          actions: [
            MaterialButton(
              elevation: 5.0,
              child: Text('Annuller'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // Only show OK button if kitchen name has text
            controller.text.length > 0
                ? MaterialButton(
              elevation: 5.0,
              child: Text('OK'),
              onPressed: () {
                List<Map<String, Object>> items = [];
                defaultItem.forEach((k, v) {
                  if (v) {
                    items.add({
                      'name': k,
                      'shouldBuy': false,
                      'timesBought': 0,
                    });
                  }
                });
                Kitchen myKitchen = Kitchen(
                    name: controller.text.toString(),
                    admin: dbref
                        .collection('Users')
                        .doc(auth.currentUser.uid),
                    items: items);

                Navigator.of(context).pop(myKitchen);
              },
            )
                : null,
          ],
        );
      });
}