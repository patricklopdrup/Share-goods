import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:share_goods/widgets/app_bar.dart';

class JoinKitchen extends StatefulWidget {
  final Function selectTabFunc;

  JoinKitchen({this.selectTabFunc});

  @override
  _JoinKitchenState createState() => _JoinKitchenState();
}

class _JoinKitchenState extends State<JoinKitchen> {
  Barcode result;
  QRViewController controller;
  Map<String, Object> QrData;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Tilmeld Køkken",
        ),
        body: Column(
          children: (result != null)
              ? [_buildQRDialog(context)]
              : [
            Expanded(
              flex: 1,
              child: Text("Scan QR-kode", style: TextStyle(fontSize: 16),),
            ),
            Expanded(
              flex: 8,
              child: _buildQrView(context),
            )
          ],
        ));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery
        .of(context)
        .size
        .width < 400 ||
        MediaQuery
            .of(context)
            .size
            .height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      formatsAllowed: [BarcodeFormat.qrcode],
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green[500],
        borderRadius: 10,
        borderLength: 30,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        QrData = json.decode(scanData.code);
      });
    });
  }

  addUserKitchen() {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentReference ref = FirebaseFirestore.instance.collection(
        'shoppingList').doc(QrData['kitchenID']);
    print(uid);
    print(QrData['kitchenID']);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('kitchens')
        .doc(QrData['kitchenID']).set(
      {
        'kitchen': ref,
        'name': QrData['kitchenName'],
      },
    );
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
                          text: "Vil du joine",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: '"',
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: QrData['kitchenName'],
                                  style: TextStyle(color: Colors.green[600])),
                              TextSpan(
                                  text: '"',
                                  style: TextStyle(color: Colors.black))
                            ],
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 100,
              child: RaisedButton(
                onPressed: () {
                  addUserKitchen();
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
                color: Colors.green,
              ),
            ),
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
    );
  }
}
