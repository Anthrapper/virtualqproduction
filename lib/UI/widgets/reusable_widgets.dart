import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/utilitis/screensize.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ReusableWidgets {
  ScreenSize screenSize;
  final reqValidator = RequiredValidator(errorText: 'This Field Is Required');

  Widget customImage(BuildContext context, String text) {
    screenSize = ScreenSize().getSize(context);
    return FadeAnimation(
      0.5,
      Container(
        padding: EdgeInsets.only(top: 30),
        height: screenSize.height / 2.6,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(text),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget customContainer(
    Widget widget,
  ) {
    return FadeAnimation(
      1,
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(143, 148, 251, .2),
              blurRadius: 20.0,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: widget,
      ),
    );
  }

  Widget customText(
    String text,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      alignment: Alignment.bottomLeft,
      child: Text(
        text,
        softWrap: true,
        overflow: TextOverflow.fade,
        style: TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );
  }

  customDialog(
      BuildContext context, String title, String desc, AlertType alertType) {
    Alert(
      context: context,
      type: alertType,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue,
              Colors.lightBlueAccent[200],
            ],
          ),
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          height: 50,
          width: 150,
        )
      ],
    ).show();
  }

  logOutDialog(
    BuildContext context,
    String title,
    String desc,
  ) {
    return Alert(
      context: context,
      title: title,
      desc: desc,
      image: Image.asset(
        "assets/images/logout.png",
        height: 100,
        width: 100,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            AuthenticationHelper().removeToken();
            Navigator.pushNamedAndRemoveUntil(
                context, 'apphome', (route) => false);
          },
          gradient: LinearGradient(
            colors: [
              Colors.green[600],
              Colors.greenAccent[700],
            ],
          ),
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue,
              Colors.lightBlueAccent[200],
            ],
          ),
        )
      ],
    ).show();
  }

  Widget customButton(
    BuildContext context,
    String text,
  ) {
    screenSize = ScreenSize().getSize(context);
    return Container(
      height: screenSize.height / 20,
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
    Function validator,
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
        validator: validator,
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
