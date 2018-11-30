import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';
import 'package:jmcinventory/Checkout.dart';

class _LoginData
{
  String email = '';
  String password = '';
}


class UserPage extends StatefulWidget {
@override
State<StatefulWidget> createState() => new _UserPageState();
}

class _UserPageState extends State<UserPage> {


  Future<List<User>> _getUsers()async {
    var dio = new Dio();
    dio.options.baseUrl = "http://192.168.64.2:80/users/mobile_getallusers";

    //Response response = await dio.post("/token", data: formData);
    Response response = await dio.post("http://192.168.1.213/users/mobile_getallusers");
var jsonData = json.decode(response.data);

List<User> users = [];
for(var u in jsonData){
  User user= User(u["email"]);

  users.add(user);
}     print(users.length);

return users;
  }


  @override
  Widget build(BuildContext context) {
    _getUsers();
    return new Scaffold(appBar: AppBar(
    backgroundColor: Colors.blue,
        title: Text("Users"),
    ),
      body: Container(
        child:FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text("Loading..."),
                )
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){

                return ListTile(
                  title:Text(snapshot.data[index].email),
                  onTap:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Checkout()),
                    );
                  },
                );

              },
            );
          },

        ),
      )

    );
  }
}
class User {
  final String email;
  User(this.email);
}
