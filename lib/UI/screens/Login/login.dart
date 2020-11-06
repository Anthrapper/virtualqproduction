import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:virtualq/Services/Controllers/Login_Controllers/login_controller.dart';
import 'package:virtualq/Services/validator.dart';
import 'package:virtualq/UI/Animation/fadeanimation.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _heading(),
              _image(),
              _reusableWidgets.customContainer(
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _reusableWidgets.customTextfield(
                        'Enter Phone Number',
                        _loginController.phoneController,
                        FaIcon(Icons.phone),
                        false,
                        FormValidator().mobileValidator,
                      ),
                      _reusableWidgets.customTextfield(
                        'Password',
                        _loginController.passController,
                        FaIcon(Icons.security),
                        true,
                        FormValidator().reqValidator,
                      ),
                    ],
                  ),
                ),
              ),
              FadeAnimation(
                1.5,
                InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _reusableWidgets.progressIndicator();
                      _loginController.login(
                        _loginController.phoneController.text,
                        _loginController.passController.text,
                      );
                    }
                  },
                  child: _reusableWidgets.customButton('Login'),
                ),
              ),
              FadeAnimation(
                1.7,
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/forgotpass');
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.lightBlue[900],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/verify');
                        },
                        child: Text(
                          "Verify account ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.lightBlue[900],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _heading() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        'login'.tr,
        style: TextStyle(
          color: Colors.lightBlue[900],
          fontSize: Get.width / 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _image() {
    return _reusableWidgets.customSvg('assets/images/signin.svg');
  }
}
