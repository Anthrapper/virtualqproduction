import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/api_calls.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_constants.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class PasswordResetController extends GetxController {
  TextEditingController pass;
  TextEditingController confPass;

  @override
  void onInit() {
    pass = TextEditingController();
    confPass = TextEditingController();
    super.onInit();
  }

  Future resetPassword(String pass) async {
    var data = {'password': pass};

    try {
      var headers = await ApiConstants().getHeader();
      print(headers);
      List postData = await ApiCalls().postRequest(
        body: data,
        url: Urls.passReset,
        headers: headers,
      );
      print(postData);
      if (Get.isDialogOpen) {
        Get.back();
      }

      if (postData[0] == 200) {
        Get.offAllNamed('/home');
      }
    } on SocketException {
      ReusableWidgets().noInternet();
    }
  }

  @override
  void onClose() {
    pass?.dispose();
    confPass?.dispose();
    super.onClose();
  }
}
