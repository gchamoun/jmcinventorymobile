import 'package:dio/Dio.dart';
import 'dart:async';
import 'package:jmcinventory/Item.dart';
import 'package:jmcinventory/global.dart';
 import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



class InventoryService {
  var http = new Dio();

  Future<Item> getItem(int itemId) async{
    print('Requesting item:' + itemId.toString() + ': from codeigniter');
    Response response = await http.post(baseUrl+ 'mobile/getItem/' +itemId.toString());
    print(response.data);
    print('converting JSON to Item object');
    var item = new Item.fromJson(jsonDecode(response.data));
    return item;
  }
  Future<bool> checkoutItem(int itemId, bool firstItem) async{
    final prefs = await SharedPreferences.getInstance();
    final currentUserId = prefs.getString('userId') ?? 0;
    final currentEmployeeId = prefs.getInt('employeeId') ?? 0;
    print('checking out item: ' + itemId.toString() + 'from codeigniter');
    Response response = await http.post(baseUrl + 'mobile/checkOutItems/'
        + currentUserId.toString() + '/'
        +  currentEmployeeId.toString() + '/'
        + itemId.toString() + '/'
        + (firstItem? '0':'1')
        );
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

  Future<List<Item>> getUsersItems (int userId) async{

     List<Item> itemList = new List();
    final response = await http.post(baseUrl + 'mobile/getUsersCheckin/' + userId.toString());

Map itemMap = json.decode(response.data);


    List tempList = new List();
    for (int i = 0; i < itemMap["results"].length; i++) {
      print(itemMap["results"][i]);
      tempList.add(itemMap["results"][i]);
    }

     for(var jsonString in tempList){
      int id = (int.tryParse(jsonString["item_id"]));

      Item item = await getItem(id);

      itemList.add(item);
  }
  print(itemList);

  return itemList;
    }



  Future<bool> checkinItem(int workerCheckinId, int itemId) async{
    print('checking in item: ' + itemId.toString() + 'from codeigniter');
    Response response = await http.post(baseUrl + 'mobile/individualCheckin/' + workerCheckinId.toString() + '/' + itemId.toString());
    print(itemId.toString());
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
