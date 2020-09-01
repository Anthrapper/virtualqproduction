import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/Controllers/Login_Controllers/forgot_otp_controller.dart';
import 'package:virtualQ/UI/Animation/fadeanimation.dart';
import 'package:virtualQ/UI/widgets/app_bar.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
                child:
                    _reusableWidgets.customSvg('assets/images/forgotpass.svg'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
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
                Padding(
                  padding: const EdgeInsets.only(top: 30),
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
      ),
    );
  }
}
