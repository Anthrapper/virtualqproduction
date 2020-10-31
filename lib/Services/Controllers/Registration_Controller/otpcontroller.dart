import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class OtpController extends GetxController {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  pop() {
    Get.back();
  }

  gotoHome() {
    Get.offAllNamed('/apphome');
  }

  Future getOtp() async {
    Map data = {
      "contact": Get.parameters['phone'],
    };
    print(Get.parameters['phone']);

    var response = await http.post(
      Urls.forgotPassOtp,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode);
    if (Get.isDialogOpen) {
      Get.back();
    }
    if (response.statusCode == 201) {
      Get.snackbar(
        'Success',
        'An Otp has been sent to your number',
        snackPosition: SnackPosition.BOTTOM,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
      );
    } else {
      throw Exception('Unknown error');
    }
  }

  Future verifyOtp(String pin) async {
    print(Get.parameters["phone"]);
    Map data = {
      "token": pin,
      "contact": Get.parameters["phone"],
    };

    var response = await http.post(
      Urls.signUpVerify,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    var jsonData = json.decode(response.body);
    print(jsonData);

    print(response.statusCode);
    if (Get.isDialogOpen) {
      Get.back();
    }
    if (response.statusCode == 201) {
      if (jsonData['status'] == 'verified') {
        _reusableWidgets
            .snackBar(
                'Account Verified',
                'Account has been verified successfully, Please login',
                Icons.assignment_turned_in)
            .then((value) => gotoHome());
      } else if (jsonData['status'] == 'failed') {
        _reusableWidgets.snackBar('Verification Failed',
            'Wrong OTP provided, please re enter OTP', Icons.error);
      }
    }
  }
}
