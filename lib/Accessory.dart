class Accessory{
  String name;
  bool included;


  Accessory({
    this.name,
    this.included,
  });
  factory Accessory.fromJson(String name){
    return Accessory(
      name: name,
      included: false,
    );
  }
}