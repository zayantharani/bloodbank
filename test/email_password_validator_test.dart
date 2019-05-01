import 'package:bloodbank/LoginPage.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('empty email returns error', (){
    var result = EmailFieldValidator.validate('');
    expect(result, 'Please Type an Email.');
  });

  test('non-empty email returns null', (){
    var result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty password return error string', (){
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Password length should be greater than 6.');
  });

  test('non-empty password return error string', (){
    var result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });
}