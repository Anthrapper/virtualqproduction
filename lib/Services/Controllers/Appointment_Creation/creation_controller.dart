import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtualQ/Services/authentication_helper.dart';
import 'package:virtualQ/Services/functions.dart';
import 'package:virtualQ/UI/widgets/reusable_widgets.dart';
import 'package:virtualQ/utilitis/constants/api_urls.dart';

class TokenCreationController extends GetxController {
  final AuthenticationHelper _authenticationHelper = AuthenticationHelper();
  final ReusableWidgets _reusableWidgets = ReusableWidgets();

  TextEditingController idController;
  var today = new DateTime.now();
  var data = [].obs;
  var timeSlots = [].obs;
  var date = ''.obs;
  var value = ''.obs;
  var hintText = ''.obs;
  var hideTextField = true.obs;
  var selectedDate = false.obs;

  @override
  void onInit() {
    idController = TextEditingController();
    getServiceList();
    super.onInit();
  }

  @override
  void onReady() {
    _reusableWidgets.progressIndicator();
    super.onInit();
  }

  Future selectDate() async {
    DateTime picked = await showDatePicker(
        context: Get.context,
        initialDate: today,
        firstDate: today,
        lastDate: today.add(Duration(days: 7)));
    if (picked != null) {
      value.value = DateFormat('dd-MM-yyyy').format(picked);
      selectedDate.value = true;
    }
  }

  Future getTimeSlots(String id) async {
    var loginToken = await _authenticationHelper.checkTokenStatus();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    var url = Urls.timeSlotBase + id + Urls.timeSlot;
    print(url);
    try {
      var res = await http.get(
        url,
        headers: requestHeaders,
      );
      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);
        print(resBody);

        timeSlots.value = resBody;
        if (Get.isDialogOpen) {
          Get.back();
        }
      } else {
        throw Exception("Failed to get time slots");
      }
    } on SocketException {
      _reusableWidgets.noInternet();
    }
  }

  Future getServiceList() async {
    var loginToken = await _authenticationHelper.checkTokenStatus();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    var url =
        Urls.banks + Urls.branches + Get.parameters['branch'] + Urls.services;
    print(url);
    var res = await http.get(
      url,
      headers: requestHeaders,
    );
    if (res.statusCode == 200) {
      var resBody = json.decode(res.body);
      print(resBody);

      data.value = resBody;
      if (Get.isDialogOpen) {
        Get.back();
      }
    } else {
      throw Exception("Failed to get Services");
    }
  }

  widgetCheck(int id) {
    for (var one in data.value) {
      if (one['id'] == id) {
        List services = one['service']['service_requirements'];

        if (services.isNotEmpty) {
          print('text field required');
          hintText.value =
              (one['service']['service_requirements'][0]['doc_name']);
          print(hintText.value);
          hideTextField.value = false;
        } else {
          print('no doc req');
          hideTextField.value = true;
        }
      }
    }
  }

  Future generateToken({String date, String id, String doc}) async {
    var loginToken = await _authenticationHelper.checkTokenStatus();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };

    Map data = {
      "token_date": date,
      "service": id,
      "doc_ids": "{ 'id': $doc}",
    };

    var response = await http.post(
      Urls.tokenGen,
      body: jsonEncode(data),
      headers: requestHeaders,
    );
    print(Urls.tokenGen);
    var jsonData = json.decode(response.body);
    print(jsonData);
    print(response.statusCode);
    if (response.statusCode == 201) {
      _reusableWidgets.okButtonDialog('Success', 'Token Generated Successfully',
          gotoHome, Icons.assignment_turned_in);
    } else if (response.statusCode == 400) {
      _reusableWidgets.okButtonDialog('Failed', jsonData['message'][0],
          ReusableFunctions().pop, Icons.error);
    } else {
      throw Exception('failed to generate token');
    }
  }

  gotoHome() {
    Get.offAllNamed('/home');
  }
}
