import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/api_calls.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_constants.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class VerificationController extends GetxController {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  TextEditingController phoneController;

  @override
  void onInit() {
    phoneController = TextEditingController();
    super.onInit();
  }

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
        Get.offAllNamed('/regverification/$phone');
      }
      if (postData[0] == 404) {
        _reusableWidgets.snackBar(
            'Wrong Number', 'No account exists with the given number');
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
