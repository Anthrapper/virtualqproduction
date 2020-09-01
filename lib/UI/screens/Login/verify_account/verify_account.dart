import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/Controllers/Login_Controllers/verification_controller.dart';
import 'package:virtualQ/Services/validator.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';

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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 60),
              child: _reusableWidgets.customSvg('assets/images/verify.svg'),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: InkWell(
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
            ),
          ],
        ),
      ),
    );
  }
}
