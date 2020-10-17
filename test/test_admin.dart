import 'package:flutter_project/model/supplier.dart';
import 'package:flutter_project/screens/admin_page.dart';
import 'package:flutter_project/screens/item_page.dart';
import 'package:flutter_project/screens/supplier_page.dart';
import 'package:flutter_test/flutter_test.dart';



void main(){


  test('Title',(){
  });
  test('non-empty name error String',(){

    var result=FirstNameValidation.validate('');
    expect(result, 'First Name cannot be null');
  });

  test('non-empty name error String',(){

    var result=LastNameValidation.validate('');
    expect(result, 'Last Name  cannot be null');
  });

  test('non-empty name error String',(){

    var result=EmailValidation.validate('');
    expect(result, 'Email cannot be null');
  });

  test('non-empty name error String',(){

    var result=PasswordValidation.validate('');
    expect(result, 'Passoword cannot be null');
  });


}