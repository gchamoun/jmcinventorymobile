import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

void main() => runApp(new MaterialApp(
  title: 'Forms in Flutter',
  home: new LoginPage(),
));

class User {
  final String id;

  User(this.id);

  User.fromJson(Map<String, String> json)
      : id = json['id'];
  Map<String, String> toJson() =>
      {
        'id': id
      };
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginData {
  String email = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 3) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      fetchData();
    }
  }
  fetchData()async {
    var dio = new Dio();
    dio.options.baseUrl = "http://192.168.64.2:80/auth/login";

    FormData formData = new FormData.from({
      "email": '${_data.email}',
      "password": '${_data.password}'
    });

    print("***********************************************************************************");
    //Response response = await dio.post("/token", data: formData);
    Response response = await dio.post("http://192.168.64.2:80/auth/mobile_login", data: formData);
    Map userMap = json.decode(response.data);
    var user = new User.fromJson(userMap);
    print("***********************************************************************************");
    print('Howdy, ${user.id}!');

    print("***********************************************************************************");
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    // Use email input type for emails.
                    decoration: new InputDecoration(
                        hintText: 'you@example.com',
                        labelText: 'E-mail Address'
                    ),
                    validator: this._validateEmail,
                    onSaved: (String value) {
                      this._data.email = value;
                    }
                ),
                new TextFormField(
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        hintText: 'Password',
                        labelText: 'Enter your password'
                    ),
                    validator: this._validatePassword,
                    onSaved: (String value) {
                      this._data.password = value;
                    }
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Login',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: this.submit,
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

