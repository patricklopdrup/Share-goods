import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/models/item.dart';
import 'package:share_goods/utils/Colors.dart';

Future<bool> buildDeleteItemDialog(BuildContext context, Item item) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Slet vare'),
          content: RichText(
            text: TextSpan(
                text: 'Vil du slette: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: item.name,
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
                  'Slet',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                })
          ],
        );
      });
}

Future<String> buildEditItemDialog(BuildContext context, Item item) {
  TextEditingController myController = TextEditingController();
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: RichText(
            text: TextSpan(
                text: 'Redigér navn på: ',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: item.name,
                    style: TextStyle(color: myGradientGreen2),
                  ),
                ]),
          ),
          content: TextField(
            controller: myController,
            textCapitalization: TextCapitalization.sentences,
            autofocus: true,
          ),
          actions: [
            // Cancel button
            MaterialButton(
              elevation: 5.0,
              child: Text('Annuller'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // OK button
            MaterialButton(
              elevation: 5.0,
              child: Text(
                'OK',
                style: TextStyle(color: myGradientGreen2),
              ),
              onPressed: () {
                // Check if the user typed anything
                if (myController.text.toString().length > 0) {
                  Navigator.of(context).pop(myController.text.toString());
                } else {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
}
