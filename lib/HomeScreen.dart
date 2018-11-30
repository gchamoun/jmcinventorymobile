import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'package:jmcinventory/Checkout.dart';
import 'package:jmcinventory/UserPage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(appBar: AppBar(
      title: Text("Welcome"),
      automaticallyImplyLeading: false,

    ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
//        new Image(
//          image: new AssetImage("assets/Samford.jpg"),
//          fit: BoxFit.cover,
//          colorBlendMode: BlendMode.darken,
//          color: Colors.black87,
//        ),

        new Theme(
          data: new ThemeData(
              brightness: Brightness.dark,
              inputDecorationTheme: new InputDecorationTheme(
                // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                labelStyle:
                new TextStyle(color: Colors.white, fontSize: 20.0),
              )),
          isMaterialAppTheme: true,
          child: new Column(

            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2.0),
              ),
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.blue,
                iconSize: 100.0,
                tooltip: 'Increase volume by 10%',
                onPressed: () {      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                );
                },
              ),

                new MaterialButton(
                  child: Text("Check Out"),
                  minWidth: 200.0,
                  height: 100.0,
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );

                    // Do something here
                  },


                ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              IconButton(
                icon: Icon(Icons.check),
                color: Colors.blue,
                iconSize: 100.0,
                tooltip: 'Increase volume by 10%',
                onPressed: () { },
              ),

              new MaterialButton(
                child: Text("Check In"),
                minWidth: 200.0,
                height: 100.0,
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  // Do something here
                },
              ),

            ],
          ),
        ),
      ]),
    );

  }
}