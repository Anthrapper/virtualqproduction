import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualq/Services/Controllers/Login_Controllers/forgot_otp_controller.dart';
import 'package:virtualq/UI/Animation/fadeanimation.dart';
import 'package:virtualq/UI/widgets/app_bar.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:get/route_manager.dart';

class ForgotOtpVerification extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  final ForgotOtpController _forgotOtpController =
      Get.put(ForgotOtpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Otp Verification'),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(top: Get.height * 0.03),
                child:
                    _reusableWidgets.customSvg('assets/images/forgotpass.svg')),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.06, horizontal: Get.width * 0.04),
              child: _reusableWidgets.customContainer(
                Container(
                  margin: const EdgeInsets.all(8),
                  child: PinEntryTextField(
                    fields: 4,
                    showFieldAsBox: false,
                    onSubmit: (String pin) {
                      _reusableWidgets.progressIndicator();
                      print(Get.parameters['phone']);

                      _forgotOtpController.verifyOtp(
                        pin,
                        Get.parameters['phone'],
                      );
                    },
                  ),
                ),
              ),
            ),
            FadeAnimation(
              1.7,
              Center(
                child: InkWell(
                  onTap: () {
                    _forgotOtpController.getOtp();
                  },
                  child: Text(
                    "Resend Otp",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.lightBlue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
