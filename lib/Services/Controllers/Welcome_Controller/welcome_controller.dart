import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var buttonOneColor = Colors.indigo.obs;
  var buttonTwoColor = Colors.grey.obs;

  changeColorOne() {
    buttonOneColor.value = Colors.indigo;
    buttonTwoColor.value = Colors.grey;
  }

  changeColorTwo() {
    buttonTwoColor.value = Colors.indigo;
    buttonOneColor.value = Colors.grey;
  }
}
