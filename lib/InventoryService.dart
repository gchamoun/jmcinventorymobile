import 'package:dio/Dio.dart';
import 'dart:async';
import 'package:jmcinventory/Item.dart';
import 'package:jmcinventory/global.dart';
 import 'dart:convert';

class InventoryService {
  var http = new Dio();

  Future<Item> getItem(int itemId) async{

    print('Requesting item:' + itemId.toString() + ': from codeigniter');

    //Response response = await http.post(baseUrl.toString() + 'mobile/getItem/' + itemId.toString());
    Response response = await http.post(baseUrl+ 'mobile/getItem/' +itemId.toString());
    print(response.data);
    print('converting JSON to Item object');
    var item = new Item.fromJson(jsonDecode(response.data));
    return item;
  }
  Future<bool> checkoutItem(int itemId, bool firstItem) async{
    print('checking out item: ' + itemId.toString() + 'from codeigniter');
    Response response = await http.post(baseUrl + 'inventory/mobile_checkout/' + itemId.toString());
    print(response.data);
    return (response.data == 1)? true: false;
  }
  Future<bool> checkoutItems (List<Item> items) async{
    bool first = true;

    for (Item item in items){
      //checkoutItem(item.id, first);
      if(first){
        first = false;
      }
      print('Checking out Item: ' + item.description.toString() + ' first: ' + first.toString());
    }

    return true;
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
