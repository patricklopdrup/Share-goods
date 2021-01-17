import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:share_goods/models/item.dart';
import 'package:share_goods/screens/widgets/shoppinglist_item_alertdialog.dart';
import 'package:share_goods/utils/Colors.dart';

class ItemListItemWidget extends StatelessWidget {
  ItemListItemWidget(this.item, this.isAdmin);

  final Item item;
  final bool isAdmin;

  /// Initiate build from an [Item] object
  ///
  /// Check if the item is needed or an item from the
  /// inventory and call the corresponding methods.
  @override
  Widget build(BuildContext context) {
    if (item.shouldBuy) {
      return isAdmin
          ? _adminMenu(context, _buildNeedCard(context))
          : _buildNeedCard(context);
    } else {
      return isAdmin
          ? _adminMenu(context, _buildInventoryCard(context))
          : _buildInventoryCard(context);
    }
  }

  /// Build a Card from items that are needed
  Widget _buildNeedCard(BuildContext context) {
    return Card(
      elevation: 0,
      margin: new EdgeInsets.fromLTRB(15, 10, 25, 0),
      color: Colors.red.withOpacity(0),
      child: Container(
        height: 55,
        child: Stack(children: [
          Row(children: [
            _buildNeedItemBanner(context),
            _buildNeedBuyButton(context),
          ]),
          _buildNeedCircle(context),
        ]),
      ),
    );
  }

  /// Build the container with the item name within it
  Widget _buildNeedItemBanner(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Container(
        height: 45,
        width: 50,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
          border: Border.all(color: Colors.black),
        ),
        margin: EdgeInsets.only(
          left: 10,
          top: 10,
        ),
        alignment: Alignment.center,
        child: Text(
          item.name,
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  /// Build the button you press to mark the item as bought
  ///
  /// We use [Ink] around [InkWell] to make the ripple effect
  /// when clicking the container appear on top, otherwise it would
  /// be invisible.
  Widget _buildNeedBuyButton(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 10),
        child: Ink(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            border: Border.all(color: Colors.black),
          ),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            onTap: () {
              Future.delayed(Duration(milliseconds: 150), () {
                item.reference.update({
                  'shouldBuy': !item.shouldBuy,
                  'timesBought': item.timesBought + 1
                });
              });
            },
            child: Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              child: Text(
                'Køb',
                style: TextStyle(
                  fontSize: 18,
                  color: myGradientGreen2,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build the small circle with the exclamation mark in it
  Widget _buildNeedCircle(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: myGradientGreen2,
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildInventoryCard(BuildContext context) {
    return Card(
      elevation: 0,
      margin: new EdgeInsets.fromLTRB(15, 10, 25, 0),
      color: Colors.red.withOpacity(0),
      child: Container(
        child: Row(
          children: [
            _buildInventoryItemBanner(context),
            _buildInventoryNeedButton(context),
          ],
        ),
      ),
    );
  }

  /// Build the container with the item name within it
  Widget _buildInventoryItemBanner(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Container(
        height: 45,
        width: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          item.name,
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  /// Build the button you press to mark the item as bought
  ///
  /// Pretty much the same as [_buildNeedBuyButton] just fine tuned
  /// to fit another sizing layout.
  Widget _buildInventoryNeedButton(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 10),
        child: Ink(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            border: Border.all(color: Colors.black),
          ),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            onTap: () {
              Future.delayed(Duration(milliseconds: 150), () {
                item.reference.update({
                  'shouldBuy': !item.shouldBuy,
                });
              });
            },
            child: Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              child: Text(
                'Mangler',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.redAccent,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Wrap a Card with an adminMenu given access to edit and delete item
  /// [card] is the card to be wrapped
  Widget _adminMenu(BuildContext context, Card card) {
    return FocusedMenuHolder(
        menuItems: [
          FocusedMenuItem(
            title: Text('Rediger'),
            trailingIcon: Icon(Icons.edit),
            onPressed: () {
              buildEditItemDialog(context, item).then((value) {
                // Function returns null if dismissed. Need to check
                if (value != null) {
                  Future.delayed(Duration(milliseconds: 350), () {
                    item.reference.update({'name': value});
                  });
                }
              });
            },
          ),
          FocusedMenuItem(
              title: Text(
                'Slet',
                style: TextStyle(color: Colors.redAccent),
              ),
              trailingIcon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () {
                // Delete item if OK button is pressed / if true is returned
                Future.delayed(Duration(milliseconds: 200), () {
                  buildDeleteItemDialog(context, item).then((value) {
                    // Function returns null if dismissed. Need to check
                    if (value != null && value) {
                      Future.delayed(Duration(milliseconds: 350), () {
                        item.reference.delete();
                      });
                    }
                  });
                });
              }),
        ],
        menuWidth: MediaQuery.of(context).size.width * 0.50,
        animateMenuItems: true,
        duration: Duration(milliseconds: 100),
        openWithTap: false,
        blurSize: 3,
        onPressed: () {},
        child: card);
  }
}
