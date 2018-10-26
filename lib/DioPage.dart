import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';

class DioPage extends StatelessWidget {

  fetchData()async {
    Dio dio = new Dio();
    Response<String> response=await dio.get("https://www.baidu.com/");
    print(response.data);
  }
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
            child: new IconButton(icon:new Icon(Icons.all_inclusive) , onPressed: (){
              fetchData();
            })
        ),
      ),
    );
  }
}