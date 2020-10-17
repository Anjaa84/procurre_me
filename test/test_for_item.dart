import 'package:flutter_project/model/supplier.dart';
import 'package:flutter_project/screens/item_page.dart';
import 'package:flutter_project/screens/supplier_page.dart';
import 'package:flutter_test/flutter_test.dart';



void main(){


  test('Title',(){
  });
  test('non-empty name error String',(){

    var result=itemNameValidator.validate('');
    expect(result, 'item name cannot be null');
  });

  test('non-empty name error String',(){

    var result=itemBrand.validate('');
    expect(result, 'item brand cannot be null');
  });

  test('non-empty name error String',(){

    var result=itemPrice.validate('');
    expect(result, 'item Price cannot be null');
  });


}