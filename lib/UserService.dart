import 'package:dio/Dio.dart';
import 'dart:async';
import 'package:jmcinventory/User.dart';

class UserService {
  String baseUrl = "http://192.168.2.11:80/";
  var http = new Dio();

  Future<User> loginSubmit(FormData formData) async {
    Response response =
        await http.post(baseUrl + "/auth/mobile_login", data: formData);

    // make http request and return user object
    //else return submitted user object with loggedIn = false
  }

  Future<User> logoutUser(User user) {
    // http request to mark user as logged out in the database.
    // should return a boolean result on the User object on logging-out
  }

  Future<User> getUser(int userId) {
    // http request fot user by userId. create User object from json response
  }
}
