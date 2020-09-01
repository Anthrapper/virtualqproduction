import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class PasswordResetController extends GetxController {
  final AuthenticationHelper _authenticationHelper = AuthenticationHelper();
  TextEditingController pass;
  TextEditingController confPass;

  @override
  void onInit() {
    pass = TextEditingController();
    confPass = TextEditingController();
    super.onInit();
  }

  Future resetPassword(String pass) async {
    var loginToken = await _authenticationHelper.readAccessToken();
    print(loginToken);
    var data = {'password': pass};
    var headers = {
      'Authorization': 'Bearer $loginToken',
    };
    var response =
        await http.post(Urls.passReset, headers: headers, body: data);
    if (Get.isDialogOpen) {
      Get.back();
    }
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Get.offAllNamed('/home');
    }
  }

  @override
  void onClose() {
    pass?.dispose();
    confPass?.dispose();
    super.onClose();
  }
}
