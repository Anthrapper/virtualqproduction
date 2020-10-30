import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  FlutterLocalNotificationsPlugin notificationsPlugin;
  @override
  void onInit() {
    var initNotification = new AndroidInitializationSettings('icon');
    var initSettings = new InitializationSettings(android: initNotification);
    notificationsPlugin = new FlutterLocalNotificationsPlugin();
    notificationsPlugin.initialize(initSettings,
        onSelectNotification: selectNotification);
    phoneController = TextEditingController();
    passController = TextEditingController();
    super.onInit();
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
      'id',
      'name',
      'description',
      importance: Importance.max,
    );
    var generalDetails = new NotificationDetails(android: android);
    await notificationsPlugin.show(0, 'Not', 'Success', generalDetails);
  }

  Future selectNotification(String payload) async {}
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
