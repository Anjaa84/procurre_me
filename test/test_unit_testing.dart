import 'package:flutter_project/model/supplier.dart';
import 'package:flutter_project/screens/supplier_page.dart';
import 'package:flutter_test/flutter_test.dart';



void main(){


  test('Title',(){
  });
  test('empty supplier name error String',(){

    var result=SupplierNameValidator.validate('');
    expect(result, 'Supplier name cannot be null');
  });
}