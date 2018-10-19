import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}



void main() => runApp(new TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {

                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
    void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
        new Image(
          image: new AssetImage("assets/Samford.jpg"),
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black87,
        ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image(
                  image: new AssetImage("assets/jmcLogo.jpg"),height: 150.00),

              new Container(
                padding: const EdgeInsets.all(40.0),
                child: new Form(
                  autovalidate: true,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(
                            labelText: "Enter Email", fillColor: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                            labelText: "Enter Password",fillColor: Colors.white
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                      ),

                      new Padding(
                        padding: const EdgeInsets.only(top:40.0),
                      ),

                      new Row(     mainAxisSize: MainAxisSize.max,

                        children: <Widget>[

                      new MaterialButton(

                          height: 50.0,
                          minWidth: 110.0,
                          color: Colors.indigo[900],
                          splashColor: Colors.indigo[900],
                          textColor: Colors.white,                          onPressed: () { Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                      },

                          child: Column(
                            children:<Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(top:8.0),
                              ),
                              new Icon(FontAwesomeIcons.userPlus),new Padding(
                                padding: const EdgeInsets.only(top:8.0),
                              ),
                              Text("Signup"),
                              new Padding(
                                padding: const EdgeInsets.only(top:8.0),
                              ),
                            ],

                          )

                      ),
                      new Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                      ),
                      new MaterialButton(

                          height: 50.0,
                          minWidth: 110.0,
                          color: Colors.indigo[900],
                          splashColor: Colors.indigo[900],
                          textColor: Colors.white,                          onPressed: () {},

                          child: Column(
                            children:<Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(top:8.0),
                              ),
                              new Icon(FontAwesomeIcons.signInAlt),
                              new Padding(
                                padding: const EdgeInsets.only(top:8.0),
                              ),

                              Text("Login"),
                              new Padding(
                                padding: const EdgeInsets.only(top:8.0),
                              ),
                            ],

                          )

                      )],
  )],

                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

}
class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(appBar: AppBar(
      backgroundColor: Colors.indigo[900],
      title: Text("Signup"),
    ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
      new Image(
      image: new AssetImage("assets/Samford.jpg"),
      fit: BoxFit.cover,
      colorBlendMode: BlendMode.darken,
      color: Colors.black87,
    ),

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


    new Container(
    padding: const EdgeInsets.all(40.0),
    child: new Form(
    autovalidate: true,
    child: new Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[



    new TextFormField(
    decoration: new InputDecoration(
    labelText: "Enter Email", fillColor: Colors.white),
    keyboardType: TextInputType.emailAddress,
    ),
    new TextFormField(
    decoration: new InputDecoration(
    labelText: "Enter Password",fillColor: Colors.white
    ),
    obscureText: true,
    keyboardType: TextInputType.text,
    ),
    new TextFormField(
      decoration: new InputDecoration(
          labelText: "Confirm Password",fillColor: Colors.white
      ),
      obscureText: true,
      keyboardType: TextInputType.text,
    ),
    new Padding(
    padding: const EdgeInsets.only(top:40.0),
    ),

    new Container(     width: double.infinity,


    child: new MaterialButton(

    color: Colors.indigo[900],
    splashColor: Colors.indigo[900],
    textColor: Colors.white,                          onPressed: () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignupScreen()),
    );
    },

    child: Column(
    children:<Widget>[
    new Padding(
    padding: const EdgeInsets.only(top:8.0),
    ),
    new Icon(FontAwesomeIcons.userPlus),new Padding(
    padding: const EdgeInsets.only(top:8.0),
    ),
    Text("Signup"),
    new Padding(
    padding: const EdgeInsets.only(top:8.0),
    ),
    ],

    )

    ),
    )],


    ),
    ),
    )
    ],
    ),
    ),
    ]),
    );

  }
}
