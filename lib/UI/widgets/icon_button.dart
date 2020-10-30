import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;
  ButtonWithIcon({this.onPressed, this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Container(
            child: Icon(
              icon,
              color: Colors.blue[300],
              size: Get.height / 25,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
