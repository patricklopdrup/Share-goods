import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share_goods/itemField.dart';
import 'package:share_goods/myColors.dart';

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

List<String> beholdning = [
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

List<String> mangelvarer = ['hej', 'med', 'dig'];


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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: myDartGreen,
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        // Length of both lists + 2 titles
        itemCount: beholdning.length + mangelvarer.length + 2,
        itemBuilder: (context, index) {
          // Show title as first element in list
          if (index == 0) {
            return ItemTitle(title: 'Mangler',);
          // Show list of needed items
          } else if (index < mangelvarer.length + 1) {
            return ItemField(displayText: mangelvarer[index-1]);
          // Show title of inventory after needed items
          } else if (index == mangelvarer.length + 1) {
            return ItemTitle(title: 'Beholdning',);
          // Show all inventory items
          } else {
            return ItemField(displayText: beholdning[index - mangelvarer.length - 2]);
          }
        },
      ),
    );
  }
}
