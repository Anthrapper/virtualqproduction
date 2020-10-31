import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/api_calls.dart';
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_constants.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class ForgotOtpController extends GetxController {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  TextEditingController phoneController;

  @override
  void onInit() {
    phoneController = TextEditingController();
    super.onInit();
  }

  Future getOtp() async {
    Map data = {
      "contact": Get.parameters['phone'],
    };

    try {
      var postData = await ApiCalls().postRequest(
        url: Urls.forgotPassOtp,
        body: data,
        headers: ApiConstants().jsonHeader,
      );
      print(postData);
      if (postData[0] == 201) {
        Get.snackbar(
          'Success',
          'An Otp has been sent to your number',
          snackPosition: SnackPosition.BOTTOM,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
        );
      }
    } on SocketException {
      _reusableWidgets.noInternet();
    }
  }

  Future verifyOtp(String otp, String phone) async {
    Map data = {
      "token": otp,
      "contact": phone,
    };
    try {
      var postData = await ApiCalls().postRequest(
        url: Urls.passwordTokenGen,
        body: data,
        headers: ApiConstants().jsonHeader,
      );

      if (postData[0] == 201) {
        if (postData[1]['status'] == 'failed') {
          _reusableWidgets.snackBar(
              'Wrong Otp', 'Wrong otp provided, please try again', Icons.error);
        }
      }
      if (postData[0] == 200) {
        if (postData[1]['status'] == 'verified') {
          AuthenticationHelper()
              .storeToken(postData[1]['access'], postData[1]['refresh']);

          Get.offAllNamed('/passwordreset');
        }
      }
    } on SocketException {
      _reusableWidgets.noInternet();
    }
  }

  @override
  void onClose() {
    phoneController?.dispose();
    super.onClose();
  }
}
