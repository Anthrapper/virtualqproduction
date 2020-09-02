import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FadeAnimation(0.7, _heading()),
          FadeAnimation(0.8, _subHeading()),
          FadeAnimation(
            1,
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: _reusableWidgets.customSvg('assets/images/q.svg'),
            ),
          ),
          FadeAnimation(
            1.3,
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
              child: InkWell(
                onTap: () {
                  Get.toNamed('/login');
                },
                child: _reusableWidgets.customButton('Login'),
              ),
            ),
          ),
          FadeAnimation(
            1.4,
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: InkWell(
                onTap: () {
                  Get.toNamed('/register');
                },
                child: _reusableWidgets.customButton('Register'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _heading() {
  return Container(
    padding: const EdgeInsets.only(top: 60),
    child: Center(
      child: Text(
        'Welcome To VirtualQ',
        style: TextStyle(
          color: Colors.lightBlue[900],
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _subHeading() {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Center(
      child: Text(
        'Stay Apart. Stay Safe',
        style: TextStyle(
          color: Colors.lightBlue[800],
          fontSize: 15,
        ),
      ),
    ),
  );
}
