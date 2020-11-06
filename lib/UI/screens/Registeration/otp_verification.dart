import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:virtualq/Services/Controllers/Registration_Controller/otpcontroller.dart';
import 'package:virtualq/UI/Animation/fadeanimation.dart';
import 'package:virtualq/UI/widgets/app_bar.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';

class OtpVerification extends StatelessWidget {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  final OtpController _otpController = Get.put(OtpController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Verify Your Mobile Number',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
                child:
                    _reusableWidgets.customSvg('assets/images/forgotpass.svg'),
              ),
              _reusableWidgets.customContainer(
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: PinEntryTextField(
                      fields: 4,
                      showFieldAsBox: false,
                      onSubmit: (String pin) {
                        print(pin);
                        if (_formKey.currentState.validate()) {
                          _reusableWidgets.progressIndicator();
                          _otpController.verifyOtp(pin);
                        }
                      },
                    ),
                  ),
                ),
              ),
              FadeAnimation(
                1.2,
                InkWell(
                  onTap: () {
                    _reusableWidgets.progressIndicator();
                    _otpController.getOtp();
                  },
                  child: _reusableWidgets.customButton(
                    'Resend Otp',
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
