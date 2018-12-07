import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:jmcinventory/HomeScreen.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MessagePageState();
}

class MessagePageState extends State<MessagePage> {
  String message = '';
  String link = '';
  int returnValue = 0;

  @override
  void initState() {
    setData();
    super.initState();
  }

  Future setData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      message = prefs.getString('message') ?? 'ERROR: Message not defined';
      returnValue = prefs.getInt('return');
    });
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        title: new Text('Message'),
      ),
      body: new Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                message,
                textAlign: TextAlign.center,
              ),
              new RaisedButton(
                  child: new Text('Return'),
                  onPressed: () {
                    if (returnValue == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  })
            ],
          ),
        ),
      ));
}
