import 'package:flutter/material.dart';
import 'package:virtualQ/utilitis/screensize.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ReusableWidgets {
  ScreenSize screenSize;
  final reqValidator = RequiredValidator(errorText: 'This Field Is Required');

  Widget customButton(
    String text,
  ) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Colors.lightBlue,
            Colors.lightBlueAccent[200],
          ],
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget customTextfield(
    String hintText,
    TextEditingController controller,
    Icon icon,
    bool secureText,
  ) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]),
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: secureText,
        validator: reqValidator,
        decoration: InputDecoration(
          prefixIcon: icon,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
