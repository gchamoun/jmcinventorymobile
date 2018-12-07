class Item {
  int id;
  int categoryId;
  String dateAdded;
  String dateModified;
  String dateDeleted;
  String serial;
  String description;
  var accessories;
  List<String> accessoriesList;
  List<bool> accessoriesIncluded;

  Item({
    this.id,
    this.categoryId,
    this.dateAdded,
    this.dateModified,
    this.dateDeleted,
    this.serial,
    this.description,
    this.accessories,
    this.accessoriesList,
    this.accessoriesIncluded,
  });

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    List<String> tempList = new List();
    List<bool> tempIncluded = new List();
    var temp = parsedJson['accessories'];
    for (var item in temp) {
      tempList.add(item + '');
      tempIncluded.add(false);
    }

    return Item(
      id: int.tryParse(parsedJson['id']),
      categoryId: int.tryParse(parsedJson['category_id']),
      dateAdded: parsedJson['dateadded'],
      dateModified: parsedJson['datemodified'],
      dateDeleted: parsedJson['datedeleted'],
      description: parsedJson['description'],
      serial: parsedJson['serial'],
      accessoriesList: tempList,
      accessoriesIncluded: tempIncluded,
    );
  }
}
