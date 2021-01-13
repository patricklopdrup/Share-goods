import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/models/item.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:listview_utils/listview_utils.dart';
import 'package:share_goods/myColors.dart';
import 'package:share_goods/screens/itemScreen/widgets/listItem.dart';

const String kitchen = "kitchen-k";

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  bool _InventoryActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Køkken L",
      ),
      body: Column(children: [
        SizedBox(height: 20),
        Stack(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      itemPageJumpToPage(0);
                    },
                    child: Text(
                      "Mangelvarer",
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color:
                              !_InventoryActive ? myDarkGreen : Color.fromRGBO(38, 71, 61, 0.5)),
                    ),
                  ),
                )),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    child: GestureDetector(
                      onTap: () {
                        itemPageJumpToPage(1);
                      },
                      child: Text(
                        "Beholdning",
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color:
                                _InventoryActive ? myDarkGreen : Color.fromRGBO(38, 71, 61, 0.5)),
                      ),
                    ))),
          ],
        ),
        Divider(
          height: 4,
          color: Colors.black54,
          thickness: 1.5,
          indent: 60,
          endIndent: 60,
        ),
        SizedBox(height: 15),
        Expanded(
          child: PageView(
              onPageChanged: _onPageChanged,
              controller: pageController,
              children: [
                _buildBody(context, true),
                _buildBody(context, false),
              ]),
        ),
      ]),
    );
  }

  _onPageChanged(int page) {
    setState(() {
      if (page == 1) {
        _InventoryActive = true;
      } else {
        _InventoryActive = false;
      }
    });
  }

  itemPageJumpToPage(int index) {
    print(index);
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

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

  Widget _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot, bool shouldBuy) {
    final ScrollController _scrollController = ScrollController();
    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollController,
      child: ListView(
        controller: _scrollController,
          children: snapshot
              .map((data) => _buildListItem(context, data, shouldBuy))
              .toList()),
    );
  }

  Widget _buildListItem(
      BuildContext context, DocumentSnapshot data, bool shouldBuy) {
    final item = Item.fromSnapshot(data);
    return ItemListItemWidget(item);
  }
}
