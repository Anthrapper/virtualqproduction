import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/Controllers/Login_Controllers/forgot_controller.dart';
import 'package:virtualQ/Services/validator.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

class ForgotPass extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  final ForgotController _forgotController = Get.put(ForgotController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.lightBlue[900],
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 60),
              child: _reusableWidgets.customSvg('assets/images/forgot.svg'),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: _reusableWidgets.customContainer(
                  _reusableWidgets.customTextfield(
                    'Enter Phone Number',
                    _forgotController.phoneController,
                    FaIcon(Icons.phone),
                    false,
                    FormValidator().mobileValidator,
                  ),
                ),
              ),
            ),
            FadeAnimation(
              1.2,
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: InkWell(
                  child: _reusableWidgets.customButton('Get OTP'),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _reusableWidgets.progressIndicator();
                      _forgotController
                          .getOtp(_forgotController.phoneController.text);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
