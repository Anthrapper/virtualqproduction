import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:virtualq/Services/Controllers/Login_Controllers/verification_controller.dart';
import 'package:virtualq/Services/validator.dart';
import 'package:virtualq/UI/Animation/fadeanimation.dart';
import 'package:virtualq/UI/widgets/app_bar.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';

class VerifyAccount extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  final VerificationController _verificationController = Get.put(
    VerificationController(),
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Verify Account'),
      body: SafeArea(
        child: ListView(
          children: [
            _reusableWidgets.customSvg('assets/images/verify.svg'),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.05),
                child: _reusableWidgets.customContainer(
                  _reusableWidgets.customTextfield(
                    'Enter Phone Number',
                    _verificationController.phoneController,
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
                    _verificationController
                        .getOtp(_verificationController.phoneController.text);
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
