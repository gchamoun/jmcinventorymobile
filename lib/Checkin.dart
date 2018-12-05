import 'package:flutter/material.dart';
import 'package:jmcinventory/InventoryService.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:jmcinventory/Item.dart';
import 'package:jmcinventory/HomeScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';


class Checkin extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Checkin> {
  String userEmail = "";
  int userId = 0;

  InventoryService inventoryService = new InventoryService();
  String qrString = "";
  List<Item> items = [];
  List<int> indexOfCheckouts = [];
  String message ='';


  @override
  initState() {
    super.initState();
    this.getUserId();
    this.getItems();

  }
  void getItems () async{
    print("User ID NEW");
    print(userId);
    final prefs = await SharedPreferences.getInstance();

    final userIdGet = prefs.getInt('userId') ?? 0;

    items = await inventoryService.getUsersItems(userIdGet);
    print(items.toString());

    setState(() {
      if(items.length == 0){
        message = 'User has no items checked out';
      }
      else{
        items = items;
      }
    });

  }
  void onRemoveItem(int index) {
    items.removeAt(index);
    setState(() {
    });
  }
  onCheckout() {
    //inventoryService.checkoutItems(items);
  }
  // This is the method to activate the camera and scan for qr code. If found, set the global variable qrString to the string result of the scan.
  // I also added the successful scan result to a list that is rendered above
  Future scan() async {

    try {
      String qrString = await BarcodeScanner.scan();
      this.qrString = qrString;
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

  Future getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserEmail = prefs.getString('userEmail') ?? 0;
    final currentEmployee = prefs.getInt('employeeId') ?? 0;
    final userIdGet = prefs.getInt('userId') ?? 0;
    setState(() {
      userEmail = currentUserEmail;
      userId = userIdGet;

    });
    print("Userid:");
    print(userId);

  }

  Future getUserItems(userId) async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserEmail = prefs.getString('userEmail') ?? 0;
    final currentEmployee = prefs.getInt('employeeId') ?? 0;

    setState(() {
      userEmail = currentUserEmail;
    });
  }

  Future scanItem(itemId,index) async {
    final prefs = await SharedPreferences.getInstance();
    final workerIdGet = prefs.getInt('employeeId') ?? 0;


    print("array before:");

    indexOfCheckouts.add(index);
    print("array after:");
    print(indexOfCheckouts);
    final result =  await scan();
    print(qrString);
    print (itemId.toString());
    if (int.tryParse(qrString) == itemId){
      inventoryService.checkinItem(workerIdGet,itemId);
      _correctItem(items[index].description);
    }
    else {
      _wrongItem();
    }
  }




  Future _wrongItem(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("This is the wrong item"),
          content: Text('Please try again.'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
             },
            ),
          ],
        );
      },
    );
  }

  Future _correctItem(String itemName){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Successfully Checked in:"),
          content: Text(itemName),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
            },
            ),
          ],
        );
      },
    );
  }

  Icon getIcon(int index){
//    for (int i = 0; i < indexOfCheckouts.length; i++) {
//      print("This is index checkout ");
//      print(indexOfCheckouts[i]);
//      print(" this is index");
//      print(index);
//        if(index == indexOfCheckouts[i]){
//          return Icon(Icons.check);
//        }
//    }

    return Icon(Icons.camera_alt);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title:  Text("Checkin"),
          actions: <Widget>[
            // action button
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
              //Here is the builder for my list of scanned qrcodes
              new Text(message),
              new Expanded(
                  child: new ListView.builder
                    (
                      itemCount: items.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return ListTile(
                            title: new Text(items[index].description),
                            trailing: OutlineButton.icon(
                              onPressed:  () => scanItem(items[index].id, index),
                              icon: Icon(Icons.camera_alt),
                              label: new Text("Scan Item"),
//                              color: Colors.white,
//                              textColor: Colors.white,
                            ),
                        );
                      }
                  )
              )
            ],
          ),
        ),
        bottomNavigationBar: new BottomAppBar(
          child: RaisedButton(onPressed: () =>     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
    ),
            child: new Text("Return to Home"),
            color: Colors.blue,
            textColor: Colors.white,
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
