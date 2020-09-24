import 'package:flutter/material.dart';
import 'package:share_goods/itemField.dart';
import 'package:share_goods/myColors.dart';
import 'package:share_goods/MyActionButton.dart';

import '../itemField.dart';
import '../itemField.dart';

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

List<String> inventory = [
  'Løg',
  'Køkkenrulle',
  'Opvasketabs',
  'Alufolie',
  'Bagepapir',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10'
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
  Function needFunc = (index) {
    String tempName = need[index];
    need.removeAt(index);
    inventory.add(tempName);
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
            return ItemsNeeded(
              displayText: need[index - 1],
              isNeeded: false,
              index: index - 1,
              moveFunc: () {
                setState(() {
                  int indexInList = index - 1;
                  print('i liste $indexInList');
                  String tempName = need[indexInList];
                  need.removeAt(indexInList);
                  inventory.add(tempName);
                });
              },
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
                  print('i liste $indexInList');
                  String tempName = inventory[indexInList];
                  inventory.removeAt(indexInList);
                  need.add(tempName);
                });
              },
            );
          }
        },
      ),
    );
  }
}
