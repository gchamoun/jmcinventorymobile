import 'package:dio/Dio.dart';
import 'dart:async';
import 'package:jmcinventory/Item.dart';
import 'package:jmcinventory/global.dart';
 import 'dart:convert';

class InventoryService {
  var http = new Dio();

  Future<Item> getItem(String itemId) async{
    print('Requesting item: ' + itemId + ' from codeigniter');
    Response response = await http.post(baseUrl + '/mobile/getItem/' + itemId);
    print(response.data);
    print('converting JSON to Item object');
    var item = new Item.fromJson(jsonDecode(response.data));
    return item;
  }
  Future<bool> checkoutItem(int itemId) async{
    print('checking out item: ' + itemId.toString() + 'from codeigniter');
    Response response = await http.post(baseUrl + 'inventory/mobile_checkout/' + itemId.toString());
    print(response.data);
    return (response.data == 1)? true: false;
  }
  Future<bool> checkinItem(int itemId) async{
    print('checking in item: ' + itemId.toString() + 'from codeigniter');
    Response response = await http.post(baseUrl + 'inventory/mobile_checkin/' + itemId.toString());
    print(response.data);
    return (response.data == 1)? true: false;
  }

  Future<bool> GetReservation(int itemId) async{
    print('checking in item: ' + itemId.toString() + 'from codeigniter');
    Response response = await http.post(baseUrl + 'inventory/mobile_checkin/' + itemId.toString());
    print(response.data);
    return (response.data == 1)? true: false;
  }
}
