import 'package:flutter/material.dart';

Future<bool> buildLeaveKitchenDialog(BuildContext context, String title) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Forlad køkken'),
          content: RichText(
            text: TextSpan(
                text: 'Vil du forlade: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  TextSpan(text: '.'),
                ]),
          ),
          actions: [
            // Cancel button
            MaterialButton(
              elevation: 5.0,
              child: Text('Annuller'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            MaterialButton(
                elevation: 5,
                child: Text(
                  'Forlad Køkken',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                })
          ],
        );
      });
}