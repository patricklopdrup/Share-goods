import 'package:flutter/material.dart';

Future<Map<String, Object>> buildAddItemDialog(BuildContext context, bool shouldBuy) {
  TextEditingController myController = TextEditingController();
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Tilføj varer'),
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
            // Add button
            MaterialButton(
              elevation: 5.0,
              child: Text('Tilføj'),
              onPressed: () {
                // Check if the user typed anything
                if (myController.text.toString().length > 0) {
                  Map<String, Object> item = {
                    'name': myController.text.toString(),
                    'shouldBuy': shouldBuy,
                    'timesBought': 0
                  };
                  // Get value when 'add' is pressed
                  Navigator.of(context).pop(item);
                } else {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
}