import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ReusableWidgets {
  final reqValidator = RequiredValidator(errorText: 'This Field Is Required');
  Widget customSvg(String text) {
    return FadeAnimation(
      0.5,
      Container(
        padding: EdgeInsets.only(top: 10),
        height: Get.height / 2.7,
        width: Get.width / 1.2,
        child: SvgPicture.asset(text),
      ),
    );
  }

  Widget customImage(String text) {
    return FadeAnimation(
      0.5,
      Container(
        padding: EdgeInsets.only(top: 30),
        height: Get.height / 2.6,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(text),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Future progressIndicator() {
    return Get.dialog(
      Center(
        child: CircularProgressIndicator(
          semanticsLabel: 'Processing..',
        ),
      ),
      barrierDismissible: false,
    );
  }

  snackBar(String title, String desc) {
    return Get.snackbar(
      title,
      desc,
      backgroundColor: Colors.grey[400],
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future okButtonDialog(
      String title, String desc, Function nav, IconData icon) {
    return Get.dialog(
      Center(
        child: Container(
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
          height: Get.height / 3,
          width: Get.width / 1.4,
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    icon,
                    size: 90,
                    color: Colors.red[700],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 13, 20, 15),
                  child: Text(
                    desc,
                    style: TextStyle(fontSize: 17, color: Colors.blue[900]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    color: Colors.blue,
                    child: Text(
                      'Ok',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      nav();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future twoButtonDialog(String title, String desc, Function nav, IconData icon,
      {Function work}) {
    return Get.dialog(
      Center(
        child: Container(
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
          height: Get.height / 2.8,
          width: Get.width / 1.4,
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    icon,
                    size: 90,
                    color: Colors.red[700],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Text(
                    desc,
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 3, 15, 2),
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        color: Colors.blue,
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        color: Colors.blue,
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          work();
                          nav();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
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

  Widget customButton(
    String text,
  ) {
    return Container(
      height: Get.height / 20,
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
      padding: const EdgeInsets.all(8.0),
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
            padding: const EdgeInsets.only(top: 12),
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
