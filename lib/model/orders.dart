class Orders {
  static const tblOrder = 'orders';
  static const colId = 'orderId';
  static const colSLocation = 'SLocation';
  static const colSManager = 'SManager';
  static const colItemName = 'itemName';
  static const colSupplier = 'Supplier';
  static const colPrice= 'price';
  static const colDate= 'date';

  int orderId;
  String SLocation;
  String SManager;
  String itemName;
  String Supplier;
  int price;
  String date;

  Orders({this.orderId,this.SLocation,this.SManager,this.itemName,this.Supplier,this.price,this.date});

  Orders.fromMap (Map map){
    orderId = map[colId];
    SLocation = map[colSLocation];
    SManager = map[colSManager];
    itemName = map[colItemName];
    Supplier = map[colSupplier];
    price = map[colPrice];
    date = map[colDate];
  }

  Map<String ,dynamic> toMap(){
    var map = <String,dynamic>{colSLocation:SLocation,colSManager:SManager,colItemName:itemName,colSupplier:Supplier,colPrice:price,colDate:date};
    if(orderId != null){
      map[colId]=orderId;
    }
    return map;
  }




}
