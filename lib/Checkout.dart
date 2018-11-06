import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:barcode_scan/barcode_scan.dart';
  import 'dart:async';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';

class Checkout extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
  }

  class _MyAppState extends State<Checkout> {
  List<String> litems = [];
  String barcode = "";

  @override
  initState() {
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return new MaterialApp(
  home: new Scaffold(
  appBar: new AppBar(
  title: new Text('Checkout'),
  ),
  body: new Center(
  child: new Column(
  children: <Widget>[
  new Container(
  child: new MaterialButton(
  onPressed: scan, child: new Text("Scan Item")),
  padding: const EdgeInsets.all(8.0),
  ),
  new Text(barcode),
  //Here is the builder for my list of scanned qrcodes
  new Expanded(
      child: new ListView.builder
        (
          itemCount: litems.length,
          itemBuilder: (BuildContext ctxt, int Index) {
            return new Text(Index.toString() + ": " + litems[Index]);
          }
      )
  )
  ],
  ),
  )),
  );
  }


  // This is the method to activate the camera and scan for qr code. If found, set the global variable barcode to the string result of the scan.
  // I also added the successful scan result to a list that is rendered above
  Future scan() async {
  try {
  String barcode = await BarcodeScanner.scan();
  setState(() => litems.add(barcode));
  } on PlatformException catch (e) {
  if (e.code == BarcodeScanner.CameraAccessDenied) {
  setState(() {
  this.barcode = 'The user did not grant the camera permission!';
  });
  } else {
  setState(() => this.barcode = 'Unknown error: $e');
  }
  } on FormatException{
  setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
  } catch (e) {
  setState(() => this.barcode = 'Unknown error: $e');
  }
  }
  }
