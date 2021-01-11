import 'package:flutter/material.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/myColors.dart';

class ChooseKitchen extends StatefulWidget {
  @override
  _ChooseKitchenState createState() => _ChooseKitchenState();
}

class _ChooseKitchenState extends State<ChooseKitchen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Mine Køkkener'),
      body: KitchenList(),
    );
  }
}

class KitchenList extends StatefulWidget {
  @override
  _KitchenListState createState() => _KitchenListState();
}

class _KitchenListState extends State<KitchenList> {
  final List kitchens = [
    'Køkken L',
    'Det seje køkken',
    'Køkken hej',
    // 'Køkken L',
    // 'Det seje køkken',
    // 'Køkken hej',
    // 'Køkken L',
    // 'Det seje køkken',
    // 'Køkken hej'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: kitchens.length,
          itemBuilder: (context, index) {
            return KitchenCard(title: this.kitchens[index]);
          }),
    );
  }
}

// Single card for a kitchen
class KitchenCard extends StatelessWidget {
  final String title;

  KitchenCard({this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Icon(Icons.kitchen),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
    );
  }
}