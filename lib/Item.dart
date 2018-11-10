class Item{
  int id;
  int categoryId;
  String dateAdded;
  String dateModified;
  String dateDeleted;
  String serial;
  String title;
  String description;
  var accessories;


  Item({
    this.id,
    this.categoryId,
    this.dateAdded,
    this.dateModified,
    this.dateDeleted,
    this.serial,
    this.title,
    this.description,
    this.accessories
  });
  factory Item.fromJson(Map<String, dynamic> parsedJson){
    return Item(
        id: int.tryParse(parsedJson['id']),
        categoryId : int.tryParse(parsedJson['category_id']),
        dateAdded :  parsedJson ['dateadded'],
        dateModified: parsedJson['datemodified'],
        dateDeleted: parsedJson['datedeleted'],
        serial: parsedJson['serial'],
        title: parsedJson['title'],
        description: parsedJson['description'],
        accessories: parsedJson['accessories'],
    );
  }
}
