import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtualq/UI/widgets/reusable_widgets.dart';
import 'package:virtualq/utilitis/constants/api_urls.dart';

class SignupController extends GetxController {
  final ReusableWidgets _reusableWidgets = ReusableWidgets();
  TextEditingController phoneController;
  TextEditingController passController;
  TextEditingController nameController;
  TextEditingController confController;
  @override
  void onInit() {
    phoneController = TextEditingController();
    passController = TextEditingController();
    nameController = TextEditingController();
    confController = TextEditingController();
    super.onInit();
  }

  signUp(String phone, String name, String password) async {
    Map data = {
      "contact": phone,
      "name": name,
      "password": password,
    };

    try {
      var response = await http.post(
        Urls.signUp,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      if (Get.isDialogOpen) {
        Get.back();
      }
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (response.statusCode == 201) {
        String phone = phoneController.text;
        Get.offAllNamed('/regverification/$phone');
      } else if (response.statusCode == 400) {
        if (jsonData['non_field_errors'][0] == 'contact already taken') {
          _reusableWidgets.snackBar(
            'Registration Failed',
            'Contact Already exists, please verify or login',
            Icons.error,
          );
        }
      }
    } on SocketException {
      _reusableWidgets.noInternet();
    }
  }

  @override
  void onClose() {
    phoneController?.dispose();
    passController?.dispose();
    nameController?.dispose();
    confController?.dispose();
    super.onClose();
  }
}
