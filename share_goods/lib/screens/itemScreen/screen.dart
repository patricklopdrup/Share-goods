import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/models/item.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:listview_utils/listview_utils.dart';

const String kitchen = "kitchen-k";

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Køkken K",
      ),
      body: Column(children: [
        SizedBox(height: 10),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Text(
                "Mangelvarer",
                textAlign: TextAlign.left,
                style: new TextStyle(
                    fontSize: 25.0, fontWeight: FontWeight.normal),
              ),
            )),
        Divider(
          color: Colors.black,
          thickness: 2,
          indent: 25,
          endIndent: 25,
        ),
        Expanded(
          child: _buildBody(context, true),
        ),
        SizedBox(height: 10),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Text(
                "Beholdning",
                textAlign: TextAlign.left,
                style: new TextStyle(
                    fontSize: 25.0, fontWeight: FontWeight.normal),
              ),
            )),
        Divider(
          color: Colors.black,
          thickness: 2,
          indent: 25,
          endIndent: 25,
        ),
        Expanded(
          child: _buildBody(context, false),
        ),
        SizedBox(height: 10),
      ]),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  Widget _buildBody(BuildContext context, bool shouldBuy) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('shoppingList')
          .doc(kitchen)
          .collection('items')
          .orderBy('name')
          .where('shouldBuy', isEqualTo: shouldBuy)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        snapshot.data.docs
            .forEach((QueryDocumentSnapshot doc) => print(doc.id));
        return _buildList(context, snapshot.data.docs, shouldBuy);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot, bool shouldBuy) {
    return ListView(
        children:
            snapshot.map((data) => _buildListItem(context, data, shouldBuy)).toList());
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data, bool shouldBuy) {
    final item = Item.fromSnapshot(data);
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
                  onTap: () => item.reference.update({
                    'shouldBuy': !shouldBuy,
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
                            TextStyle(fontSize: 22, color: Colors.lightGreen)),
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
}
