import 'package:flutter/material.dart';
import 'package:share_goods/itemField.dart';
import 'package:share_goods/MyActionButton.dart';
import 'package:share_goods/myColors.dart';

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

List<String> inventory = [
  'Løg',
  'Køkkenrulle',
  'Opvasketabs',
  'Alufolie',
  'Bagepapir'
];

List<String> need = ['hej', 'med', 'dig'];

Function moveFromInventory(invIndex, needIndex) {
  String tempNeed = inventory[invIndex];
  inventory.remove(invIndex);
  need.add(tempNeed);
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Varer'),
        centerTitle: true,
      ),
      // Display list in body
      body: ItemList(),
      floatingActionButton: MyActionButton(
        hej: () {
          setState(() {
            inventory.removeAt(0);
          });
        },
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // Function to move from need list to inventory list
  Function needFunc = (index) {
    String tempName = need[index];
    need.removeAt(index);
    inventory.add(tempName);
  };

  // Function to move from inventory list to need list
  Function inventoryFunc = (index) {
    String tempName = inventory[index];
    inventory.removeAt(index);
    need.add(tempName);
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        // Length of both lists + 2 titles
        itemCount: inventory.length + need.length + 2,
        itemBuilder: (context, index) {
          // Show title as first element in list
          if (index == 0) {
            return ItemTitle(
              title: 'Mangler',
            );
            // Show list of needed items
          } else if (index < need.length + 1) {
            int indexInList = index - 1;
            return Dismissible(
              resizeDuration: Duration(milliseconds: 150),
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  needFunc(indexInList);
                });
              },
              background: Container(
                margin: EdgeInsets.fromLTRB(0, 12, 0, 7),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Købt',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
                color: myDarkGreen,
                alignment: Alignment.centerLeft,
              ),
              child: ItemsNeeded(
                displayText: need[index - 1],
                isNeeded: false,
                index: index - 1,
                moveFunc: () {
                  setState(() {
                    needFunc(indexInList);
                  });
                },
              ),
            );
            // Show title of inventory after needed items
          } else if (index == need.length + 1) {
            return ItemTitle(
              title: 'Beholdning',
            );
            // Show all inventory items
          } else {
            return ItemsNeeded(
              displayText: inventory[index - need.length - 2],
              isNeeded: true,
              index: index - need.length - 2,
              moveFunc: () {
                setState(() {
                  int indexInList = index - need.length - 2;
                  inventoryFunc(indexInList);
                });
              },
            );
          }
        },
      ),
    );
  }
}
