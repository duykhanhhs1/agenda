// import 'package:form_field_validator/form_field_validator.dart';
//
// class NumberValidator extends TextFieldValidator {
//   NumberValidator({String errorText = 'Please enter a number'})
//       : super(errorText);
//
//   @override
//   bool get ignoreEmptyValues => true;
//
//   @override
//   bool isValid(String value) {
//     try {
//       final num = int.parse(value);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }