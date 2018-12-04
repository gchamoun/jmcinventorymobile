import 'package:flutter/material.dart';
import 'package:jmcinventory/InventoryService.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:jmcinventory/Item.dart';


class Checkin extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Checkin> {
  InventoryService inventoryService = new InventoryService();
  String qrString = "";
  List<Item> items = [];

  @override
  initState() {
    super.initState();
  }

  void onRemoveItem(int index) {
    items.removeAt(index);
    setState(() {
      print("Removing from list at index: " + index.toString());
    });
  }
  onCheckout() {
    items.forEach((item) {
      inventoryService.checkoutItem(item.id).then((result){
        if(result){
          print('Successfully checkout item: ' + item.toString());
        }
        else
        {
          print('error while checking out item: ' + item.toString());
        }
      });
    });
  }
  // This is the method to activate the camera and scan for qr code. If found, set the global variable qrString to the string result of the scan.
  // I also added the successful scan result to a list that is rendered above
  Future scan() async {

    try {
      String qrString = await BarcodeScanner.scan();
      addInventoryItem(qrString);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.qrString = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.qrString = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.qrString = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.qrString = 'Unknown error: $e');
    }
  }

  Future addInventoryItem(String itemId)async {
    Item item = await inventoryService.getItem(itemId);
    items.add(item);
    setState(() => {});
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          actions: <Widget>[
            // action button
            OutlineButton.icon(
              onPressed: scan,
              icon: Icon(Icons.camera_alt),
              label: new Text("Scan Item"),
              color: Colors.white,
              textColor: Colors.white,
            ),
          ],
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      title: Text('User: John-Anthony Jimenez'),
                      subtitle: Text('SUID: 90012345'),
                      trailing: FlatButton(
                        child: const Text('Edit User'),
                        textColor: Colors.white,
                        onPressed: null,
                      ),
                    ),
                  ],
                ),
              ),
              new Text(qrString),
              //Here is the builder for my list of scanned qrcodes
              new Expanded(
                  child: new ListView.builder
                    (
                      itemCount: items.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return ListTile(
                            leading: const Icon(Icons.camera),
                            title: new Text(items[index].description),
                            trailing: IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () => onRemoveItem(index),
                              color: Colors.red,
                            )
                        );
                      }
                  )
              )
            ],
          ),
        ),
        bottomNavigationBar: new BottomAppBar(
          child: RaisedButton(onPressed: onCheckout,
            child: new Text("CHECKOUT"),
            color: Colors.blue,
            textColor: Colors.white,
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
