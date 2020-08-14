import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtualQ/utilitis/screensize.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ReusableWidgets {
  ScreenSize screenSize;
  final reqValidator = RequiredValidator(errorText: 'This Field Is Required');

  Widget customImage(BuildContext context, String text) {
    screenSize = ScreenSize().getSize(context);
    return Container(
      padding: EdgeInsets.only(top: 30),
      height: screenSize.height / 2.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(text),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget circleImage(BuildContext context, String image) {
    screenSize = ScreenSize().getSize(context);
    return Card(
      elevation: 25,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: CircleAvatar(
        radius: screenSize.width / 10,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(image),
      ),
    );
  }

  Widget customButton(
    BuildContext context,
    String text,
  ) {
    screenSize = ScreenSize().getSize(context);
    return Container(
      height: screenSize.height / 17,
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
    FaIcon icon,
    bool secureText,
  ) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[100],
          ),
        ),
      ),
      child: TextFormField(
        textAlign: TextAlign.justify,
        controller: controller,
        obscureText: secureText,
        validator: reqValidator,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 12),
            child: icon,
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
