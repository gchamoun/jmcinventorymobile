class Item{
  int id;
  int categoryId;
  String dateAdded;
  String dateModified;
  String dateDeleted;
  String serial;
  String description;
  var accessories;


  Item({
    this.id,
    this.categoryId,
    this.dateAdded,
    this.dateModified,
    this.dateDeleted,
    this.serial,
    this.description,
    this.accessories
  });
  factory Item.fromJson(Map<String, dynamic> parsedJson){
    return Item(
        id: int.tryParse(parsedJson['id']),
        categoryId : int.tryParse(parsedJson['category_id']),
        dateAdded :   parsedJson ['dateadded'],
        dateModified: parsedJson['datemodified'],
        dateDeleted: parsedJson['datedeleted'],
        description: parsedJson['description'],
        serial: parsedJson['serial'],
        accessories: parsedJson['accessories'],
    );
  }
}
