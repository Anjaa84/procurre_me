import 'package:flutter_project/screens/order_page.dart';
import 'package:flutter_test/flutter_test.dart';



void main(){


  test('Title',(){
  });
  test('non-empty name error String',(){

    var result=SiteLocationValidator.validate('');
    expect(result, 'Location cannot be null');
  });

  test('non-empty name error String',(){

    var result=PriceOrder.validate('');
    expect(result, 'Price cannot be null');
  });



}