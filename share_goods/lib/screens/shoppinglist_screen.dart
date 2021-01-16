import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_goods/models/item.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:share_goods/screens/widgets/shopping_list_item.dart';
import 'package:share_goods/screens/widgets/shoppinglist_add_item_dialog.dart';
import 'package:share_goods/utils/Colors.dart';
import 'package:share_goods/widgets/action_button.dart';
import 'package:share_goods/widgets/app_bar.dart';

const String kitchen = "kitchen-k";

class ShoppingList extends StatefulWidget {
  final DocumentReference kitchenDoc;
  final String kitchenName;
  String currUser;
  String admin;

  ShoppingList({this.kitchenDoc, this.kitchenName});

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList>
    with SingleTickerProviderStateMixin {
  bool _inventoryActive = false;
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
    isAdmin();
  }

  Widget _buildQRDialog(BuildContext context) {
    return new Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(children: [
        Container(
          padding: EdgeInsets.only(top: 18, bottom: 35),
          margin: EdgeInsets.only(top: 13, right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, blurRadius: 12, offset: Offset(0, 0)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Join",
                          style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10,),
                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: '"',
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: widget.kitchenName,
                                  style: TextStyle(color: Colors.green[600])),
                              TextSpan(
                                  text: '"',
                                  style: TextStyle(color: Colors.black))
                            ],
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 20,),
                      QrImage(
                        data: json.encode({'kitchenID': widget.kitchenDoc.id, 'kitchenName': widget.kitchenName}),
                        size: 200,
                        version: QrVersions.auto,
                        foregroundColor: Colors.green[500],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 14.0,
                backgroundColor: Colors.white,
                child: Icon(Icons.close, color: Colors.red),
              ),
            ),
          ),
        ),
      ]),

      // content: new Container(
      //   alignment: Alignment.center,
      //   height: 200,
      //   width: 200,
      //   child: QrImage(
      //     data: 'test',
      //     size: 200,
      //     version: QrVersions.auto,
      //   ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.kitchenDoc.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // måske slet, da vi sender over i constructor
          // final DocumentSnapshot ds = snapshot.data;
          // final Map<String, dynamic> kitchen = ds.data();
          return Scaffold(
            appBar: CustomAppBar(
              //title: kitchen['name'],
              title: widget.kitchenName,
            ),
            // Create the actionButton if the user is admin
            floatingActionButton: widget.currUser == widget.admin
                ? FloatingActionBubble(
                    items: [
                      Bubble(
                        title: "Overfør Administrator",
                        iconColor: Colors.white,
                        bubbleColor: Colors.blue,
                        icon: Icons.app_registration,
                        titleStyle:
                        TextStyle(fontSize: 16, color: Colors.white),
                        onPress: () {
                          _animationController.reverse();
                          Future.delayed(const Duration(milliseconds: 200), ()
                          {});
                          }
                      ),
                      Bubble(
                        title: "Join QR Code",
                        iconColor: Colors.white,
                        bubbleColor: Colors.blue,
                        icon: Icons.settings,
                        titleStyle:
                            TextStyle(fontSize: 16, color: Colors.white),
                        onPress: () {
                          _animationController.reverse();
                          Future.delayed(const Duration(milliseconds: 200), ()
                          {
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildQRDialog(context),
                            );
                          });
                        },
                      ),
                      // Floating action menu item
                      Bubble(
                        title: "Add Item",
                        iconColor: Colors.white,
                        bubbleColor: Colors.blue,
                        icon: Icons.add,
                        titleStyle:
                            TextStyle(fontSize: 16, color: Colors.white),
                        onPress: () {
                          _animationController.reverse();
                          Future.delayed(const Duration(milliseconds: 200), () {
                            buildAddItemDialog(context, !_inventoryActive)
                                .then((value) {
                              // Check if user typed anything or canceled dialog
                              if (value != null) {
                                setState(() {
                                  addItemToFirestore(value);
                                });
                              }
                            });
                          });
                        },
                      ),
                    ],
                    onPress: () => _animationController.isCompleted
                        ? _animationController.reverse()
                        : _animationController.forward(),
                    icon: AnimatedIcons.menu_close,
                    iconColor: Colors.blue,
                    animation: _animation,
                  )
                // ? ActionButton(
                //     action: () {
                //       createAlertDialog(context, !_inventoryActive).then((value) {
                //         // Check if user typed anything or canceled dialog
                //         if (value != null) {
                //           setState(() {
                //             addItemToFirestore(value);
                //           });
                //         }
                //       });
                //     },
                //   )
                : null,
            body: Column(children: [
              SizedBox(height: 20),
              _buildTitles(context),
              SizedBox(height: 15),
              _buildPageView(context),
            ]),
          );
        }
        return SizedBox(
          height: 100,
        );
      },
    );
  }

  /// Checks whether or not the local user is the admin for a kitchen
  /// This gives the user access to add, edit and/or delete items
  Future<void> isAdmin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String currUser = auth.currentUser.uid;
    DocumentReference adminRef = widget.kitchenDoc;
    var admin;
    await adminRef.get().then((value) => admin = value.data()['admin']);
    widget.currUser = currUser;
    widget.admin = admin.id.toString();
    print('admin er ${widget.admin} og user ${widget.currUser}');
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
      stream: widget.kitchenDoc
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
          padding: EdgeInsets.only(bottom: 100),
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
    return ItemListItemWidget(item, widget.admin == widget.currUser);
  }

  addItemToFirestore(Map<String, Object> item) async {
    //print(item.toString());
    widget.kitchenDoc.collection('items').add(item);
  }
}
