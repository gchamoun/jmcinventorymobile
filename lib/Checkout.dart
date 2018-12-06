import 'package:flutter/material.dart';
import 'package:jmcinventory/InventoryService.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:jmcinventory/Item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jmcinventory/MessagePage.dart';
import 'package:jmcinventory/HomeScreen.dart';


class Checkout extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
  }

  class _MyAppState extends State<Checkout> {
    String userEmail = "";

    InventoryService inventoryService = new InventoryService();
    String qrString = "";
    List<Item> items = [];
    bool checkoutSuccess = false;
    bool checkoutStarted = false;
    bool userWaiverNeed = true;


    @override
    initState() {
      super.initState();
      this.getUserId();
    }

    void onRemoveItem(int index) {
      items.removeAt(index);
      setState(() {
        print("Removing from list at index: " + index.toString());
      });
    }
    Future onUserWaiverNeeded(){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("User Waiver"),
              content: new Text("I hereby take full responsibility for the items being checkout and will be liable for any items that are damaged or lost"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("I hereby agree"),
                  onPressed: () {
                    userWaiverNeed = false;
                    Navigator.of(context).pop();
                    onCheckout();
                  },
                ),
              ],
            );
          },
        );
    }

    Future onCheckout() async {
      bool waiverAccepted = false;
      if(userWaiverNeed){
        waiverAccepted = await onUserWaiverNeeded();
      }else {
        bool first = true;
        for (Item item in items) {
          print('Checking out Items. Current: ' + item.description.toString() +
              ' first: ' + first.toString());
          bool result = await inventoryService.checkoutItem(item.id, first);
          if (result) {
            print('after item ' + item.id.toString() + ' checkout');
          }
          if (first) {
            first = false;
          }
        }
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('message', 'Checkout successful! Return to home');
        prefs.setInt('returnVa', 1);

        successScreen('These Items');
        return true;
      }
    }

    // This is the method to activate the camera and scan for qr code. If found, set the global variable qrString to the string result of the scan.
    // I also added the successful scan result to a list that is rendered above
    Future scan() async {
      try {
        String qrString = await BarcodeScanner.scan();
        addInventoryItem(int.tryParse(qrString));
      } on PlatformException catch (e) {
        if (e.code == BarcodeScanner.CameraAccessDenied) {
          setState(() {
            this.qrString = 'The user did not grant the camera permission!';
          });
        } else {
          setState(() => this.qrString = 'Unknown error: $e');
        }
      } on FormatException {
        setState(() =>
        this.qrString =
        'null (User returned using the "back"-button before scanning anything. Result)');
      } catch (e) {
        setState(() => this.qrString = 'Unknown error: $e');
      }
    }

    Future addInventoryItem(int itemId) async {
      Item item = await inventoryService.getItem(itemId);
      items.add(item);
      setState(() => {});
    }

    Future getUserId() async {
      final prefs = await SharedPreferences.getInstance();
      final currentUserEmail = prefs.getString('userEmail') ?? 0;
      final currentEmployee = prefs.getInt('employeeId') ?? 0;
      print('Employee Id: ' + currentEmployee.toString());
      setState(() {
        userEmail = currentUserEmail;
      });
      print(userEmail);
    }


    @override
    Widget build(BuildContext context) {
      return new MaterialApp(
        home: new Scaffold(
          appBar: AppBar(
            title: Text("Checkout"),
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
                      ListTile(
                        title: Text('Guest: ' + userEmail),
//            trailing: FlatButton(
////              child: const Text('Edit User'),
////              textColor: Colors.white,
////              onPressed: null,
//            ),
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
                              ),
                            onTap: () => itemDetailModal(index),
                          );
                        }
                    )
                ),
              ],
            ),
          ), bottomNavigationBar: new BottomAppBar(
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

    Future<void> successScreen(String itemName) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Successfully Checked out:'),
            content: new Center(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //Here is the builder for my list of scanned qrcodes
                  new Expanded(
                      child: new ListView.builder
                        (
                          itemCount: items.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return ListTile(
                                leading: const Icon(Icons.camera),
                                title: new Text(items[index].description),
                            );
                          }
                      )
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Return Home'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),

            ],
          );
        },
      );
    }
    Future<void> itemDetailModal(int index) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Item Details'),
            content: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text('Name: ' + items[index].description, textAlign: TextAlign.left,),
                  new Text('Serial: ' + items[index].serial, textAlign: TextAlign.left,),
                  new Text(items[index].accessories.toString(), textAlign: TextAlign.left,),
                  //Here is the builder for my list of scanned qrcodes

                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),

            ],
          );
        },
      );
    }
  }