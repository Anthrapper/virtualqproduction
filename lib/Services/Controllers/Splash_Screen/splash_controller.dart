import 'dart:async';
import 'package:get/get.dart';
import 'package:virtualQ/Services/authentication_helper.dart';

class SplashController extends GetxController {
  final AuthenticationHelper _authenticationHelper = AuthenticationHelper();
  @override
  void onStart() {
    checkAuth();
    super.onStart();
  }

  Future checkAuth() async {
    Timer(Duration(milliseconds: 2300), () {
      _authenticationHelper.checkLoginStatus();
    });
  }
}
