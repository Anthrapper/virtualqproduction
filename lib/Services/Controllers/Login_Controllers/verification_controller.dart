import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
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
      Get.offAllNamed('/regverification/$phone');
    }
    if (response.statusCode == 404) {
      _reusableWidgets.snackBar(
          'Wrong Number', 'No account exists with the given number');
    }
  }

  @override
  void onClose() {
    phoneController?.dispose();
    super.onClose();
  }
}
