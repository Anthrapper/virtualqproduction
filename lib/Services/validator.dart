import 'package:form_field_validator/form_field_validator.dart';

class FormValidator {
  final reqValidator = RequiredValidator(errorText: 'This Field Is Required');

  final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(8,
          errorText: 'password must be at least 8 characters long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'passwords must have at least one special character'),
    ],
  );
  final mobileValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'This field is required'),
      LengthRangeValidator(
          min: 10, max: 10, errorText: 'Mobile Number must be of 10 digit')
    ],
  );
}
