class Orders {
  static const tblOrder = 'orders';
  static const colId = 'orderId';
  static const colSLocation = 'sLocation';
  static const colSManager = 'sManager';
  static const colItemName = 'itemName';
  static const colSupplier = 'supplier';
  static const colPrice= 'price';
  static const colDate= 'date';
  static const colStatus= 'status';

  int orderId;
  String sLocation;
  String SManager;
  String itemName;
  String Supplier;
  int price;
  String date;
  String status;

  Orders({this.orderId,this.sLocation,this.SManager,this.itemName,this.Supplier,this.price,this.date,this.status});

  Orders.fromMap (Map map){
    orderId = map[colId];
    sLocation = map[colSLocation];
    SManager = map[colSManager];
    itemName = map[colItemName];
    Supplier = map[colSupplier];
    price = map[colPrice];
    date = map[colDate];
    status = map[colStatus];
  }

  Map<String ,dynamic> toMap(){
    var map = <String,dynamic>{colSLocation:sLocation,colSManager:SManager,colItemName:itemName,colSupplier:Supplier,colPrice:price,colDate:date,colStatus:status};
    if(orderId != null){
      map[colId]=orderId;
    }
    return map;
  }




}
