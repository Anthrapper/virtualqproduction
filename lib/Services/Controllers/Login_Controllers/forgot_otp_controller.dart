import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class ForgotOtpController extends GetxController {
  final storage = new FlutterSecureStorage();

  final ReusableWidgets _reusableWidgets = ReusableWidgets();

  @override
  void onInit() {
    phoneController = TextEditingController();
    super.onInit();
  }

  TextEditingController phoneController;
  Future getOtp() async {
    Map data = {
      "contact": Get.parameters['phone'],
    };

    try {
      var response = await http.post(
        Urls.forgotPassOtp,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      var jsonData = json.decode(response.body);
      print(jsonData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'An Otp has been sent to your number',
          snackPosition: SnackPosition.BOTTOM,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
        );
      } else {
        throw Exception('Unknown error');
      }
    } on SocketException {
      _reusableWidgets.noInternet();
    }
  }

  Future verifyOtp(String otp, String phone) async {
    print(phone);
    Map data = {
      "token": otp,
      "contact": phone,
    };

    var response = await http.post(
      Urls.passwordTokenGen,
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
      if (jsonData['status'] == 'failed') {
        _reusableWidgets.snackBar(
            'Wrong Otp', 'Wrong otp provided, please try again');
      }
    }
    if (response.statusCode == 200) {
      if (jsonData['status'] == 'verified') {
        await storage.write(key: 'accesstoken', value: jsonData['access']);
        await storage.write(key: 'refreshtoken', value: jsonData['refresh']);

        Get.offAllNamed('/passwordreset');
      }
    }
  }

  @override
  void onClose() {
    phoneController?.dispose();
    super.onClose();
  }
}
