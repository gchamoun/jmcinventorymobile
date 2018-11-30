import 'package:dio/Dio.dart';
import 'dart:async';
import 'package:jmcinventory/Item.dart';

class InventoryService {
  String baseUrl = "http://1192.168.1.254/";
  var http = new Dio();

  Future<Item> getItem(String itemId) async{
    print('Requesting item: ' + itemId + ' from codeigniter');
    Response response = await http.post(baseUrl + 'inventory/mobile_getitem/' + itemId);
    print('converting JSON to Item object');
    var item = new Item.fromJson(response.data);
    return item;
  }
  Future<bool> checkoutItem(int itemId) async{
    print('checking out item: ' + itemId.toString() + 'from codeigniter');
    Response response = await http.post(baseUrl + 'inventory/mobile_checkout/' + itemId.toString());
    print(response.data);
    return (response.data == 1)? true: false;
  }
}