class Item {
  static const tblItem = 'items';
  static const colId = 'itemId';
  static const colName = 'itemName';
  static const colBrand = 'itemBrand';
  static const colPrice = 'itemPrice';

  int itemId;
  String itemName;
  String itemBrand;
  String itemPrice;

  Item({this.itemId,this.itemName,this.itemBrand,this.itemPrice});

  Item.fromMap (Map map){
    itemId = map[colId];
    itemName = map[colName];
    itemBrand = map[colBrand];
    itemPrice = map[colPrice];
  }

  Map<String ,dynamic> toMap(){
    var map = <String,dynamic>{colName:itemName,colBrand:itemBrand,colPrice:itemPrice};
    if(itemId != null){
      map[colId]=itemId;
    }
    return map;
  }




}
