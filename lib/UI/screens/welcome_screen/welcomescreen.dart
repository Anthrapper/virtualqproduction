import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60),
            child: Center(
              child: Text(
                'Welcome To VirtualQ',
                style: TextStyle(
                  color: Colors.lightBlue[900],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Stay Apart. Stay Safe',
                style: TextStyle(
                  color: Colors.lightBlue[800],
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: _reusableWidgets.customSvg('assets/images/q.svg'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
            child: InkWell(
              onTap: () {
                Get.toNamed('/login');
              },
              child: _reusableWidgets.customButton('Login'),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: InkWell(
              onTap: () {
                Get.toNamed('/register');
              },
              child: _reusableWidgets.customButton('Register'),
            ),
          ),
        ],
      ),
    );
  }
}
