import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';

class DioPage extends StatelessWidget {

  fetchData()async {
    var dio = new Dio();
    dio.options.baseUrl = "http://172.31.172.113:80/auth/login";

    FormData formData = new FormData.from({
      "email": "admin@admin.com",
      "password": "1234",
      "isMobile": true,

    });
    print("***********************************************************************************");
    //Response response = await dio.post("/token", data: formData);
    Response response = await dio.post("http://172.31.172.113:80/auth/login", data: formData);
    print("***********************************************************************************");
    print(response.data);
    print("***********************************************************************************");

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