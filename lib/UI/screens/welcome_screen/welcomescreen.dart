import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualq/Services/Controllers/Welcome_Controller/welcome_controller.dart';
import 'package:virtualq/UI/Animation/fadeanimation.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeController _welcomeController = Get.put(WelcomeController());
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
            _reusableWidgets.customSvg('assets/images/q.svg'),
          ),
          FadeAnimation(
            1.2,
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                    child: Obx(
                      () => FlatButton(
                        onPressed: () {
                          _welcomeController.changeColorOne();
                          Get.updateLocale(Locale('en'));
                        },
                        child: Text(
                          'English',
                          style: TextStyle(
                            fontSize: 16,
                            color: _welcomeController.buttonOneColor.value,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(() => FlatButton(
                          onPressed: () {
                            _welcomeController.changeColorTwo();
                            Get.updateLocale(Locale('ml'));
                          },
                          child: Text(
                            'മലയാളം',
                            style: TextStyle(
                              fontSize: 15,
                              color: _welcomeController.buttonTwoColor.value,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          FadeAnimation(
            1.3,
            Padding(
              padding: EdgeInsets.fromLTRB(10, Get.height * 0.05, 10, 0),
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
              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
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
    padding: const EdgeInsets.only(top: 30),
    child: Center(
      child: Text(
        'Welcome To virtualq',
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
