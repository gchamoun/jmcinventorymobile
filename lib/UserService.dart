import 'package:dio/Dio.dart';
import 'dart:async';
import 'package:jmcinventory/User.dart';

class UserService{
  Future<User> LoginUser(User user){
  // make http request and return user object
    //else return submitted user object with loggedIn = false
  }
  Future<User> logoutUser(User user){
   // http request to mark user as logged out in the database.
   // should return a boolean result on the User object on logging-out
  }
  Future<User> getUser(int userId){
    // http request fot user by userId. create User object from json response
  }
}