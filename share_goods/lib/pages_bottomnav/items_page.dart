import 'package:flutter/material.dart';
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
    filteredInventory.add(tempName);
  };

  // Function to move from inventory list to need list
  Function inventoryFunc = (index) {
    String tempName = inventory[index];
    filteredInventory.removeAt(index);
    need.add(tempName);
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

  @override
  Widget build(BuildContext context) {
    inventory.sort();

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
            return TextField(
              decoration: InputDecoration(
                hintText: 'Søg',
                icon: Icon(Icons.search, color: myDarkGreen),
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
    return ItemField(
      displayText: filteredInventory[indexInList],
      isNeeded: true,
      index: indexInList,
      moveFunc: () {
        setState(() {
          inventoryFunc(indexInList);
        });
      },
    );
  }

}

