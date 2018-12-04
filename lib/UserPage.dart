import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
import 'package:jmcinventory/global.dart';

import 'dart:convert';
import 'dart:async';
import 'package:jmcinventory/Checkout.dart';
import 'package:jmcinventory/User.dart';
import 'package:jmcinventory/Global.dart';
import 'package:shared_preferences/shared_preferences.dart';




class UserPage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _UserPageState createState() => new _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Users' );

  _UserPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,

      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['email'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['email']),
//          onTap: () => print(filteredNames[index]['email']),
          //          onTap: () => print(filteredNames[index]['email']),
          onTap: () =>              getUserId(index),

        );
      },
    );
  }
  Future getUserId(index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userEmail', filteredNames[index]['email']);
    final userEmail = prefs.getString('userEmail') ?? 0;
    print(userEmail);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Checkout()),
    );

  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Users' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = await dio.get('https://swapi.co/api/people');

    final response2 = await dio.get('http://192.168.1.213/mobile/getallusers');
 Map userMap = json.decode(response2.data);


    List tempList = new List();
    for (int i = 0; i < userMap['results'].length; i++) {
      print(userMap['results'][i]);
      tempList.add(userMap['results'][i]);
    }

    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }


}