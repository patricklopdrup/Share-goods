import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:share_goods/itemField.dart';
import 'package:share_goods/MyActionButton.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/myColors.dart';
import 'package:share_goods/screens/myDrawer.dart';
import 'package:share_goods/data/testData.dart';

class Item extends StatefulWidget {
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Varer',
      ),
      drawer: MyDrawer(),
      // Display list in body
      body: ItemList(),
      floatingActionButton: MyActionButton(
        hej: () {
          setState(() {
            print('floating action');
            filteredInventory.removeAt(0);
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
    filteredInventory = inventory;
  };

  // Function to move from inventory list to need list
  Function inventoryFunc = (text) {
    //String tempName = inventory[index];
    inventory.remove(text);
    filteredInventory.remove(text);
    need.add(text);
  };

  Function searchFunc = (value) {
    print('hej: $value');
    List<String> temp = [];
    for (var i in inventory) {
      if (i.toLowerCase().contains(value.toLowerCase())) {
        temp.add(i);
      }
    }
    filteredInventory = temp;
  };

  static final _textController = TextEditingController();

  // Check focus on textfield
  FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener((_onFocusChange));
  }

  void _onFocusChange() {
    print('Focus: ${_focus.hasFocus.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    inventory.sort();
    need.sort();

    return Container(
      child: ListView.builder(
        // Length of both lists + 2 titles
        itemCount: filteredInventory.length + need.length + 2,
        itemBuilder: (context, index) {
          // Show title as first element in list
          if (index == 0) {
            return ItemTitle(title: 'Mangler');
            // Show list of needed items
          } else if (index < need.length + 1) {
            int indexInList = index - 1;
            return buildNeedList(indexInList);
            // Show title of inventory after needed items
          } else if (index == need.length + 1) {
            return Container(
              margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Beholdning',
                          style: TextStyle(
                            fontSize: 18,
                            color: myDarkGreen,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 5,
                        child: TextField(
                          controller: _textController,
                          focusNode: _focus,
                          decoration: InputDecoration(
                            hintText: 'Søg',
                            suffixIcon: Icon(Icons.search, color: myDarkGreen),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: myDarkGreen,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchFunc(value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: myDarkGreen, thickness: 1.5),
                ],
              ),
            );
            // Show all inventory items
          } else {
            int indexInList = index - need.length - 2;
            return buildInventoryList(indexInList);
          }
        },
      ),
    );
  }

  // Show the list of needed items
  Dismissible buildNeedList(int indexInList) {
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
      child: ItemField(
        displayText: need[indexInList],
        isNeeded: false,
        index: indexInList,
        moveFunc: () {
          setState(() {
            needFunc(indexInList);
          });
        },
      ),
    );
  }

  // Show the list of items in inventory
  ItemField buildInventoryList(int indexInList) {
    String text = filteredInventory[indexInList];
    return ItemField(
      displayText: text,
      isNeeded: true,
      index: indexInList,
      moveFunc: () {
        setState(() {
          inventoryFunc(text);
        });
      },
    );
  }
}