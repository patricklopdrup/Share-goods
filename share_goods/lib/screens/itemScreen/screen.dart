import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_goods/models/item.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/myColors.dart';
import 'package:share_goods/screens/itemScreen/widgets/listItem.dart';
import 'package:loading_animations/loading_animations.dart';

const String kitchen = "kitchen-k";

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  bool _inventoryActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Køkken L",
      ),
      body: Column(children: [
        SizedBox(height: 20),
        _buildTitles(context),
        SizedBox(height: 15),
        _buildPageView(context),
      ]),
    );
  }

  /// Build the titles that appear above the shopping list
  ///
  /// Creates the titles inside a stack and adds ability to
  /// click on the titles to change between PageView pages
  Widget _buildTitles(BuildContext context) {
    return Column(
      children: [
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
                          color: !_inventoryActive
                              ? myDarkGreen
                              : Color.fromRGBO(38, 71, 61, 0.5)),
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
                            color: _inventoryActive
                                ? myDarkGreen
                                : Color.fromRGBO(38, 71, 61, 0.5)),
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
        )
      ],
    );
  }


  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  /// Used to keep track of which page we are on
  _onPageChanged(int page) {
    setState(() {
      _inventoryActive = !_inventoryActive;
    });
  }

  /// Used to jump between pages in the PageView
  itemPageJumpToPage(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }


  /// Build the pageView that contains the "Need" and "Inventory" list
  ///
  /// When calling [_onPageChanged] it changes a boolean telling us
  /// which page we are currently on - we use this to change title colors.
  Widget _buildPageView(BuildContext context) {
    return Expanded(
      child: PageView(
          onPageChanged: _onPageChanged,
          controller: pageController,
          children: [
            _buildPageViewBody(context, true),
            _buildPageViewBody(context, false),
          ]),
    );
  }

  /// Establish a connection to fireStore and set up a Stream to update the list
  ///
  /// We return a [StreamBuilder] which uses the stream to build itself when
  /// receiving new live data from the fireStore database
  Widget _buildPageViewBody(BuildContext context, bool shouldBuy) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('shoppingList')
          .doc(kitchen)
          .collection('items')
          .orderBy('name')
          .where('shouldBuy', isEqualTo: shouldBuy)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingFadingLine.circle();
        return _buildList(context, snapshot.data.docs, shouldBuy);
      },
    );
  }

  /// Build the list containing the info received from _buildPageViewBody
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

  /// Build the individual items in the list
  Widget _buildListItem(
      BuildContext context, DocumentSnapshot data, bool shouldBuy) {
    final item = Item.fromSnapshot(data);
    return ItemListItemWidget(item);
  }
}
