import 'package:flutter/material.dart';
import 'package:share_goods/models/item.dart';

class ItemListItemWidget extends StatelessWidget {
  ItemListItemWidget(this.item);
  final Item item;

  @override
  Widget build(BuildContext context) {
    if (item.shouldBuy) {
      return _BuildNeedCard(context);
    } else {
      return _BuildInventoryCard(context);
    }
  }


  Widget _BuildNeedCard(BuildContext context) {
    return Card(
      elevation: 0,
      margin: new EdgeInsets.fromLTRB(15, 6, 25, 0),
      color: Colors.red.withOpacity(0),
      child: Container(
          height: 55,
          child: Stack(children: [
            Row(children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(10)),
                      border: Border.all(color: Colors.black)),
                  height: 45,
                  width: 50,
                  margin: EdgeInsets.only(
                    left: 10,
                    top: 10,
                  ),
                  alignment: Alignment.center,
                  child: Text(item.name, style: TextStyle(fontSize: 22)),
                ),
              ),
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () =>
                      item.reference.update({
                        'shouldBuy': !item.shouldBuy,
                        'timesBought': item.timesBought + 1
                      }),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        border: Border.all(color: Colors.black)),
                    height: 45,
                    width: 45,
                    margin: EdgeInsets.only(
                      left: 10,
                      top: 10,
                    ),
                    alignment: Alignment.center,
                    child: Text('Køb',
                        style:
                        TextStyle(fontSize: 18, color: Colors.lightGreen)),
                  ),
                ),
              ),
            ]),
            Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(118, 222, 187, 1),
                    shape: BoxShape.circle),
                width: 30,
                height: 30,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "!",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )),
          ])),
    );
  }

  Widget _BuildInventoryCard(BuildContext context) {
    return Card(
      elevation: 0,
      margin: new EdgeInsets.fromLTRB(25, 10, 25, 0),
      color: Colors.red.withOpacity(0),
      child: Row(children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
                      border: Border.all(color: Colors.black)),
                  height: 45,
                  width: 50,
                  alignment: Alignment.center,
                  child: Text(item.name, style: TextStyle(fontSize: 22)),
                ),
              ),
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () =>
                      item.reference.update({
                        'shouldBuy': !item.shouldBuy,
                        'timesBought': item.timesBought + 1
                      }),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        border: Border.all(color: Colors.black)),
                    height: 45,
                    width: 45,
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    alignment: Alignment.center,
                    child: Text('Mangler',
                        style:
                        TextStyle(fontSize: 18, color: Colors.redAccent)),
                  ),
                ),
              ),
            ]),
          );
  }
}