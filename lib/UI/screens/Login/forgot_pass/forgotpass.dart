import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:virtualq/Services/Controllers/Login_Controllers/forgot_controller.dart';
import 'package:virtualq/Services/validator.dart';
import 'package:virtualq/UI/Animation/fadeanimation.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';

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
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.03),
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.lightBlue[900],
                  fontSize: Get.width * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _reusableWidgets.customSvg('assets/images/forgot.svg'),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.07),
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
              InkWell(
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
          ],
        ),
      ),
    );
  }
}
