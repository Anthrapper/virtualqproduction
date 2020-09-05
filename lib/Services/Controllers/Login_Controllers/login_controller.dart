import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualQ/Services/api_calls.dart';
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_constants.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class LoginController extends GetxController {
  final AuthenticationHelper _authenticationHelper = AuthenticationHelper();
  TextEditingController phoneController;
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  TextEditingController passController;
  @override
  void onInit() {
    phoneController = TextEditingController();
    passController = TextEditingController();
    super.onInit();
  }

  Future login(String phone, String pass) async {
    var data = {
      "username": phone,
      "password": pass,
    };
    try {
      List postData = await ApiCalls().postRequest(
        body: data,
        url: Urls.loginApi,
        headers: ApiConstants().jsonHeader,
      );
      print(postData);

      if (postData[0] == 200) {
        _authenticationHelper.storeToken(
            postData[1]['access'], postData[1]['refresh']);

        Get.offAllNamed('home');
      } else if (postData[0] == 401) {
        _reusableWidgets.snackBar(
          'Login Failed',
          postData[1]['detail'],
        );
      }
    } on SocketException {
      _reusableWidgets.noInternet();
    }
  }

  @override
  void onClose() {
    phoneController?.dispose();
    passController?.dispose();
    super.onClose();
  }
}
