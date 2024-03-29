import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualq/Services/api_calls.dart';
import 'package:virtualq/UI/widgets/reusable_widgets.dart';
import 'package:virtualq/utilitis/constants/api_constants.dart';
import 'package:virtualq/utilitis/constants/api_urls.dart';

class ForgotController extends GetxController {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  pop() {
    Get.back();
  }

  @override
  void onInit() {
    phoneController = TextEditingController();
    super.onInit();
  }

  TextEditingController phoneController;
  Future getOtp(String phone) async {
    Map data = {
      "contact": phone,
    };

    try {
      var postData = await ApiCalls().postRequest(
        url: Urls.forgotPassOtp,
        body: data,
        headers: ApiConstants().jsonHeader,
      );

      if (postData[0] == 201) {
        Get.toNamed('/otp/$phone');
      }
      if (postData[0] == 404) {
        _reusableWidgets.snackBar('Wrong Number',
            'No account exists with the given number', Icons.error);
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
