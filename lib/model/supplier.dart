class Supplier {
  static const tblSupplier = 'supplier';
  static const colId = 'supplierId';
  static const colCompanyName = 'companyName';


  int supplierId;
  String companyName;



  Supplier({this.supplierId,this.companyName});

  Supplier.fromMap (Map map){
    supplierId = map[colId];
    companyName = map[colCompanyName];

  }

  Map<String ,dynamic> toMap(){
    var map = <String,dynamic>{colCompanyName:companyName};
    if(supplierId != null){
      map[colId]=supplierId;
    }
    return map;
  }




}
