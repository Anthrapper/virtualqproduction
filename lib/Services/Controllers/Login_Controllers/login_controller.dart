import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
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
    Map data = {
      "username": phone,
      "password": pass,
    };
    try {
      var response = await http.post(
        Urls.loginApi,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      var jsonData = json.decode(response.body);
      print(jsonData);
      print(response.statusCode);
      if (Get.isDialogOpen) {
        Get.back();
      }

      if (response.statusCode == 200) {
        _authenticationHelper.storeToken(
            jsonData['access'], jsonData['refresh']);

        Get.offAllNamed('home');
      } else if (response.statusCode == 401) {
        if (jsonData['detail'] ==
            'No active account found with the given credentials') {
          _reusableWidgets.snackBar(
            'Login Failed',
            'Unable to login with given credentials',
          );
        }
      } else {
        throw Exception('Something Went Wrong');
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
